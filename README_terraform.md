Provisioning With Terraform
-

- Start with a fresh GitHub repo. Use a Makefile that abstracts the details so
users can just `make deploy` when needed.

- Here's a proof-of-concept terraform config that deploys an app server and a
 database server: [main.tf](main.tf)

- The `main.tf` shown here actually uses remote execution to install rails and
 mariadb but the more complete solution would actually use something like
 Ansible of Puppet for this.

- A variable is used for `ami_id` and a more complete solution would use more
 variables for things like `key_name` and `security_groups` as well, since these
 would need to vary for different user credentials to be able to work without
 interfering with each other.

- If more control is needed over how this is executed, a Jenkins job should be
 created which the users can invoke when they need a new stack deployed. The
 Jenkins job could have access to the AWS credentials and could be configured to
 enforce restrictions on when and where stacks are deployed and under which
 security groups and network ACLs, etc.

- The `ami_id` will need to be retrieved whenever a new stack is deployed. The
 upstream image builder should be configured to put this somewhere the
 downstream consumers can fetch it. Updating the correct value in a web page,
 file server, git repo, or jenkins artifact would all work equally well, based
 on how _Hello World Inc._ wants to use the solution.
