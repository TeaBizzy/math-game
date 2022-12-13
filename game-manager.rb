require "./player"
require "./question"

class GameManager
  attr_accessor :players, :current_player, :current_sate, :winner
  STATES = {active: "active", game_over: "game_over"}
  
  def initialize(player_names)
    # Create players
    @players = []
    create_players(player_names)

    # Set other attributes
    @current_player = @players[0]
    @current_sate = STATES[:active]

    # Start game loop
    game_manager()
  end


  # Creates player objects
  private def create_players(names)
    @players.push(Player.new(names[0]))
    @players.push(Player.new(names[1]))
  end

  # Main game loop
  private def game_manager()
    puts "-- [ Game Start! ] --"

    # Game loop
    while(@current_sate != STATES[:game_over])
      puts ""
      puts "NEW ROUND"

      # Create new question
      question = Question.new
      puts "#{@current_player.name}: #{question.question}"

      # Get players answer
      answer = gets.chomp.to_i
      
      # Check players answer
      if(question.check_answer(answer))
        puts "#{@current_player.name} was CORRECT!"
      else
        puts "#{@current_player.name} was INCORRECT!"
        @current_player.lives -= 1
      end

      # Display score
      puts "Lives: #{@players[0].name} = #{@players[0].lives}/3 VS #{@players[1].name} = #{@players[1].lives}/3"

      # Check for game over
      if(@current_player.lives <= 0)
        game_over()
      else
        @current_player = get_other_player() 
      end
    end
  end

  # Ends the game loop
  private def game_over()
    @current_sate = STATES[:game_over]
    @winner = get_other_player()
    puts ""
    puts "-- [ Game Over! ] --"
    puts "Winner is #{@winner.name}!"
  end


  # Returns the non-current player
  private def get_other_player()
    @players.select {|player| player != @current_player}[0]
  end
end