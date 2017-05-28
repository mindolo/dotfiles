#!/bin/bash
set -u

killall Dock

sleep 1

kwmc display -f 0

sleep 1

kwmc space -fExperimental 2; sleep 0.5
kwmc space -fExperimental 3; sleep 0.5
kwmc space -fExperimental 4; sleep 0.5
kwmc space -fExperimental 1; sleep 0.5

killall Dock

sleep 1

kwmc display -f 1

sleep 1

kwmc space -fExperimental 2; sleep 0.5
kwmc space -fExperimental 3; sleep 0.5
kwmc space -fExperimental 4; sleep 0.5
kwmc space -fExperimental 1; sleep 0.5

killall Dock

sleep 1

kwmc display -f 2;

sleep 1

kwmc space -fExperimental 2; sleep 0.5
kwmc space -fExperimental 3; sleep 0.5
kwmc space -fExperimental 4; sleep 0.5
kwmc space -fExperimental 1; sleep 0.5
