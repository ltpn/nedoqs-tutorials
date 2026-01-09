FROM quay.io/jupyter/julia-notebook:julia-1.12.3

# Switch to root user
USER root
ENV DEBIAN_FRONTEND="noninteractive" TZ="UTC"

# Install supporting system packages
RUN export DEBIAN_FRONTEND=noninteractive && apt-get update \
    && apt-get install -y software-properties-common \
    wget unzip ca-certificates git make xvfb ffmpeg

# Switch to notebook user
USER $NB_USER
WORKDIR /home/${NB_USER}

# Install nbgitpuller
RUN mamba install --yes nbgitpuller

# Install Python dependencies
COPY requirements.txt /tmp/
RUN mamba install --yes --file /tmp/requirements.txt

# Copy Julia Project files to the root directory of the container
COPY Project.toml  /opt/julia/environments/v1.12/
COPY LocalPreferences.toml /opt/julia/environments/v1.12/
#COPY Manifest.toml /opt/julia/environments/v1.12/

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

# Cleanup
USER root
RUN rm /tmp/requirements.txt
USER $NB_USER
