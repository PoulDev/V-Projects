// Without Cloning
println('---- WITHOUT CLONING ----')

mut a := [1, 2, 3, 4]

println(a)

unsafe {
    mut b := a
    b[0] = 5

    println(a)
    println(b)
}

// With Cloning
println('---- WITH CLONING ----')

mut x := [1, 2, 3, 4]
mut y := x.clone()

println(x)

y[0] = 5

println(x)
println(y)
