podman build . -t openfoam
podman run -it -v "./experiments:/experiments" openfoam