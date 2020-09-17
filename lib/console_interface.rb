require 'colorize'

class ConsoleInterface
  FIGURES =
    Dir[__dir__ + '/../data/figures/*.txt'].
    sort.
    map{ |file_name| File.read(file_name) }

  def initialize(game)
    @game = game
  end

  def print_out
    word = "Слово: #{word_to_show}".colorize(:yellow)
    errors = "Ошибки (#{@game.errors_made}): #{errors_to_show}".colorize(:red)

    puts <<~END
      #{word}
      #{figure}
      #{errors}
      У вас осталось ошибок: #{@game.errors_allowed}
    END

    if @game.won?
      puts "Поздравляем, вы выиграли!"
    elsif @game.lost?
      puts "К сожалению, вы проиграли!\nЗагаданное слово - #{@game.word}"
    end
  end

  def figure
    return FIGURES[@game.errors_made]
  end

  def word_to_show
    result =
      @game.letters_to_guess.map do |letter|
        if letter == nil
          "__"
        else
          letter
        end
      end
    result.join(" ")
  end

  def errors_to_show
    @game.errors.join(", ")
  end

  def get_input
    print "Введите следующую букву: "
    letter = gets[0].upcase
  end
end
