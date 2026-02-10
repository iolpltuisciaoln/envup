#!/usr/bin/env bash

INTERVAL="3" # update interval in seconds

network_name=$(ip r | grep default | head -n1 | awk '{print $5}')

main() {
    # while true; do
    output_download=""
    output_upload=""
    output_download_unit=""
    output_upload_unit=""

    initial_download=$(cat /sys/class/net/$network_name/statistics/rx_bytes)
    initial_upload=$(cat /sys/class/net/$network_name/statistics/tx_bytes)

    sleep $INTERVAL

    if ping -q -c 1 -w 2 8.8.8.8 >/dev/null; then
        ping_status="#[bold]#[fg=#18f164]⊙"
    else
        ping_status="#[bold]#[fg=#f01c2b]∅"
    fi

    final_download=$(cat /sys/class/net/$network_name/statistics/rx_bytes)
    final_upload=$(cat /sys/class/net/$network_name/statistics/tx_bytes)

    total_download_bps=$(expr $final_download - $initial_download)
    total_download_bps=$(expr $total_download_bps)
    total_upload_bps=$(expr $final_upload - $initial_upload)
    total_upload_bps=$(expr $total_upload_bps/$INTERVAL)

    if [ $total_download_bps -gt 1073741824 ]; then
        output_download=$(echo "$total_download_bps 1024" | awk '{printf "%.2f \n", $1/($2 * $2 * $2)}')
        output_download_unit="G"
    elif [ $total_download_bps -gt 1048576 ]; then
        output_download=$(echo "$total_download_bps 1024" | awk '{printf "%.2f \n", $1/($2 * $2)}')
        output_download_unit="m"
    else
        output_download=$(echo "$total_download_bps 1024" | awk '{printf "%.2f \n", $1/$2}')
        output_download_unit="k"
    fi

    if [ $total_upload_bps -gt 1073741824 ]; then
        output_upload=$(echo "$total_download_bps 1024" | awk '{printf "%.2f \n", $1/($2 * $2 * $2)}')
        output_upload_unit="G"
    elif [ $total_upload_bps -gt 1048576 ]; then
        output_upload=$(echo "$total_upload_bps 1024" | awk '{printf "%.2f \n", $1/($2 * $2)}')
        output_upload_unit="m"
    else
        output_upload=$(echo "$total_upload_bps 1024" | awk '{printf "%.2f \n", $1/$2}')
        output_upload_unit="k"
    fi

    printf "#[bold]#[fg=#8be9fd] ↓%s %s %s #[fg=#8be9fd]↑%s %s" $output_download $output_download_unit $ping_status $output_upload $output_upload_unit
}
printf " %s" "$(main)"
