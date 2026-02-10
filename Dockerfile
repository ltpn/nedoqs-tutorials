FROM quay.io/jupyter/julia-notebook:julia-1.12.4

# Switch to root user
USER root
ENV DEBIAN_FRONTEND="noninteractive" TZ="UTC"

# Install supporting system packages
RUN export DEBIAN_FRONTEND=noninteractive && apt-get update \
    && apt-get install -y software-properties-common \
    wget unzip ca-certificates git make xvfb ffmpeg \
    && rm -rf /var/cache/apt/archives /var/lib/apt/lists/*

# Switch to notebook user
USER $NB_USER
WORKDIR /home/${NB_USER}

# Install nbgitpuller
RUN mamba install --yes nbgitpuller && mamba clean --yes --all

# Install Python dependencies
COPY requirements.txt /tmp/
RUN mamba install --yes --file /tmp/requirements.txt && mamba clean --yes --all

# Copy Julia Project files to the root directory of the container
COPY Project.toml  ${JULIA_PKGDIR}/environments/v1.12/
COPY LocalPreferences.toml ${JULIA_PKGDIR}/environments/v1.12/
#COPY Manifest.toml ${JULIA_PKGDIR}/environments/v1.12/

# Set user ownership of *toml files
USER root
RUN chown ${NB_UID}:${NB_GID} ${JULIA_PKGDIR}/environments/v1.12/Project.toml ${JULIA_PKGDIR}/environments/v1.12/LocalPreferences.toml
#RUN chown ${NB_UID}:${NB_GID} ${JULIA_PKGDIR}/environments/v1.12/Manifest.toml
USER $NB_USER

# Install Julia kernel & precompiled packages
ENV JULIA_NUM_THREADS=auto
RUN set -eux; \
    arch="$(dpkg --print-architecture)"; \
    # Set the proper CPU target for Julia, see https://github.com/docker-library/julia/issues/79
    case "$arch" in \
        'amd64') \
            export JULIA_CPU_TARGET="generic;sandybridge,-xsaveopt,clone_all;haswell,-rdrnd,base(1);x86-64-v4,-rdrnd,base(1)"; \
            ;; \
        'arm64') \
            export JULIA_CPU_TARGET="generic;cortex-a57;thunderx2t99;carmel,clone_all;apple-m1,base(3);neoverse-512tvb,base(3)"; \
            ;; \
        *) \
            echo >&2 "error: current architecture ($arch) is not supported in this container"; \
            exit 1; \
            ;; \
    esac; \
    source /home/${NB_USER}/.profile && julia -e 'using Pkg; Pkg.Registry.add("General"); Pkg.resolve(); Pkg.instantiate(); using CUDA; CUDA.precompile_runtime()';

# Make sure we have the right user permissions.
# For some reason, this is not always already the case for /opt/julia/scratchspaces;
# this impacts GPU execution in multi-user Docker setups, as the runtime is precompiled there.
RUN fix-permissions ${JULIA_PKGDIR}/scratchspaces

# Cleanup
USER root
RUN rm /tmp/requirements.txt
USER $NB_USER
