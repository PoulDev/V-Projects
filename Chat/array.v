fn split_array(data []int, chunk_size int) [][]int {
	mut index := chunk_size
	mut chunk := []int{}
	mut values := [][]int{}

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

fn main() {
	array := [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33]
	println(split_array(array, 16))
}
