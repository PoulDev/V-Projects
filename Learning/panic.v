import os

pwd := os.input('Password >')

if pwd == 'testtest123' {
    println('Success!')
} else {
    panic('Password Missmatch')
}

println('Quack! >(^)')
