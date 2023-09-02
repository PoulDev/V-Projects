import crypto.sha256
import time

fn generate_zeroes(zeroes int) string {
	mut zeroes_str := ''
	for _ in 0..zeroes { zeroes_str += '0' }
	return zeroes_str
}

fn mine(zeroes int, block_number i64, transactions string, previous_hash string) {
	mut hash_try := ''
	mut startswith := generate_zeroes(zeroes)
	mut nonce := i64(0)

	mut sw := time.new_stopwatch()
	for {
		hash_try = sha256.hexhash(block_number.str() + transactions + previous_hash + nonce.str())

		if hash_try[..zeroes] == startswith {
			println('Found Hash With Nonce ${nonce} in ${sw.elapsed().seconds()} seconds')
			return
		}
		nonce += 1
		if nonce % 1000 == 0 {
			print('\rTotal Hashes (nonce): ${nonce}')
		}
	}
}

fn main() {
	println('Starting Mining...')
	zeroes := 6

	block_number := 24
	transactions := "76123fcc2142"
	previous_hash := "876de8756b967c87"

	mine(zeroes, block_number, transactions, previous_hash)
}
