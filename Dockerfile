FROM ubuntu:24.04

RUN apt update
RUN apt install -y wget software-properties-common

RUN sh -c "wget -O - https://dl.openfoam.org/gpg.key > /etc/apt/trusted.gpg.d/openfoam.asc"
RUN add-apt-repository http://dl.openfoam.org/ubuntu

RUN apt update

RUN apt -y install openfoam11

RUN cat /opt/openfoam11/etc/bashrc >> /root/.bashrc

# Download the latest installer
ADD https://astral.sh/uv/install.sh /uv-installer.sh

# Run the installer then remove it
RUN sh /uv-installer.sh && rm /uv-installer.sh

# Ensure the installed binary is on the `PATH`
ENV PATH="/root/.local/bin/:$PATH"

COPY pyproject.toml uv.lock .python-version /app/
COPY src /app/src

WORKDIR /app/

RUN uv sync --frozen

ENV PATH="/app/.venv/bin:$PATH"

RUN uv pip install . --no-deps

WORKDIR /app/src