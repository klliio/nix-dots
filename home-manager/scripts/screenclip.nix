pkgs:
let
  notify-send = "${pkgs.libnotify}/bin/notify-send";
  killall = "${pkgs.killall}/bin/killall";
  gpu-screen-recorder = "${pkgs.gpu-screen-recorder}/bin/gpu-screen-recorder";
in
pkgs.writeShellScript "screenclip" ''
    dir="$HOME/Videos/Replays/"
    save=false

    while [ "$#" -gt 0 ]; do
        arg="$1"
        case "$1" in
        --*'='*)
            shift
            set -- "$\{arg%%=*}" "$\{arg#*=}" "$@"
            continue
            ;;
        --save)
            save=true
            ;;
        *) break ;;
        esac
        shift
    done

    if ! [ -d "$dir" ]; then
        mkdir -p "$dir"
    fi

    if [ $save = true ]; then
        ${killall} -SIGUSR1 gpu-screen-recorder && sleep 0.5 && ${notify-send} -t 1500 -u low -- "GPU Screen Recorder" "Saving replay"
        exit 0
    fi

    if [ "$(pgrep -f gpu-screen-recorder)" != "" ]; then
        ${notify-send} -t 1500 -u low -- "GPU Screen Recorder" "Stopping replay"
        ${killall} -SIGINT gpu-screen-recorder
    else
        pidof -q gpu-screen-recorder && exit 0

        ${notify-send} -t 1500 -u low -- "GPU Screen Recorder" "Starting replay"
        ${gpu-screen-recorder} -w screen -f 60 -c mp4 -bm cbr -q 40000 -r 120 -o "$dir"
    fi
''
