FROM quay.io/jupyter/julia-notebook:julia-1.12.1

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
#RUN mamba install --yes --file /tmp/requirements.txt
# NOTE: remove this workaround once https://github.com/conda-forge/qiskit-aer-feedstock/issues/64 is fixed
RUN set -eux; \
    arch="$(dpkg --print-architecture)"; \
    if [ "$arch" = "arm64" ]; then \
        # Extract qiskit-aer version from requirements.txt
        QISKIT_AER_VERSION="$(awk -F'==' '/^qiskit-aer==/ {print $2}' /tmp/requirements.txt)"; \
        # Remove qiskit-aer line so mamba doesn't try to solve/install it
        sed -i '/^qiskit-aer==/d' /tmp/requirements.txt; \
        # Install remaining requirements with mamba
        mamba install --yes --file /tmp/requirements.txt; \
        # Install qiskit-aer via pip for arm64
        [ ! -z "$QISKIT_AER_VERSION" ] && python -m pip install "qiskit-aer==${QISKIT_AER_VERSION}"; \
    else \
        # Non-arm64: standard mamba install
        mamba install --yes --file /tmp/requirements.txt; \
    fi

# Copy Julia Project files to the root directory of the container
COPY Project.toml  /opt/julia/environments/v1.12/
#COPY Manifest.toml /opt/julia/environments/v1.12/

# Install Julia kernel & precompiled packages
ENV JULIA_NUM_THREADS=auto
RUN set -eux; \
    arch="$(dpkg --print-architecture)"; \
    # Set the proper CPU target for Julia, see https://github.com/docker-library/julia/issues/79
    case "$arch" in \
        'amd64') \
            export JULIA_CPU_TARGET="generic;sandybridge,-xsaveopt,clone_all;haswell,-rdrnd,base(1)"; \
            ;; \
        'arm64') \
            export JULIA_CPU_TARGET="generic;cortex-a57;thunderx2t99;carmel"; \
            ;; \
        *) \
            echo >&2 "error: current architecture ($arch) is not supported in this container"; \
            exit 1; \
            ;; \
    esac; \
    source /home/${NB_USER}/.profile && julia -e 'using Pkg; Pkg.Registry.add("General"); Pkg.resolve(); Pkg.instantiate()';

# Cleanup
USER root
RUN rm /tmp/requirements.txt
USER $NB_USER
