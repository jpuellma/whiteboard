Workflow: Start to Finish
-

The workflow takes two forms: one for Vagrant, and another for AWS. In each
form, the first few steps are the same and the last few steps are the same. Only
the middle portion differs. The flow is presented here in three phases to
highlight what is common and what is different:

### Phase 1 (Common):
1. A delivery engineer makes a config change to the default image config.
1. Jenkins detects the new commit in the git repo, triggers a new packer build.
1. Artifacts of packer build: the ami_id and the vbox file, are handed off to a
downstream job.
1. Downstream job publishes the ami id and vbox on a file server.
    ### Phase 2 (Vagrant Version):
    1. A developer clones the vagrant repo to her local workstation.
    1. Developer customizes the Vagrantfile and runs `vagrant up`.
    1. Vagrant fetches the latest vbox from the file server and spins up two new
    instances on developer's workstation.
    1. Vagrant uses a provisioner to install ruby and rails on the app and mariadb
    on the db instance.
    1. Vagrant mounts the developer's code repository.
    ### Phase 2 (AWS Version):
    1. A developer triggers a Jenkins job to deploy a stack in AWS.
    1. Jenkins validates the user is allowed to provision and determines which
    security groups and ACLs the user should use.
    1. Jenkins retrieves ami id from file server and triggers a `terraform apply`,
    passing variables for security group and ACLs.
    1. Terraform triggers a provisioner to install rails on the app and maridadb on
    the db instance.
    1. The provisioner clones the developer's code repo origin.
### Phase 3 (Common):
1. Dev modifies code, runs tests...
1. Dev commits changes and pushes to origin.
1. Dev submits PR to merge origin into upstream.
1. Travis sees PR, launches test instance.
1. Travis tests run, and pass.
1. PR gets reviewed and merged.
1. Dev destroys vagrants.
