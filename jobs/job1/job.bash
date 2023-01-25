MOUNT_SRC="/mnt/c/Users/DOGNINI/Desktop"
MOUNT_DST="//nas1.eurokemical.lan/back-up/PC-UT/backup-ek"
MOUNT_SRC_OPTS="-v --bind"
MOUNT_DST_OPTS="-v -t cifs -o credentials=/root/.borg-backup-cifs-credentials"
LABEL="marcos"

