# minecraft-forge
dockerfile to run and administrate a minecraft forge server easily.

this docker file is base over the minecraft-vanilla available at https://github.com/Timmy80/minecraft-vanilla.
It mean it provides the same features regarding backups, commands, ...

# How to build
## Using the makefile (Only for the latest release of minecraft available with forge)
To build the latest recommended release of minecraft forge:
```bash
$ make
```
To build the latest realease of minecraft forge (not the recommended version):
```bash
$ make forge-latest
```
To clean all minecraft forge running container and minecraft forge images:
```bash
$ make clean
```
You have also an help:
```bash
$ make help
```
## Using docker build (for any version of minecraft)
Example to build the recommended version of forge for minecraft 1.12.1:
```bash
$ docker build --build-arg MINECRAFT_VERSION=1.12.1 FORGE_TARGET=recommended -t overware/minecraft-forge:1.12.1 ./
```

# Want to know more ?

Go checkout the [minecraft-vanilla](https://github.com/Timmy80/minecraft-vanilla).

