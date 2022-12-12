class Question
  attr_accessor :numbers, :question, :answer

  def initialize()
    @numbers = []
    new_question()
  end

  # Generates a new question
  def new_question()
    while numbers.length() < 2 do
      @numbers.push(rand(1..20))
    end

    @question = "what is #{numbers[0]} + #{numbers[1]}?"
    @answer = numbers[0] + numbers[1]
  end

  # Returns a boolean comparing the plays answer to the correct answer
  def check_answer(answer)
    @answer == answer
  end
end