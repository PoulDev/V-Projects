import net
import io
import os
import arrays

fn load_reader(client net.TcpConn) io.BufferedReader {
	mut reader := io.new_buffered_reader(reader : client)
	/*	
		defer {
			unsafe {
				reader.free()
			}
		}
	*/
	return *reader
}

fn handle_packets(mut client net.TcpConn) {
	mut reader := load_reader(client)

	for {
		println(reader.read_line() or {'read_line() failed'})
	}
}

fn check_message(message string) bool {
	if arrays.uniq(message.runes()) == [` `] {
		return false
	} else if message == '' {
		return false
	} else {
		return true
	}
}

fn user_messages(mut client net.TcpConn) {
	message := os.input('')
	if !check_message(message) { 
		println('Message check failed')
		return
	}

	client.write_string(message + '\n') or {eprintln('Failed to send message')}
}

fn setup_connection(mut client net.TcpConn) {
	username := os.input('Please enter your username >')
	client.write_string(username + '\n') or {eprintln('Failed to send username')}
	println('-- Succesfully Connected --')
	println('Now you can start chatting')
}

fn main() {
	mut client := net.dial_tcp('127.0.0.1:12345')!

	spawn handle_packets(mut client)

	setup_connection(mut client)

	for { user_messages(mut client) }
}

