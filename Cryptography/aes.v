import crypto.aes
import crypto.rand
import crypto.cipher


fn stringify(array []u8) string {
	mut str := ''
	for chr in array { str += rune(chr).str() }
	return str
}

fn fix_chunk_length_str(value string, chunk_size int) string {
	mut data := value
	bytes_to_add := chunk_size-data.len

	for _ in 0..bytes_to_add {
		data += rune(0).str()
	}
	return data
}

fn remove_chunk_null_bytes(value []u8, chunk_size int) []u8 {
	mut last_chunk := value[value.len-chunk_size..].clone()
	mut cleaned_chunks := value[..value.len-chunk_size].clone()
	cleaned_chunks << last_chunk[..last_chunk.index(0)] 
	return cleaned_chunks
}

fn split_array(data []u8, chunk_size int) [][]u8 {
	mut index := chunk_size
	mut chunk := []u8{}
	mut values := [][]u8{}

	for {
		if index > data.len-1 {
			chunk = data[index-chunk_size..].clone()
		} else {
			chunk = data[index-chunk_size..index].clone()
		}
		if chunk.len > 0 { values << [chunk] }

		if index > data.len-1 {break}
		index += chunk_size
	}
	return values
}

fn split_string(data string, chunk_size int) []string {
	mut index := chunk_size
	mut chunk := ''
	mut strings := []string{}

	for {
		chunk = data[index-chunk_size..index] or {data[index-chunk_size..]}
		if chunk.len > 0 { strings << fix_chunk_length_str(chunk, chunk_size) }

		if index > data.len {break}
		index += chunk_size
	}
	return strings
}

fn encrypt(aes_cipher cipher.Block, data string) []u8 {
    mut encrypted := []u8{len: aes.block_size}
	mut encrypted_chunks := []u8{}
	for data_chunk in split_string(data, aes_cipher.block_size) {
	    aes_cipher.encrypt(mut encrypted, data_chunk.bytes())
		encrypted_chunks << encrypted
		encrypted = []u8{len: aes.block_size}
	}
    return encrypted_chunks
}

fn decrypt(aes_cipher cipher.Block, data []u8) string {
    mut decrypted := []u8{len: aes_cipher.block_size}
	mut decrypted_chunks := []u8{}

	mut decoded_data := data.clone()

	for data_chunk in split_array(decoded_data, aes_cipher.block_size) {
		aes_cipher.decrypt(mut decrypted, data_chunk)

		decrypted_chunks << decrypted
		decrypted = []u8{len: aes_cipher.block_size}
	}
	decrypted_chunks = remove_chunk_null_bytes(decrypted_chunks, aes_cipher.block_size)
    return stringify(decrypted_chunks)
}


fn main() {
    key := rand.bytes(32)!
    println('KEY: ${key}')

    mut data := 'data di esempio uaaaaaaa non so cosa scrivere'

    println('generating cipher')
    aes_cipher := aes.new_cipher(key)

	encrypted := encrypt(aes_cipher, data)
	println('Encrypted: ${encrypted}')

	decrypted := decrypt(aes_cipher, encrypted)
	println('Decrypted: ${decrypted}')

    assert decrypted == data
}

