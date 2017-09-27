 Whiteboard Exercise
 =

**Goal:**
Recommend a set of solutions to allow devs at _Hello World Inc._ to easily and
reliably reproduce their app environment. The solutions should allow for local
development and should allow for leverage of AWS cloud platform. Provisioning a
new dev platform should be easy and should produce consistent results every
time.

## Use Packer to build a standard OS image.
Start everything from a single _standardized_ base OS image which includes
updated versions of all the standard software common to _Hello World Inc._
systems.

We will use Packer for this because we can produce a virtually-identical OS
build image on multiple cloud platforms and virtualization platforms.

The details of this part of the solution are described in

* Details: [README_packer.md](README_packer.md)

## Use Terraform to deploy instances in AWS.
Once there is a standard ami to build from, Terraform should allow anyone who
needs to deploy or re-deploy a stack to do so with minimal input and practically
zero knowledge of the AWS platform.

* Details: [README_terraform.md](README_terraform.md)

## Use Vagrant to deploy instances locally.
If done well, the Packer process will produce a Vagrant `.box` output with the
same software and configuration as the ami Terraform uses to deploy a stack.
This means we can produce the same set of servers locally on our laptops and any
code that runs on the Vagrant stack should run the same as on the AWS stack, and
vice-versa.

* Details: [README_vagrant.md](README_vagrant.md)


## Use Ansible to configure app and db services.
The Packer build will only produce a base OS image. The base image itself will
not have Ruby/Rails or MySQL installed. Once the stack is deployed with
Terraform or Vagrant, Ansible will be invoked to remediate the base OS and
convert it into a proper app/db server by installing the correct software and
configuration.

This won't be invoked separately; the Terraform and Vagrant configurations will
include Ansible as part of their provisioning process.

**Alternative:**
Puppet, or Chef, or anything that works. I recommend Ansible here based only on
personal preference. Puppet will work just fine as well, but that would require
installing it in the base OS image.

* Details: [README_Ansible.md](README_ansible.md)


## Use GitHub to manage code repositories.
This makes things much easier for several reasons. Being able to track changes
and collaborate on code in a dsitributed way has obvious merits.

In addition to these, standardizing on `git` as a repo means being able to take
advantage of integrations with other tools like `Travis` or `Drone` or
`Jenkins`.

**Alternative:**
Stash, BitBucket, Google Cloud Source, Amazon CoceCommit, others... I recommend
GitHub becaue I'm most familiar with it, although Stash is a fine solution as
well. Amazon CodeCommit may have some benefits simply due to its pedigree as an
Amazon product, but I don't know what these would be as I've not used it yet.

* Details: [README_github.md](README_github.md)

## Use Jenkins to orchestrate new image builds.
Especially for the base OS image creation, but also for other operational tasks
that will no doubt come up in this workflow, a tool like Jenkins should be used
to govern the execution fo the build and deploy jobs.

**Alternative:**
Atlassian Bamboo, others, probably? Travis and Drone are not perfect for this.
Circle CI might be but I am not familiar enough to say.

* Details: [README_jenkins.md](README_jenkins.md)

## Miscellaneous

asdf
