# Ubuntu Desktop Virtual Machine
[doc-website]: https://sommerfeld-io.github.io/vm-ubuntu-desktop
[github-repo]: https://github.com/sommerfeld-io/vm-ubuntu-desktop
[file-issues]: https://github.com/sommerfeld-io/vm-ubuntu-desktop/issues
[project-board]: https://github.com/orgs/sommerfeld-io/projects/1/views/1?sliceBy%5Bvalue%5D=sommerfeld-io%2Fvm-ubuntu-desktop

This project is a collection of scripts and configuration files to setup a Ubuntu Desktop VM.

- [Documentation Website][doc-website]
- [Github Repository][github-repo]
- [Where to file issues][file-issues]
- [Project Board for Issues and Pull Requests][project-board]

## Requirements and Features
Automated and fully reproducible setup of a Ubuntu Desktop VM making the virtual machine ready for development. By doing this, the virtual machine becomes disposable and can be recreated at any time.

The VM represents a sandbox and development environment for Kubernetes-related tasks, proof-of-concepts and experiments. The bootstrap script installs Docker and minikube (among other tools).

## Provisioning
The provisioning is done by a bootstrap script. The script installs all needed packages and configures the VM. However, some manual steps after running the script might still remain.

A prerequisite is that the VM has internet access and `curl` installed.

- Run Bootstrap script:
    ```bash
    sudo curl -fsSL https://raw.githubusercontent.com/sommerfeld-io/vm-ubuntu-desktop/refs/heads/main/components/provision/bootstrap.sh | bash -
    ```
- Clone this repository from GitHub into `~/work/repos`:
    ```bash
    curl -fsSL https://raw.githubusercontent.com/sommerfeld-io/vm-ubuntu-desktop/refs/heads/main/components/provision/clone.sh
    ```
- Git might still need some configuration - e.g. `git config --global user.email sebastian@sommerfeld.io` and `git config --global user.name sebastian`.
- Configure public key on GitHub to allow cloning repositories, pulling and pushing via ssh.
- Maybe you still need to add your user from inside the VM to the docker group
    ```bash
    sudo usermod -aG docker "$USER"
    ```

## Run locally with Vagrant
To test the provisioning scripts locally, you can use Vagrant. The `Vagrantfile` is already included in this repository. To start/stop the Vagrantbox, simply use the `vagrant.sh` script from the root of this repository (next to the `Vagrantfile`). The `bootstrap.sh` script is used to provision the Vagrantbox.

- Maybe you still need to add the `vagrant` user to the docker group (first connect to the Vagrantbox using `vagrant ssh`)
    ```bash
    sudo usermod -aG docker "$USER"
    ```

## Run Portainer
To start Portainer, download the `docker-compose.yml` file and start all services. The portainer password is written from the `docker-compose.yml` file to the local filesystem when starting the stack. The password is written into `portainer.passwd` next to the `docker-compose.yml`.

```bash
curl -fsSL https://raw.githubusercontent.com/sommerfeld-io/vm-ubuntu-desktop/refs/heads/main/components/portainer/docker-compose.yml -o docker-compose.yml
docker-compose up -d
```

This configuration starts portainer on port `7990`.

## Run minikube
[minikube](https://minikube.sigs.k8s.io) is a tool that simplifies running Kubernetes clusters locally. It allows developers to set up a single-node Kubernetes cluster on their local workstation, which is useful for development, testing, and learning purposes. minikube supports various hypervisors (like VirtualBox, KVM, Hyper-V) and container runtimes (like Docker, Podman, containerd, and CRI-O). By providing a local Kubernetes environment, minikube helps developers emulate the behavior of a production cluster, enabling them to test Kubernetes applications in a controlled, local setup before deploying them to a larger, more complex cluster.

[Helm](https://helm.sh) is a package manager for Kubernetes, designed to streamline the deployment, management, and scaling of applications on Kubernetes clusters. It uses "charts",which are packages of pre-configured Kubernetes resources, to define, install, and upgrade Kubernetes applications. Helm helps automate the deployment process, manage dependencies, and simplify updates and rollbacks, making it easier to manage  Kubernetes applications consistently and reproducibly.

### Prerequisites
minikube requires a virtualization software to run. The default hypervisor is `docker` which is used in this setup.

minikube ships with a `kubectl` binary to interact with the minikube cluster. Keep in mind, that the bootstrap script creates a `kubectl` alias which points to `minikube kubectl` so this might conflict with other `kubectl` installations.

### Interact with minikube
```bash
minikube version
minikube status
helm version

# Startup
minikube start

# Shutdown
minikube stop

# Destroy
minikube delete

# Enable addons
minikube addons enable metrics-server
minikube addons enable dashboard
minikube addons enable ingress

# Expose the minikube dashboard
minikube dashboard

# List pods from all namespaces
kubectl -- get po -A

# List services from all namespaces
minikube service list # --namespace apps
```

### Interact with minikube which runs inside a Vagrantbox
minikube binds itself to `127.0.0.1` (which represents the localhost from inside the Vagrantbox, not from the host). Requests from the host to the VM are not possible unless the `apiserver.bind-address` is changed.

Make sure the Vagrantbox forwards all needed ports to the host.

```bash
# Startup inside Vagrantbox
minikube start --extra-config=apiserver.service-node-port-range=7000-7080 --extra-config=apiserver.bind-address=0.0.0.0

# Expose the minikube dashboard on specified port and without opening the browser
minikube dashboard --port 7000 --url
```

Since the dashboard (despite setting the bind address) still only answers to requests from inside the Vagrantbox, you need an SSH tunnel to the dashboard inside the Vagrantbox.

```bash
vagrant ssh -- -L 7999:localhost:7000
```

`7999` is the port on the host which tunnels to `localhost:7000` inside the Vagrantbox. The port on the host must be a free port, so it cannot be part of the NodePort range.

### Increasing the NodePort range
By default, minikube exposes ports `30000-32767`. If this does not work for you, you can adjust the range by using: `minikube start --extra-config=apiserver.service-node-port-range=1024-65535`

## Contact
Feel free to contact me via <sebastian@sommerfeld.io> or [raise an issue in this repository][file-issues].

<!-- !    DO NOT EDIT DIRECTLY !!!!!                         -->
<!-- !    File is auto-generated by pipeline                 -->
<!-- !    Contents are based on files from docs/about dir    -->
