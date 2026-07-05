#!/bin/bash

CONF_FILE="widsio.ini"

wids="$(awk -F';' '{print $1}' mod_list.txt | uniq | tr '\n' ';' | sed 's/;$//')"
mids="$(awk -F';' '{print $2}' mod_list.txt | sed 's/&/\\&/g' | tr '\n' ';' | sed 's/;$//')"

sed -i.bak -e "s|^Mods=.*|Mods=$mids|" -e "s|^WorkshopItems=.*|WorkshopItems=$wids|" $CONF_FILE
