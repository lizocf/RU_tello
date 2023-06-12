from djitellopy import tello
import cv2

me = tello.Tello()
me.connect(False)

print(me.get_battery())

me.streamon()

while True:
    img = me.get_frame_read().frame # gives individual image from drone
    # img = cv2.resize(img,(360,240)) # keep small to process faster
    cv2.imshow("Image", img)
    cv2.waitKey(1)