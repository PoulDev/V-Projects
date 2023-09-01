import math

fn root(queue chan int) f64 {
    println('Getting Value')
    value := <- queue
    println(value)
    return math.sqrt(value)
}

fn main() {
    println('Creating queue')
    queue := chan int{}
    mut threads := []thread f64{}
    println('Adding to queue')
    for i in 0..10 {queue <- i}

    for i in 0..10 {
        println('Thread Spawned ${i}')
        threads << spawn root(queue)
    }
    mut res := threads.wait()
    println(res)
}
