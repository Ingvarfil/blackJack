class Interface
  attr_reader :input

  def ask_name
    puts '==== BlackJack game ===='
    print 'Hi! Enter yor name: '  
  end

  def show_desk(name, cards, points, money)
    puts
    puts "#{name} cards: #{cards}"
    puts "points:#{points} money: #{money}"
    puts
  end

  def action
    puts '1.Take card 2.Show cards 3.Skip turn'
    @input = gets.to_i
    variants = [1, 2, 3]
    raise 'Wrong input!' unless variants.include?(@input)
  end

  def lose
    puts '==> You lose.'
  end

  def win
    puts '==> You win.'
  end

  def draw
    puts '==> It is draw.'
  end

  def no_money(name)
    puts "#{name} have no money!"
    exit
  end

  def exit_game
    puts 'Want to go out? (Y/N)'
    input = gets.chomp.upcase
    answers = ['Y', 'N']
    raise 'Wrong entry!' unless answers.include?(input)
    exit if input == 'Y'
  end
 
end
