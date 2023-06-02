from djitellopy import Tello
from time import sleep

# see https://djitellopy.readthedocs.io/en/latest/tello/ for commands

me = Tello()
me.connect()

print(me.get_battery())

# me.takeoff()

# # me.move_forward(50) "move fw 50 cm"
# me.send_rc_control(0,50,0,0) 
# # send_rc_control((self,) l/r vel, fw/bw vel, up/down vel, yaw_vel)
# # vel: -100~100, neg = left/bw
# sleep(2)
# me.send_rc_control(30,50,0,0)
# sleep(2)
# me.send_rc_control(0,0,0,0) # stop completely before landing
# me.land()