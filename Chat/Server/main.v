import io
import net

struct User {
mut:
	socket net.TcpConn
	username string
}

fn main() {
	mut server := net.listen_tcp(.ip6, ':12345')!
	mut connected_clients := map[i64]User{}
	mut user_id := i64(0)

	laddr := server.addr()!
	println('Listen on ${laddr} ...')
	for {
		mut socket := server.accept()!
		spawn handle_client(user_id, mut socket, mut &connected_clients)
		user_id += 1
	}
}

fn broadcast(data string, mut clients map[i64]User, exclude_id i64) {
	for user_id, mut user in clients {
		if user_id == exclude_id {continue}
		user.socket.write_string(data + '\n') or { disconnect_client(user_id, mut clients) }
	}
}

fn disconnect_client(user_id i64, mut clients map[i64]User) {
	println('${clients[user_id].username} (ID:${user_id}) has been disconnected')
	clients.delete(user_id)
	broadcast('${clients[user_id].username} left.', mut clients, -1)
}

fn handle_client(user_id i64, mut socket net.TcpConn, mut clients map[i64]User) {
	defer { socket.close() or { eprintln(err) } }

	client_addr := socket.peer_addr() or { return }
	mut reader := io.new_buffered_reader(reader: socket)
	defer { unsafe { reader.free() } }

	username := reader.read_line() or { return }
	
	mut user := User{
		socket: socket,
		username: username
	}
	clients[user_id] = user
	println('User connected: ${username}')

	defer { disconnect_client(user_id, mut &clients) }

	for {
		received_line := reader.read_line() or { return }
		if received_line == '' {
			return
		}
		println('client ${client_addr}: ${received_line}')
		broadcast('${username}: ${received_line}', mut &clients, user_id)
	}
}
