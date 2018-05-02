#!/usr/bin/env python
# -*- coding: utf-8 -*-
 
# <bitbar.title>Chunkwm</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Matteo Bigoi</bitbar.author>
# <bitbar.dependencies>python</bitbar.dependencies>
 
import os
import re
import subprocess
import json
import locale
 
locale.setlocale(locale.LC_ALL, 'en_US.UTF-8')
 
 
CHUNKWMRC = os.path.join(os.path.expanduser('~'), '.chunkwmrc')
KARABINERRC = os.path.join(os.path.expanduser('~'), '.config/karabiner/karabiner.json')
DESKTOPSRC = os.path.join(os.path.expanduser('~'), '.chunkwm/desktops.json')
 
 
def read_file(path):
    with open(path, 'r') as fd:
        return fd.read()
 
 
def get_active_profile():
    content = read_file(CHUNKWMRC)
    search = re.search(r"# active_profile: (\w+)", content)
    if search:
        return search.groups()[0]
    return None
 
 
def get_active_desktop():
    res = "-1"
    try:
        p = subprocess.Popen(['/usr/local/bin/chunkc', 'tiling::query', '-d', 'id'],
                             stdout=subprocess.PIPE,
                             stderr=subprocess.PIPE)
        stdout, _ = p.communicate()
        if not p.returncode:
            try:
                res = stdout
            except ValueError:
                res = "-1"
    except Exception:
        res = "-1"
    return res
 
 
def get_active_window():
    try:
        p = subprocess.Popen(['/usr/local/bin/chunkc', 'tiling::query', '-w', 'tag'],
                             stdout=subprocess.PIPE,
                             stderr=subprocess.PIPE)
        stdout, _ = p.communicate()
        if not p.returncode:
            window_type = stdout.split('-')[0].strip()
            return stdout, window_type
        return 'unknown', 'unknown'
    except Exception:
        return "unknown", 'unknown'
 
 
def get_active_desktop_mode():
    try:
        p = subprocess.Popen(['/usr/local/bin/chunkc', 'tiling::query', '-d', 'mode'],
                             stdout=subprocess.PIPE,
                             stderr=subprocess.PIPE)
        stdout, _ = p.communicate()
        if not p.returncode:
            return "{}".format(stdout)
        return None
    except Exception:
        return None
 
 
def get_active_monitor():
    res = -1
    try:
        p = subprocess.Popen(['/usr/local/bin/chunkc', 'tiling::query', '--monitor', 'id'],
                             stdout=subprocess.PIPE,
                             stderr=subprocess.PIPE)
        stdout, _ = p.communicate()
        if not p.returncode:
            try:
                res = int(stdout)
            except ValueError:
                res = -1
    except Exception:
        res = -1
    return res
 
 
def get_karabiner_profiles():
    with open(KARABINERRC) as json_data:
        profiles = []
        config = json.load(json_data)
        for profile in config['profiles']:
            profiles.append((profile['name'], profile['selected']))
        return profiles
 
 
def get_karabiner_active_profile():
    for profile in get_karabiner_profiles():
        if profile[1]:
            return profile[0]
    return 'unknown'
 
 
def get_desktops():
    with open(DESKTOPSRC) as fd:
        return json.load(fd)
 
 
active_profile = get_active_profile()
active_desktop_number = get_active_desktop()
active_desktop_name = get_desktops().get(active_profile, {}).get(active_desktop_number)
active_desktop_mode = get_active_desktop_mode()
active_window, active_window_type = get_active_window()
 
if active_desktop_mode:
    print('%s - (%s)' % (active_desktop_name, active_desktop_mode))
else:
    print(active_desktop_name)
print('---')
print('Chunkwm: | color=#ffffff')
print('profile:\t\t\t%s | color=#b0b0b0' % active_profile)
print('window:\t\t\t%s | color=#b0b0b0' % active_window)
print('desktop:\t\t%s - %s (%s) | color=#b0b0b0' % (active_desktop_number, active_desktop_name, active_desktop_mode))
print('monitor:\t\t\t%s | color=#b0b0b0' % get_active_monitor())
print('---')
print('Karabiner: | color=#ffffff')
print('profile:\t\t\t%s | color=#b0b0b0' % get_karabiner_active_profile())
