require "./player"
require "./question"

class GameManager
  attr_accessor :players, :current_player, :current_sate, :winner
  STATES = {active: "active", game_over: "game_over"}
  
  def initialize(one, two)
    @players = []
    player_name = one
    while @players.length < 2 do
      @players.push(Player.new(player_name))
      player_name = two
    end
    @current_player = @players[0]
    @current_sate = STATES[:active]
    state_manager()
  end

  def state_manager()
    puts "-- [ Game Start! ] --"
    while(@current_sate != STATES[:game_over])
      puts ""
      puts "NEW ROUND"
      question = Question.new
      puts "#{@current_player.name}: #{question.question}"
      answer = gets.chomp.to_i
      
      if(question.check_answer(answer))
        puts "#{@current_player.name} was CORRECT!"
      else
        puts "#{@current_player.name} was INCORRECT!"
        @current_player.lives -= 1
      end

      puts "Lives: #{@players[0].name} = #{@players[0].lives}/3 VS #{@players[1].name} = #{@players[1].lives}/3"
      if(@current_player.lives <= 0)
        @current_sate = STATES[:game_over]
        @winner = @players.select {|player| player != @current_player}[0]
      end

      @current_player = @players.select {|player| player != @current_player}[0]
    end
    puts ""
    puts "Winner is #{@winner.name}!"
  end
end