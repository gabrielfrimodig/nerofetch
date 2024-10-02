#!/bin/bash

## COLORS
bold=$'\e[1m'
black=$'\e[30m'
red=$'\e[31m'
green=$'\e[32m'
yellow=$'\e[33m'
blue=$'\e[34m'
magenta=$'\e[35m'
cyan=$'\e[36m'
white=$'\e[37m'
grey=$'\e[90m'
reset=$'\e[0m'

## COLOR VARIABLES
lc="${reset}${bold}${magenta}" # labels
nc="${reset}${bold}${yellow}"  # user
hn="${reset}${bold}${blue}"    # hostname
ic="${reset}${green}"          # info
c0="${reset}${blue}"           # penguin color

## SYSTEM INFORMATION
user=$(whoami)
host=$(hostname)
os=$(cat /etc/fedora-release)
kernel=$(uname -r)
uptime=$(uptime -p | sed 's/up //')
shell=$(basename "$SHELL")

## MEMORY INFORMATION
mem_info=$(free -m | awk 'NR==2{printf "%s/%sMB (%.2f%%)", $3,$2,$3*100/$2 }')

## DISK INFORMATION
disk_info=$(df -h --output=used,size / | awk 'NR==2 {print $1 " / " $2 " (" $1/$2*100 "%)" }')

## LOCAL IP
local_ip=$(hostname -I | awk '{print $1}')

## OUTPUT FUNCTION
print_info() {
    cat << EOF

${c0}       .---.        ${nc}${user}${red}@${hn}${host}
${c0}      /     \\       ${lc}OS:        ${ic}${os}
${c0}      \\.@-@./       ${lc}Kernel:    ${ic}${kernel}
${c0}      /\`\\_/\`\\       ${lc}Uptime:    ${ic}${uptime}
${c0}     //  _  \\\\      ${lc}Shell:     ${ic}${shell}
${c0}    | \\     )|_     ${lc}Memory:    ${ic}${mem_info}
${c0}   /\`\\_\`>  <_/ \\    ${lc}Disk:      ${ic}${disk_info}
${c0}   \\__/'---'\\__/    ${lc}Local IP:  ${ic}${local_ip}

${lc}Colors: ${red}■ ${green}■ ${yellow}■ ${blue}■ ${magenta}■ ${cyan}■ ${white}■${reset}
EOF
}

## MAIN EXECUTION
clear
print_info
