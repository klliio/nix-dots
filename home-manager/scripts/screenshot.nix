pkgs:
let
  notify-send = "${pkgs.libnotify}/bin/notify-send";
  slurp = "${pkgs.slurp}/bin/slurp";
  grim = "${pkgs.grim}/bin/grim";
  fuzzel = "${pkgs.fuzzel}/bin/fuzzel";
in
pkgs.writeShellScript "screenshot" ''
    time="$(date +%Y-%m-%dT%H-%M-%S%z)"
    dir="$HOME/Images/Screenshots/"
    background="FFFFFF46"
    border="00000076"
    select="00000010"
    quality=85
    quick=false
    matchmode="exact"

    mkdir -p "$dir"

    while [ "$#" -gt 0 ]; do
        arg="$1"
        case "$1" in
            --*'='*)
                shift
                set -- "$\{arg%%=*}" "$\{arg#*=}" "$@"
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
            --quality)
                shift
                quality="$1"
                ;;
            --quick)
                quick=true
                ;;
            --dir)
                shift
                dir="$1"
                ;;
            *) break ;;
        esac
        shift
    done

    if ! [ -d "$dir" ]; then
        mkdir -p "$dir"
    fi

    if [ "$quick" = true ]; then
        ${grim} -t jpeg -q "$quality" "$dir$time.jpeg"
        ${notify-send} -a Screenshot -i "$dir$time.jpeg" "Screenshot" "Saved as $time.png"
        exit 0
    fi

    tmp=$(mktemp /tmp/screenshow_XXXXX.jpeg)

    selection=$(printf "Fullscreen\nRegion" | fuzzel -d)
    case "$selection" in
        "Region") ${grim} -g "$(${slurp} -d -b $background -c $border -s $select)" -t jpeg -q "$quality" "$tmp" ;;
        "Fullscreen") ${grim} -t jpeg "$tmp" ;;
    esac

    while true; do
        filename=$(find "$dir" -maxdepth 1 -type f -printf "%f\n" | sed -E 's/\.[a-zA-Z0-9]*//' | ${fuzzel} -d --match-mode="$matchmode")

        # check if name was entered
        if [ -z "$filename" ]; then
            ${notify-send} -a Screenshot Screenshot "No file name entered"
            exit 1
        fi

        # check if file already exists
        if [ -f "$dir$filename".jpeg ]; then
            choice=$(printf 'Rename\nReplace\nKeep & ignore' | ${fuzzel} -d)

            case "$choice" in
            "Rename")
                continue
                ;;
            "Replace")
                mv "$tmp" "$dir$filename.jpeg"
                ${notify-send} -a Screenshot Screenshot "Replacing existing picture"
                break
                ;;
            "Keep & ignore")
                rm "$tmp"
                ${notify-send} -a Screenshot Screenshot "Keeping existing picture"
                break
                ;;
            *)
                ${notify-send} -a Screenshot Screenshot "No option chosen"
                rm "$tmp"
                exit 1
                ;;
            esac
        else
            mv "$tmp" "$dir$filename.jpeg"
            ${notify-send} -a Screenshot -i "$dir$filename.jpeg" Screenshot "Saved as $filename.jpeg"
            break
        fi
    done
''
