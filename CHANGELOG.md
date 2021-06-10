# Changelog for win_openssh

## v0.3.0 - 2021-06-11

* Fixes localisation issues when the `SYSTEM` or `Administrators` group are spelt differently
* Fixes current user name translation - https://github.com/jborean93/ansible-role-win_openssh/issues/11
* Added `opt_openssh_powershell_subsystem` to set the PowerShell Remoting SSH subsystem


## v0.2.0 - 2019-12-27

* Added the `opt_openssh_zip_file` and `opt_openssh_zip_remote_src` option to add another way to source the OpenSSH zip archive.
* By default this role will remove the `AuthorizedKeysFile __PROGRAMDATA__/ssh/administrators_authorized_keys` entry in `sshd_config` so Administrators on the host do not use a shared key. This can be controlled with `opt_openssh_shared_admin_key` if you wish to use the shared location.
* Added the `opt_openssh_default_shell`, `opt_openssh_default_shell_command_option`, and `opt_openssh_default_shell_escape_args` options to control the shell invocation options.


## v0.1.0 - 2018-10-31

* Initial version for the `win_openssh` role
