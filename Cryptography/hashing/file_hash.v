import os
import crypto.sha256

fn main() {
	data := os.read_file('./data') or {
		panic('Error reading data file ${err}')
		return
	}

	println('Calculating hash...')
	println(sha256.hexhash(data))
}
