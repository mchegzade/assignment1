#!/usr/bin/env python2.7
__author__ = "Mosen Chegzade"
__copyright__ = "Copyright 2016, Assignment 1 Part 3, CYMON API"
__credits__ = ["Cymon API"]
__license__ = "GPL"
__version__ = "0.1"
__maintainer__ = "Mosen Chegzade"
__email__ = "mchegzade@gmail.com"
__status__ = "Production"

import json
import cymon

api = cymon.Cymon('a24ab574029d8a3a089f992b8a1c405dd687b233')

with open('data.json', 'w') as outfile:
    json.dump(api.ip_events('213.239.154.20'), outfile)


