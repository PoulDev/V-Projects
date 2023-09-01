fn add_one(value &int) {
	unsafe { *value += 1 }
}

fn main() {
	mut x := 5
	add_one(&x)
	println(x)
}

