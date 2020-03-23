#!/bin/sh

COUNTRY="SE"
API="https://corona-stats.online"
MINIMAL="true"
JSON="false"

aqi=$(curl -sf "$API/$COUNTRY?minimal=$MINIMAL&json=$JSON" | grep Sweden)
COLORLESS=$(sed 's/\x1b\[[0-9;]*m//g' <<< $aqi)

FIELDS=(${COLORLESS})
ACTIVE=${FIELDS[5]}
INCREASE=${FIELDS[8]}

if [ "$INCREASE" -gt 0 ]; then
    ICON="%{F#e60053}"
else
    ICON="%{F#4fb069}"
    INCREASE=$((INCREASE * -1))
fi

echo " $COUNTRY $ACTIVE ${ICON}${INCREASE}"
