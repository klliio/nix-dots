#!/bin/sh

# ./backup.sh [options] [target] [destination]
#
# -t   --transfer  transfer files
# -b   --backup    backup files
#      --target    target directory
#      --dest      destination directory
#      --remote    remote to rsync to

error () {
    notify-send "Backup" "Error starting transfer" -a "backup.sh"
    printf "\nEncountered an error\n"
    return
    exit
    printf "\n\nBIG error\n\n"
}

# default options
transfer=false
backup=false
target=""
dest=""
remote=""

while [ "$#" -gt 0 ]; do
    arg="$1"
    case "$1" in
        --*'='*) shift; set -- "${arg%%=*}" "${arg#*=}" "$@"; continue;;
        -t|--transfer) transfer=true;;
        -b|--backup) backup=true;;
        --target) shift; target="$1";;
        --dest) shift; dest="$1";;
        --remote) shift; remote="$1";;
        *) break;;
    esac
    shift
done

if [ "$backup" = true ]; then
    notify-send "Backup" "Starting compression" -a "backup.sh"

    # add directories to backup here
    ZSTD_NBTHREADS=0 tar -I "zstd -19" -cf /home/klliio/Backups/obsidian-$(date +%Y-%m-%dT%H-%M-%S%z).tar.zst /home/klliio/Obsidian/
    ZSTD_NBTHREADS=0 tar -I "zstd -19" -cf /home/klliio/Backups/config-$(date +%Y-%m-%dT%H-%M-%S%z).tar.zst /home/klliio/.config/
    ZSTD_NBTHREADS=0 tar -I "zstd -19" -cf /home/klliio/Backups/passwords-$(date +%Y-%m-%dT%H-%M-%S%z).tar.zst /home/klliio/Passwords/
fi

if [ "$transfer" = true ]; then
   if [ "$target" = "" ] || [ "$dest" = "" ]; then
       error
   fi

   if ! [ "$remote" = "" ]; then
    notify-send "Backup" "Starting transfer" -a "backup.sh"
       ip="$(printf $remote | cut -f2 -d'@')"
       if [ "$(nc -zv $ip 22 2>&1 | grep [C-c]onnected)" ]; then
           echo "$target"
           echo "$remote"
           echo "$dest"
           rsync -atv "$target" "$remote:$dest"
       fi
   else
       rsync -atv "$target" "$dest"
   fi
fi
