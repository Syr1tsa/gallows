class Game
  TOTAL_ERRORS_ALLOWED = 7

  def initialize(word)
    @letters = normalized_letters(word)
    @user_guesses = []
  end

  def errors
    return @user_guesses - @letters
  end

  def errors_allowed
    return TOTAL_ERRORS_ALLOWED - errors_made
  end

  def errors_made
    return errors.length
  end

  def letters_to_guess
    result =
      @letters.map do |letter|
        if @user_guesses.include?(letter)
          letter
        else
          nil
        end
      end
  end

  def lost?
    return errors_allowed == 0
  end

  def over?
    return won? || lost?
  end

  def normalize_letter(letter)
    return "Е" if letter.downcase == "ё"
    return "И" if letter.downcase == "й"
    return letter
  end

  def normalized_letters(word)
    word.chars.map{ |letter| letter = normalize_letter(letter)}
  end

  def play!(letter)
    letter = normalize_letter(letter)
    if !over? && !@user_guesses.include?(letter)
      @user_guesses << normalize_letter(letter)
    end
  end

  def word
    return @letters.join
  end

  def won?
    (@letters - @user_guesses).empty?
  end
end
