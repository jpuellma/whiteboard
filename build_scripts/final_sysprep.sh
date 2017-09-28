#!/bin/bash -e

# This runs a "sysprep" set of actions on the image after provisioning is
# complete.
#
# This attempts to remove make of the lingering effects of the previous
# provisioning steps.
#
# This does things like zeroing out log files and removing spcaewalk
# registration IDs.
#
# It should only be run at the very end of the image provisioning step, JUST
# prior to final shutdown.
#

# SSH host keys will be deleted.
#
echo "Removing SSH host keys.."
rm -f /etc/ssh/ssh_host_*

# ALL log files will be erased (either deleted or set to 0 bytes).
#
echo "Cleaning up log files..."
find /var/log -type f -name "*-[0-9]*" -exec rm -f {} \;
for i in $( find /var/log -type f ) ; do
    /bin/true > ${i}
done

# /var/tmp/* will be removed.
#
echo "Removing contents of /var/tmp/ ..."
rm -rf /var/tmp/*
