require "./game-manager"

puts "Enter name for player 1: "
player1 = gets.chomp

puts "Enter name for player 2: "
player2 = gets.chomp

players = [player1, player2]

GameManager.new(players)