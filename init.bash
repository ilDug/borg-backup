#! /bin/bash
SCRIPT_PATH=$(dirname "$(realpath -s "$0")")
source <(cat "$SCRIPT_PATH/jobs/job1/job.bash" | grep -E '^(\w+)=')
source <(cat "$SCRIPT_PATH/lib/variables.bash" | grep -E '^(\w+)=')

source "$SCRIPT_PATH/mount.bash"

mkdir -p "$REPO"
mkdir -p "$MNT"
mkdir -p "$RESTORE"

cd "$REPO"
borg init --encryption none .

source "$SCRIPT_PATH/lib/umount.bash"
