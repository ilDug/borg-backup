source <(cat ./borg.bash | grep -E '^(\w+)=')
mkdir -p "$REPO"
mkdir -p "$MNT"
mkdir -p "$RESTORE"

cd $REPO
borg init --encryption none .