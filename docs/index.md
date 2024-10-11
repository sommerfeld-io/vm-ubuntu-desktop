# Ubuntu Desktop Virtual Machine
[doc-website]: https://sommerfeld-io.github.io/vm-ubuntu-desktop
[github-repo]: https://github.com/sommerfeld-io/vm-ubuntu-desktop
[file-issues]: https://github.com/sommerfeld-io/vm-ubuntu-desktop/issues
[project-board]: https://github.com/orgs/sommerfeld-io/projects/1/views/17

This project is a collection of scripts and configuration files to setup a Ubuntu Desktop VM. The VM is not managed through Vagrant.

- [Documentation Website][doc-website]
- [Github Repository][github-repo]
- [Where to file issues][file-issues]
- [Project Board for Issues and Pull Requests][project-board]

## Requirements and Features
Automated and fully reproducible setup of a Ubuntu Desktop VM making the virtual machine ready for development. By doing this, the virtual machine becomes disposable and can be recreated at any time.

## Provisioning
Trigger the provisioning of the VM from a bootstrap script. The script installs all needed packages and configures the VM. However, some manual steps after running the script might still remain.

A prerequisite is that the VM has internet access and `curl` installed.

- [ ] Run Bootstrap script:
    ```
    curl https://raw.githubusercontent.com/sommerfeld-io/vm-ubuntu-desktop/refs/heads/main/components/provision/bootstrap.sh | bash -
    ```
- [ ] Git might still need some configuration - e.g. `git config --global user.email sebastian@sommerfeld.io` and `git config --global user.name sebastian`.
- [ ] Configure public key on GitHub to allow cloning repositories, pulling and pushing via ssh.

## Contact
Feel free to contact me via <sebastian@sommerfeld.io> or [raise an issue in this repository][file-issues].
