#! /bin/bash
SCRIPT_PATH=$(dirname "$(realpath -s "$0")")
# echo $SCRIPT_PATH

source <(cat "$SCRIPT_PATH/jobs/job1/job.bash" | grep -E '^(\w+)=')
source <(cat "$SCRIPT_PATH/lib/variables.bash" | grep -E '^(\w+)=')

source ./lib/mount.bash
source ./lib/umount.bash