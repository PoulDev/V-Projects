module ddos

import net.http

pub fn request(url string) bool {
	http.get(url) or { return false }
	return true
}
