# Ansible Role win_openssh

[![Build status](https://ci.appveyor.com/api/projects/status/lwrvmyce3awiopsu?svg=true)](https://ci.appveyor.com/project/jborean93/ansible-role-win-openssh)
[![win_openssh Ansible Galaxy Role](https://img.shields.io/ansible/role/31890.svg)](https://galaxy.ansible.com/jborean93/win_openssh)

Installs [Win32-OpenSSH](https://github.com/PowerShell/Win32-OpenSSH) on a
Windows host.

_Note: This role has been tested on Win32-OpenSSH v7.7.2.0p1-Beta, newer versions should work but this is not guaranteed_

With the defaults this role will;

* Install `Win32-OpenSSH` to `C:\Program Files\OpenSSH` based on the latest release available on GitHub
* Setup the `sshd` and `ssh-agent` services and set them to auto start
* Create a firewall rule that allows inbound traffic on port `22` for the `domain` and `private` network profiles
* Configures the `sshd_config` file to allow public key and password authentication

The following can also be configured as part of the role but require some
optional variables to be set;

* Specify a specific version to download from GitHub or another URL that points to the zip
* Specify where to install the binaries
* Control whether to setup the SSH server services
* Control whether to set the SSH services to auto start
* Define the firewall profiles to allow inbound ssh traffic
* Specify the port and other select sshd\_config values
* Add a public key(s) to the current user's profile


## Requirements

* Windows Server 2008 R2+


## Variables

### Mandatory Variables

None, this role will run with the default options set.

### Optional Variables

* `opt_openssh_architecture`: The Windows architecture, must be set to either `32` or `64` (default: `64`).
* `opt_openssh_firewall_profiles`: The firewall profiles to allow inbound SSH traffic (default: `domain,private`).
* `opt_openssh_install_path`: The directory to install the OpenSSH binaries (default: `C:\Program Files\OpenSSH`).
* `opt_openssh_pubkeys`: Either a string or list of strings to add to the user's `authorized_keys` file, by default no keys will be added.
* `opt_openssh_setup_service`: Whether to install the sshd service components or just stick with the client executables (default: `True`).
* `opt_openssh_skip_start`: Will not start the `sshd` and `ssh-agent` service and also not set to `auto start` (default: `False`).
* `opt_openssh_temp_path`: The temporary directory to download the downloaded zip and extracted files (default: `C:\Windows\TEMP`).
* `opt_openssh_url`: Sets the download location of the OpenSSH zip, if omitted then this will be sourced from the GitHub repository.
* `opt_openssh_version`: Sets a specific version to download from GitHub, this is only valid when `opt_openssh_url` is not set (default: `latest`)

You can also customise the following sshd\_config values:

* `opt_openssh_port`: Aligns to `Port`, the port the SSH service will listen on (default: `22`).
* `opt_openssh_pubkey_auth`: Aligns to `PubkeyAuthentication`, whether the SSH service will allow authentication with SSH keys (default: `True`).
* `opt_openssh_password_auth`: Aligns to `PasswordAuthentication`, whether the SSH service will allow authentication with passwords (default: `True`).

### Output Variables

None


## Role Dependencies

None


## Example Playbook

```
- name: install Win32-OpenSSH with the defaults
  hosts: windows
  gather_facts: no
  roles:
  - jborean93.win_openssh

- name: install specific version of Win32-OpenSSH to custom folder
  hosts: windows
  gather_facts: no
  roles:
  - role: jborean93.win_openssh
    opt_openssh_install_path: C:\OpenSSH
    opt_openssh_version: v7.7.2.0p1-Beta

- name: only install client components of Win32-OpenSSH
  hosts: windows
  gather_facts: no
  roles:
  - role: jborean93.win_openssh
    opt_openssh_setup_service: False
```


## Backlog

None - feature requests are welcome

