# .devcontainer
This repository contains a Docker file and a configuration for VS Code - Dev Containers. With the help of this repository, all other repositories can be opened in a Docker, and via Dev Containers development is easier (all repositories are mounted on the Docker), since Dev Containers allow code modification in real time.

## Issue 
It might happen that the `"USER_UID"` and `"USER_GID"` - hardcoded in [devcontainer.json](./devcontainer.json) do not match the host machine's ids.
In this case the `"USER_UID"` and `"USER_GID"` in [devcontainer.json](./devcontainer.json) must be specified accordingly. 

To find the UID and GID of the host:
```bash
id -u
id -g
```


## Important
All the repositories of the project has to be cloned before running Docker.
Note that the cloning process assumes that the git user uses *ssh* key for the authentication to github. 

### Cloning
Navigate to the project folder. In case the terminal is opened in the `.devcontainers`:

```bash
cd ..
```

else 

```bash
#In the project folder

git clone git@github.com:Robust-Rail-NL/robust-rail-generator.git
git clone git@github.com:Robust-Rail-NL/robust-rail-solver.git
git clone git@github.com:Robust-Rail-NL/robust-rail-evaluator.git
```

Open the project folder in VS Code.


## Dev-Container setup
The usage of **[Dev-Container](https://code.visualstudio.com/docs/devcontainers/tutorial)** is highly recommended in macOS environment. Running **VS Code** inside a Docker container is useful, since it allows compiling and use cTORS without platform dependencies. In addition, **Dev-Container** allows to an easy to use dockerized development since the mounted `ctors` code base can be modified real-time in a docker environment via **VS Code**.

* 1st - Install **Docker**

* 2nd - Install **VS Code** with the **Dev-Container** extension. 

* 3rd - Open the project in **VS Code**

* 4th - `Ctrl+Shif+P` → Dev Containers: Rebuild Container (it can take a few minutes) - this command will use the [Dockerfile](.devcontainer/Dockerfile) and [devcontainer.json](.devcontainer/devcontainer.json) definitions unde [.devcontainer](.devcontainer).

* 5th - Build process of the 
    * [robust-rail-evaluator](https://github.com/Robust-Rail-NL/robust-rail-evaluator)
    * [robust-rail-solver](https://github.com/Robust-Rail-NL/robust-rail-solver)
    * [robust-rail-generator](https://github.com/Robust-Rail-NL/robust-rail-generator)

Note: all the dependencies are already contained by the Docker instance. 

**Building the Dockerfile might take a few minutes (~10 minutes)**.

## Speed up Docker build - (Linux only)
Linux users can speed up the build process. Open [Dockerfile](./Dockerfile): modify `FROM --platform=linux/amd64 ubuntu:20.04` to `FROM ubuntu:20.04`. 
The `--platform=linux/amd64` has been added because new macOS versions did not support the installation of .NET-8 tools, without this specific flag. 

