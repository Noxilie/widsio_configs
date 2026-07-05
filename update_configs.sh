#!/bin/bash

CONF_FILE="widsio.ini"

wids=$(awk '{print $1}' mod_list.txt | uniq | tr '\n' ';' | sed 's/;$//')
mids=$(awk '{print $2}' mod_list.txt | uniq | tr '\n' ';' | sed 's/;$//')

sed -i -e "s|Mods=.+|Mods=$mids|" -e "s|WorkshopItems=.+|WorkshopItems=$wids|" CONF_FILE
