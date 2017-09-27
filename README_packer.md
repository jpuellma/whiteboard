Building the Base OS in packer
-

- Create a new GitHub repo for this.

- Here's a proof-of-concept packer configuration which will build a CentOS 7 ami
in Amazon's US east region: [packer_template.json](packer_template.json).

- The packer template uses variables for things like `region` and `security group` to allow these things to be more easily changed. Variables will be passed to the `packer` process when it is invoked by `make`.

- There are two builders defined: `amazon-ebs` and `vagrant`. This will allow us to create the same image for use in AWS and for local use for any dev who wishes to reproduce the stack on a local laptop.
