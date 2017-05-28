#!/bin/bash
set -ux

# retry until kwm is up
kwmc display -f 0
kwm_up=${?}
until [ ${kwm_up} == 0 ] ; do
   echo "waiting for kwm to start"
   sleep 0.1
   kwmc display -f 0
   kwm_up=$?
done

# cycle all the spaces
kwmc space -fExperimental 1; sleep 0.5
kwmc space -fExperimental 2; sleep 0.5
kwmc space -fExperimental 3; sleep 0.5
kwmc space -fExperimental 4; sleep 0.5
kwmc space -fExperimental 5; sleep 0.5
kwmc space -fExperimental 6; sleep 0.5
kwmc space -fExperimental 7; sleep 0.5
kwmc space -fExperimental 8; sleep 0.5
kwmc space -fExperimental 9; sleep 0.5
kwmc space -fExperimental 10; sleep 0.5
kwmc space -fExperimental 11; sleep 0.5
kwmc space -fExperimental 12; sleep 0.5

# return to terminals
kwmc space -fExperimental 1; sleep 0.5
