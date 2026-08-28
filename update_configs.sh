#!/bin/bash

if [[ $# -eq 0 ]] ; then
    echo 'Not enough arguments!'
    echo 'update_configs.sh servername'
    exit 1
fi

LIST_FILE="$1_mod_list.txt"
CONF_FILE="$1.ini"

wids="$(awk -F';' '{print $1}' $LIST_FILE | grep -ve '^$' | uniq | tr '\n' ';' | sed 's/;$//')"
mids="$(awk -F';' '{print $2}' $LIST_FILE | grep -ve '^$' | sed 's/&/\\&/g' | tr '\n' ';' | sed 's/;$//')"
maps="$(awk -F';' '{print $3}' $LIST_FILE | grep -ve '^$' | sed 's/&/\\&/g' | tr '\n' ';')Muldraugh, KY"

mods="$(awk -F';' '{print "    mod = "$2}' widsio_mod_list.txt | grep -ve '^$' | sed 's/&/\\&/g')"

sed -i.bak -e "s|^Mods=.*|Mods=$mids|" -e "s|^Map=.*|Map=$maps|" -e "s|^WorkshopItems=.*|WorkshopItems=$wids|" $CONF_FILE

echo -e "VERSION = 1,\n\nmods\n{" > $1_client_mods.txt
awk -F';' '{print "    mod = "$2","}' widsio_mod_list.txt | grep -ve '^$' | sed 's/&/\\&/g' >> $1_client_mods.txt
echo -e "}\n\nmaps\n{\n}\n" >> $1_client_mods.txt

echo "$1.ini updated!"
