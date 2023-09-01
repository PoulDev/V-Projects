import time
import os

fn loop_spawn(value i64) {
	for {
		println(value)
		time.sleep(1000 * time.millisecond)
	}
}

fn main() {
	mut x := i64(0)

	for _ in 0..5 {
		x += 1
		spawn loop_spawn(x)
		time.sleep(10 * time.millisecond)
	}

	os.input('')
}
