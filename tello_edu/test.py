import time
from djitellopy import Tello

# see https://djitellopy.readthedocs.io/en/latest/tello/ for commands

me = Tello()
me.connect()
print(me.get_battery())

