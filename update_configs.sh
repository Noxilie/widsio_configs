#!/bin/bash

LIST_FILE="mod_list.txt"
CONF_FILE="widsio.ini"

wids="$(awk -F';' '{print $1}' $LIST_FILE | grep -ve '^$' | uniq | tr '\n' ';' | sed 's/;$//')"
mids="$(awk -F';' '{print $2}' $LIST_FILE | grep -ve '^$' | sed 's/&/\\&/g' | tr '\n' ';' | sed 's/;$//')"
maps="$(awk -F';' '{print $3}' $LIST_FILE | grep -ve '^$' | sed 's/&/\\&/g' | tr '\n' ';' | sed 's/;$//')"

sed -i.bak -e "s|^Mods=.*|Mods=$mids|" -e "s|^Map=.*|Map=$maps|" -e "s|^WorkshopItems=.*|WorkshopItems=$wids|" $CONF_FILE
