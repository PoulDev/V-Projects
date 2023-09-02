module main

import os


fn main() {
	mut cmd := os.Command{
		path: 'cat'
		redirect_stdout: true
	}
	cmd.start() or {}
	for !cmd.eof {
		line := cmd.read_line()
		println('line="$line"')
	}
	cmd.close() or {}
}
