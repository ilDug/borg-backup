# borg umount "$MNT" || echo "non è possibile montare il repository"

trap 'echo $( date ) Backup interrupted >&2 | tee -a "$LOGPATH"; exit 2' INT TERM


echo "

######################################################################################################" >> "$LOGPATH"
echo "BORG BACKUP - name: $REPO::$ARCHIVE" >> "$LOGPATH"

# imposta la working directory
cd $SRC

borg create \
    --stats \
    --show-rc \
    --exclude-caches \
    --checkpoint-interval 300 \
    --patterns-from "$PATTERN" \
    "$REPO"::$ARCHIVE \
    .  2>&1 | tee -a "$LOGPATH"
    # --list \
backup_exit=$?


borg check \
    --show-rc \
    --verbose \
    $REPO::$ARCHIVE 2>&1 | tee -a "$LOGPATH"
check_exit=$?


borg prune \
    -v \
    --list \
    --show-rc \
    --keep-daily=7 \
    --keep-weekly=4 \
    --keep-monthly=-1 \
    $REPO 2>&1 | tee -a "$LOGPATH"
prune_exit=$?


# actually free repo disk space by compacting segments
borg compact "$REPO" 2>&1 | tee -a "$LOGPATH"
compact_exit=$?


# elenca gli archivi dispopnbili nella cartella
borg list $REPO 2>&1 | tee "$LISTPATH"


#MOUNT
# borg mount "$REPO" "$MNT" 


# use highest exit code as global exit code
global_exit=$(( backup_exit > check_exit ? backup_exit : check_exit ))
global_exit=$(( prune_exit > global_exit ? prune_exit : global_exit ))
global_exit=$(( compact_exit > global_exit ? compact_exit : global_exit ))

if [ ${global_exit} -eq 0 ]; then
    echo "$(date -Iseconds) - Backup, Check, Prune, and Compact finished successfully" | tee -a  "$LOGPATH"
elif [ ${global_exit} -eq 1 ]; then
    echo "$(date -Iseconds) - Backup, Prune, and/or Compact finished with warnings" | tee -a  "$LOGPATH"
    echo "WARNING - attenzione alcuni warning durante il backup $REPO::$ARCHIVE" | mail -s "borg backup warning" mdognini@eurokemical.it
else
    echo "$(date -Iseconds) - Backup, Prune, and/or Compact finished with errors" | tee -a  "$LOGPATH"
    echo "ERROR - attenzione alcuni errori durante il backup $REPO::$ARCHIVE" | mail -s "borg backup error" mdognini@eurokemical.it
fi

exit ${global_exit}


#RESTORE
# echo "start restore: $(date -Iseconds)" | tee -a "$LOGPATH"
# cd "$RESTORE"
# borg extract --list $REPO::$ARCHIVE
# echo "restore finished: $(date -Iseconds)" | tee -a "$LOGPATH"
