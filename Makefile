# vim: set nosmarttab:

.DEFAULT:
	@echo "$@ not implemented yet."

iso_timestamp     ?= $(shell /bin/date +%Y-%m-%dT%H:%M:%S%z)
clean_timestamp   := $(strip $(subst T,t, $(subst :,-, $(iso_timestamp))))

ami_id                  ?= $(shell ./lib/get_ami_id.sh)
AWS_ACCESS_KEY_ID       ?= AWS_ACCESS_KEY_DEFAULT
AWS_SECRET_ACCESS_KEY   ?= AWS_SECRET_ACCESS_KEY_DEFAULT
aws_region              ?= us-east-1
aws_security_group_id   ?= sg-6f82fa1c
aws_source_ami          ?= $(shell aws --region us-east-1 ec2 describe-images --filters "Name=name,Values=CentOS Linux 7*" "Name=is-public,Values=true" "Name=state,Values=available" "Name=image-type,Values=machine" "Name=product-code.type,Values=marketplace" "Name=virtualization-type,Values=hvm" "Name=architecture,Values=x86_64" --output json | jq '.Images | sort_by(.CreationDate)|.[-1]|.ImageId')
aws_subnet_id           ?= subnet-f32916a9
aws_vpc_id              ?= vpc-2352b15b
build_log               ?= build.$(iso_timestamp).log
iso_checksum            ?= 88c0437f0a14c6e2c94426df9d43cd67
iso_url                 ?= file://$(PWD)/CentOS-7-x86_64-Minimal-1511.iso
packer_template         ?= ./packer_template.json
packer_extra_params     ?=


build_args = $(packer_extra_params) \
	-var 'aws_access_key'=$(AWS_ACCESS_KEY_ID) \
	-var 'aws_region'=$(aws_region) \
	-var 'aws_secret_key'=$(AWS_SECRET_ACCESS_KEY) \
	-var 'aws_security_group_id'=$(aws_security_group_id) \
	-var 'aws_source_ami'=$(aws_source_ami) \
	-var 'aws_subnet_id'=$(aws_subnet_id) \
	-var 'aws_vpc_id'=$(aws_vpc_id) \
	-var 'clean_timestamp'=$(clean_timestamp) \
	-var 'iso_checksum'=$(iso_checksum) \
	-var 'iso_url'=$(iso_url)

packer_validate:
	packer validate $(build_args) $(packer_template)

packer_inspect: packer_validate
	packer inspect $(packer_extra_params) $(packer_template)

ami: packer_validate
	packer build  $(build_args) \
	--only=amazon-ebs \
	$(packer_template) 2>&1 | tee $(build_log)

vagrant: packer_validate
	packer build $(build_args) --force \
	--only=vagrant \
	$(packer_template) 2>&1 | tee $(build_log)

plan:
	terraform plan -var 'ami_id=$(ami_id)'

apply:
	terraform apply -var 'ami_id=$(ami_id)'

image: ami vagrant

clean:
	rm -rf ./*.box ./*.log ./packer_cache ./output-virtualbox-iso*

.PHONY: \
	ami \
	apply \
	clean \
	image \
	packer_inspect \
	packer_validate \
	plan \
	vagrant
