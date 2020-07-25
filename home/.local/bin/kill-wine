#!/bin/bash

wineserver -k; killall -9 wine wineserver; for i in `ps ax|egrep "*\.exe"|grep -v 'egrep'|awk '{print $1 }'`;do kill -9 $i;done
