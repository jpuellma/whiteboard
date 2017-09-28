Configuration Management with Ansible
-

- I recommend Ansible here mostly because it doesn't require installing special
 agent software on the target hosts, so it keeps the pieces a bit smaller and
 more compact. There is no reason why Puppet or another config management system
 couldn't be used instead. If these images don't need any complicated
 configurations and are meant to be destroyed and rebuilt frequently, a shell
 script provisioner would probably wokd just as well and could be easier to
 manage.
