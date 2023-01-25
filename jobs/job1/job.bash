MOUNT_SRC="/mnt/c/Users/DOGNINI/Desktop/capannone/"
MOUNT_DST="//nas1.eurokemical.lan/back-up/PC-UT/borg/backup-ek"
MOUNT_SRC_OPTS="-v --bind"
MOUNT_DST_OPTS="-v -t cifs -o credentials=/root/.borg-backup-cifs-credentials"
LABEL="marcos"

