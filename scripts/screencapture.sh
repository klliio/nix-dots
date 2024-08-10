#!/usr/bin/env bash

# end recording
if [ -n "$(pgrep wf-recorder)" ]; then
    pkill --signal SIGINT wf-recorder
    notify-send "Screen capture" "Ended capture"
    exit 0
fi

dir="$HOME/Videos/"
background="FFFFFF46"
border="00000076"
select="00000010"

while [ "$#" -gt 0 ]; do
    arg="$1"
    case "$1" in
    --*'='*)
        shift
        set -- "${arg%%=*}" "${arg#*=}" "$@"
        continue
        ;;
    --background)
        shift
        background="$1"
        ;;
    --border)
        shift
        border="$1"
        ;;
    --select)
        shift
        select="$1"
        ;;
    --dir)
        shift
        dir="$1"
        ;;
    *) break ;;
    esac
    shift
done

while true; do
    # get filename with the extension
    filename=$(find "$dir" -maxdepth 1 -type f -printf "%f\n" | sed -E 's/\.[a-zA-Z0-9]*//' | fuzzel -d)
    # check if a name was entered
    if [ -z "$filename" ]; then
        notify-send "Screen capture" "No filename entered"
        exit 1
    fi

    # if the file exists
    if [ -f "$dir$filename".mp4 ]; then
        choice=$(printf "Rename\nReplace\nKeep & ignore" | fuzzel -d)
        case "$choice" in
        "Rename") continue ;;
        "Replace")
            rm "$dir$filename.mp4"
            notify-send "Screen capture" "Replacing the existing capture"
            break
            ;;
        *)
            notify-send "Screen capture" "No action taken"
            exit 1
            ;;
        esac
    else
        break
    fi
done

# start capture
selection=$(printf "Region\nFullscreen" | fuzzel -d)
case "$selection" in
"Region")
    wf-recorder --geometry "$(slurp -d -b $background -c $border -s $select)" -f "$dir$filename.mp4" -c libx264rgb &
    ;;
"Fullscreen") wf-recorder -f "$dir$filename.mp4" -c libx264rgb & ;;
esac

notify-send "Screen capture" "Started capture as $filename.mp4"
