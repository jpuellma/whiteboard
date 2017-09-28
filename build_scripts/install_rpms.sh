#!/bin/bash -e

yum -y install epel-release

package_list=" \
    cowsay \
    bind-utils \
    "

yum -y install ${package_list}
