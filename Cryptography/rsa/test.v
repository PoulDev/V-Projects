import math

fn main() {
	// step 1
	p := 3
	q := 7

	n := p*q
	println("n = ${n}")

	// step 3
	phi := (p-1)*(q-1)

	//step 4
	mut e := 2
	for e<phi {
	    if math.gcd(e, phi) == 1 {
			break
		} else {
	        e += 1
		}
	} 

	println("e = ${e}")
	// step 5
	k := 2
	d := ((k*phi)+1)/e
	println("d = ${d}")
	println('Public key: ${e}, ${n}')
	println('Private key: ${d}, ${n}')

	// plain text
	msg := 11
	println('Original message:${msg}')

	// encryption
	mut c := math.pow(msg, e)
	c = math.fmod(c, n)
	println('Encrypted message: ${c}')

	// decryption
	mut m := math.pow(c, d)
	m = math.fmod(m, n)

	println('Decrypted message: ${m}')
}
