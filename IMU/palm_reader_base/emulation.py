import serial
import numpy as np

s = serial.Serial('COM1', 1000000)
values = bytearray([1, 2, 3, 1, 2, 3, 1, 2, 3,
                    1, 2, 3, 1, 2, 3, 1, 2, 3,
                    1, 2, 3, 1, 2, 3, 1, 2, 3,
                    1, 2, 3, 1, 2, 3, 1, 2, 3,
                    1, 2, 3, 1, 2, 3, 1, 2, 3,
                    1, 2, 3, 1, 2, 3, 1, 2, 3,
                    1, 2, 3, 1, 2, 3, 1, 2, 3,
                    1, 2, 3, 1, 2, 3, 1, 2, 3,
                    1, 2, 3, 1, 2, 3, 1, 2, 3,
                    1, 2, 3, 1, 2, 3, 1, 2, 3,
                    1, 2, 3, 1, 2, 3, 1, 2, 3,
                    1, 2, 3, 1, 2, 3, 1, 2, 3,
                    4,4])
print('ready')
try:
    while 1:
        res = s.read()
        print(res)
        s.write(values)
except:
    print("program finished")