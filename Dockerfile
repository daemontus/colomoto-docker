FROM colomoto/colomoto-docker-base
MAINTAINER CoLoMoTo Group <contact@colomoto.org>

## NuSMV  - http://nusmv.fbk.eu/     https://github.com/colomoto/colomoto-conda
## Clingo - https://potassco.org/    https://github.com/colomoto/colomoto-conda
## MaBoSS - https://maboss.curie.fr  https://github.com/colomoto/colomoto-conda
RUN conda install --no-update-deps  -y \
        nusmv=2.6.0 \
        clingo=5.2.2 \
        maboss=2.0 \
    && conda clean -y --all && rm -rf /opt/conda/pkgs


## GINsim - http://ginsim.org/             https://github.com/colomoto/colomoto-conda
## Pint - http://loicpauleve.name/pint     https://github.com/pauleve/pint
RUN conda install --no-update-deps -y \
        ginsim=2.9.7 \
        pint=2017.12.19 \
    && conda clean -y --all && rm -rf /opt/conda/pkgs


## Python interfaces with Jupyter integration
## Colomoto-jupyter - https://github.com/colomoto/colomoto-jupyter  https://github.com/colomoto/colomoto-conda
## GINsim-python    - https://github.com/ginsim/ginsim-python       https://github.com/colomoto/colomoto-conda
## pyPint           - http://loicpauleve.name/pint                  https://github.com/pauleve/pint
RUN conda install --no-update-deps -y \
        colomoto_jupyter=0.4.4 \
        ginsim-python=0.2.94 \
        pymaboss=0.5 \
        pypint=1.3.94 \
    && conda clean -y --all && rm -rf /opt/conda/pkgs \
    && pip install boolean.py       # extra dependencies

## Tutorials for individual tools
COPY tutorials /notebook/tutorials

COPY validate.sh /usr/local/bin/
RUN validate.sh

ARG IMAGE_NAME
ARG IMAGE_BUILD_DATE
ARG BUILD_DATETIME
ARG SOURCE_COMMIT
ENV DOCKER_IMAGE=$IMAGE_NAME \
    DOCKER_BUILD_DATE=$IMAGE_BUILD_DATE \
    DOCKER_SOURCE_COMMIT=$SOURCE_COMMIT
LABEL org.label-schema.build-date=$BUILD_DATETIME \
    org.label-schema.name="The CoLoMoTo docker" \
    org.label-schema.url="http://colomoto.org/" \
    org.label-schema.vcs-ref=$SOURCE_COMMIT \
    org.label-schema.vcs-url="https://github.com/colomoto/colomoto-docker" \
    org.label-schema.schema-version="1.0"


