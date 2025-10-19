#!/bin/bash

IMG="openfoam"

podman build . -t $IMG
podman run -it -v "$(realpath .):/app/src" $IMG pytest tests