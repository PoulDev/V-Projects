fn sum(x int, y int) int {
    return x + y
}

fn test_sum() {
    assert sum(5, 5) == 15
    assert sum(6, 5) == 11
    assert sum(5, 4) == 10
}


