import term { erase_clear }
import os { input }
import rand { intn }
import time { sleep }

fn print_map(game [3][3]int, highlight int) {
    term.erase_clear()

    mut row_index := 0
    mut value_index := 0
    mut print_value := ''

    /*
        ╭───╮
        │   │
        ╰───╯
    */

    println('\033[34m╭───────╮\033[0m')

    for row in game {
        value_index = 0
        print('\033[34m│\033[0m ')
        for value in row {
            print_value = if value == 1 { '\033[32mx\033[0m' } else if value == 2 { '\033[33mo\033[0m' } else { '▢' }
            if (row_index * 3 + value_index) == highlight {
                print('\033[34m${print_value}\033[0m')
            } else {
                print(print_value)
            }
            print(' ')
            value_index += 1
        }
        println('\033[34m│\033[0m')
        row_index += 1
    }

    println('\033[34m╰───────╯\033[0m')
}

fn find_winner(game [3][3]int) (bool, int) {
    for line in game {
        if line[0] != 0 && line[0] == line[1] && line[1] == line[2] {
            return true, line[0]
        }
    }

    for line_2 in 0..3 {
        if game[0][line_2] != 0 && game[0][line_2] == game[1][line_2] && game[1][line_2] == game[2][line_2] {
            return true, game[line_2][0]
        }
    }

    if game[0][0] != 0 && game[0][0] == game[1][1] && game[1][1] == game[2][2] {
        return true, game[0][0]
    } else if game[0][2] != 0 && game[0][2] == game[1][1] && game[1][1] == game[2][0] {
        return true, game[0][2]
    }

    return false, 0
}

fn avaible_spots(game [3][3]int) [][]int {
    mut spots := [][]int{}
    mut row_index := 0
    mut value_index := 0
    mut spot := [0, 0]

    for row in game {
        value_index = 0
        for value in row {
            spot = [row_index, value_index]
            if value == 0 {
                spots << [spot]
            }
            value_index += 1
        }
        row_index += 1
    }

    return spots
}

fn computer_move(mut game [3][3]int, avaible_spots [][]int) {
    if avaible_spots.len < 1 { return }
    spot_index := rand.intn(avaible_spots.len-1) or {0}
    spot := avaible_spots[spot_index]
    game[spot[0]][spot[1]] = 2
}

fn select_point(mut game [3][3]int) {
    mut input := ''
    mut highlight := 0
    for {
        if highlight >= 9 {highlight = 0}

        if game[int(highlight / 3)][highlight % 3] != 0 {
            highlight += 1
            println('continue')
            continue
        }

        print_map(game, highlight)
        input = os.input('>')
        if input != '' {
            break
        } else {
            highlight += 1
        }
    }
    game[int(highlight / 3)][highlight % 3] = 1
}

fn tutorial() {
    println('Premi invio per passare all prossima casella')
    println('per selezionare quella corrente, premi un qualsiasi carattere')
    println('e successivamente premi invio')
    os.input('[ premi invio per iniziare a giocare ]')
}

fn get_winner_name(winner int) string {
    winner_name := if winner == 1 { '\033[32mPlayer' } else { '\033[31mBot' }
    return winner_name + '\033[0m'
}

fn main() {
    tutorial()
    mut game_map := [3][3]int{init: [3]int{}}
    mut win, mut winner := false, 0
    for avaible_spots(game_map).len > 0 {
        select_point(mut game_map)
        print_map(game_map, -1)
        sleep(500 * time.millisecond)
        computer_move(mut game_map, avaible_spots(game_map))
        print_map(game_map, -1)
        sleep(500 * time.millisecond)
        win, winner = find_winner(game_map)
        if win {
            print_map(game_map, -1)
            println('WINNER: ${get_winner_name(winner)}')
            break
        }
    }

    if !win {
        println('Nessuno a vinto! che scarsoni che siete')
    }
}
