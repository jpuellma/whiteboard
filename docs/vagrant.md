Provisioning with Vagrant
-

- A new GitHub repo should be created for this.

- A sample Vagrantfile is located here: [Vagrantfile.sample](../Vagrantfile.sample)

- Once the repo is cloned, the README.md should include some brief instructions
 on how to customize the `Vagrantfile.sample` into a proper config.

- This config assumes the vagrant box was automatically uploaded to a repository
 after the most recent successful image build.

- Once customized, a developer should be able to spin up a rails and db server
 with `vagrant up`.

- README should include instructions for how to mount one's local code repository
 into the proper location within the app server so that developers can test
 their code as they are making changes to it and `git push` their commits to
 their repositories once tested.
