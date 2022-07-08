FROM ubuntu:22.04

#
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    git \
    cmake \
    build-essential \
    python3-dev \
    flex bison \
    graphviz \
    python3-pip \
    pandoc \
    doxygen \
    texlive-latex-base  \
    texlive-fonts-recommended \
    texlive-fonts-extra \
    texlive-latex-extra \
    gosu

RUN pip install gherkin-official
RUN pip install tabulate
RUN pip install PyYAML

RUN cd / && git clone https://github.com/jothepro/doxygen-awesome-css.git

#
WORKDIR /setup
COPY . /setup/gherkin-paperwork
WORKDIR /setup/gherkin-paperwork
RUN chmod +x ./package-build.sh
RUN ./package-build.sh
RUN chmod +x ./package-install.sh
RUN ./package-install.sh



#
WORKDIR /workdir

COPY ./container-entrypoint /container-entrypoint
RUN chmod +x /container-entrypoint
ENTRYPOINT [ "/container-entrypoint" ]
