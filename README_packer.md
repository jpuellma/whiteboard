Building the Base OS in Packer
-

- First, create a new GitHub repo for the Packer build.

- Start with a simple `README.md` and `Makefile`. Anyone with sufficient AWS
credentials and locally installed software (detailed in README.md) should be
able to create a new OS image by cloning this repository and running `make
image`.

- Here's a proof-of-concept packer configuration which will build a CentOS 7 ami
in Amazon's US east region: [packer_template.json](packer_template.json).

- The packer template uses variables for things like `region` and `security
group` to allow these things to be more easily changed. Variables will be passed
to the `packer` process when it is invoked by `make`.

- There are two builders defined: `amazon-ebs` and `vagrant`. This will allow us
 to create the same image for use in AWS and for local use for any dev who
 wishes to reproduce the stack on a local laptop.
  - To build in more than one AWS region (say for east and west), the `amazon-ebs`
    builder would just be duplicated into two builders: `amazon-ebs-east` and
    `amazon-ebs-west`.
  - New builders for other platforms are easily added in case _Hello World Inc._
    ever decides to try Azure or Digital Ocean or GCP, etc.

- The scripts in `build_scripts` are invoked as a shell provisioner to customize
  the build per _Hello World Inc._'s requirements.

-  The scripts in `test_scripts` are invoked as a second shell provisioner _after_
  the build completes. Each of these scripts is intended to test some required
  functionality that the build *must* have before being validated as a "good
  build".
   - If any script in _either_ provisioner returns an error result, the entire
     build will be considered a fail.

- The `lib/get_ami.sh` script is intended to be a helper utility to ouput the ami
  ID(s) of the successful image builds.

### Automation

Create a Jenkins job that runs either on a schedule or on demand. The job should
pull the latest contents of the git repo and run `make image`. The `make`
process should output correct values to indicate success or failure of the job.

Upon image build completion, the `lib/get_ami_id.sh` utility should be run so
any downstream jobs will know which ami to work from.

There should be a downstream job that uploads the resulting `.vbox` vagrant
image to a repository the developers can reach.

The build can run automatically on a regular basis as long as the testing
scripts are robust enough to detect  when a build won't meet developers'
requirements.
