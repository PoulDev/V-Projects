[export: 'large_sum']
fn large_sum(n i64) i64 {
    mut value := i64(0)
    for i in 0..n {
        value += i
    }
    return value
}


