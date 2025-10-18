podman build . -t openfoam
podman run -it -v "./experiments:/app/src" openfoam