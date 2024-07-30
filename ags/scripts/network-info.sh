#!/usr/bin/env sh

up=0
down=0
upsymbol=""
downsymbol=""
info=""
pollspeed=5

while [ "$#" -gt 0 ]; do
    arg="$1"
    case "$1" in
        --*'='*) shift; set -- "${arg%%=*}" "${arg#*=}" "$@"; continue;;
        --icons) upsymbol=" " ; downsymbol=" ";;
        -s|--speed) info="speed";;
        -i|--ip) info="ip";;
        -p|--poll) shift; pollspeed="$1";;
        *) break;;
    esac
    shift
done

get_interface() {
    interfaces="$(route | grep '^default' | grep -o '[^ ]*$')"

    i=1
    while [ "$i" -le "$(($(printf "$interfaces" | wc -l) + 1))" ]; do
        interface="$(printf "$interfaces" | head -n"$i" | tail -n1)"
        i="$(($i + 1))"

        if [ ! "$interface" = "" ]; then
            if [ "$(cat "/sys/class/net/$interface/carrier")" = 1 ]; then
                i=200
            fi
        fi

    done

    if [ ! "$i" = 200 ]; then
        interface=""
    fi
}

get_ip() {
    while [ true ]; do
        get_interface
        if [ ! "$interface" = "" ]; then
            printf "$(ifconfig | grep -A1 $interface | grep inet | awk -F" " '{printf "%s", $2}')\n"
        else
            # show no connection
            printf "127.0.0.1\n"
        fi
        sleep "$pollspeed"s
    done
}

get_speed() {
    while [ true ]; do
        get_interface
        if [ ! "$interface" = "" ]; then
            tx1="$(cat /sys/class/net/$interface/statistics/tx_bytes)"
            rx1="$(cat /sys/class/net/$interface/statistics/rx_bytes)"

            sleep "$pollspeed"s

            tx2="$(cat /sys/class/net/$interface/statistics/tx_bytes)"
            rx2="$(cat /sys/class/net/$interface/statistics/rx_bytes)"

            up="$(printf $(($(($tx2 - $tx1)) / $pollspeed)) | numfmt --to=si)"
            down="$(printf $(($(($rx2 - $rx1)) / $pollspeed)) | numfmt --to=si)"
        else
            # show no connection
            sleep "$pollspeed"s
            up=0
            down=0
        fi

        printf "%s%sB/s  %s%sB/s\n" "$upsymbol" "$up" "$downsymbol" "$down"
    done
}

case "$info" in
    "speed") get_speed;;
    "ip") get_ip;;
    *) break;;
esac
