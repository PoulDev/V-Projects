from ctypes import CDLL
import time

v_module = CDLL('./test.dll')

def large_sum(n):
    value = 0
    for i in range(n):
        value += i
    return value

value = 1000000000

s = time.time()
large_sum(value)
print('Python', time.time() - s)

s = time.time()
v_module.large_sum(value)
print('VLang', time.time() - s)
