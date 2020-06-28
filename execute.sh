#!/bin/bash

# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
export Black='\033[0;30m'        # Black
export Red='\033[0;31m'          # Red
export Green='\033[0;32m'        # Green
export Yellow='\033[0;33m'       # Yellow
export Blue='\033[0;34m'         # Blue
export Purple='\033[0;35m'       # Purple
export Cyan='\033[0;36m'         # Cyan
export White='\033[0;37m'        # White

# Bold
export BBlack='\033[1;30m'       # Black
export BRed='\033[1;31m'         # Red
export BGreen='\033[1;32m'       # Green
export BYellow='\033[1;33m'      # Yellow
export BBlue='\033[1;34m'        # Blue
export BPurple='\033[1;35m'      # Purple
export BCyan='\033[1;36m'        # Cyan
export BWhite='\033[1;37m'       # White

name="$1"
droplets=$(doctl compute droplet list -o json)
selected=$(echo $droplets | jq -r '.[].name' | grep "$name")

i=1
total=$(echo $selected | tr ' ' '\n' | wc -l)
for name in $selected
do
    cmd="curl http://easyasn.xyz/all/ranges.txt | grep -v \":\" > ranges.txt && sudo masscan -iL ranges.txt --rate=10000 -p443 --banners --shard $i/$total -oG $name.masscan && sudo chown op:users $name.masscan"
    $HOME/.axiom/interact/axiom-execb "$cmd" "$name"

    i=$((i+1))
done
