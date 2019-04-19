# @@characters : our sexy players
# @name : a player name
# @symbole : a player symbole
# @character : TODO, choose a character. If not done : yesterday night was a great one
# @player_id : not used (see @game_won). An auto-incrementing Integer to identify users
# @game_won : TODO, count games won. Check @character

# :get_name : ask for a name (not robust)
# :get_id : attribute a uniq ID
# :get_symbol : ask for a 1 character long symbol
# :get_character : TODO
# :show_character : TODO
# :pick_character : TODO
#
# :play : ask for a cell. Todo : change name (game.play exists)
#
# :increment_id : +1 to the ID/player count

require 'pry'
require_relative 'game'

class Player
  attr_accessor :player_name, :game_won, :symbol, :characters, :play_turn,
                :user_input, :play
  attr_reader :name, :symbol, :character, :player_id
  @@characters = {
    'table': '(ヘ･_･)ヘ┳━┳'.freeze,
    'magician': '╰( ⁰ ਊ ⁰ )━☆ﾟ.*･｡ﾟ'.freeze,
    'pointer': '(☞ﾟヮﾟ)☞'.freeze,
    'drunk': 'ヽ（´ー｀）┌'.freeze,
    'angry': '(つ◉益◉)つ'.freeze
  }

  @@player_id = 0

  def initialize
    @name = get_name
    @symbole = get_symbol
    @character = ''
    @player_id = get_id
    @game_won = 0
  end


  #####################
  #  PLAYER SETTINGS  #
  #####################

  def get_name
    print "Enter your name: "
    @name = gets.chomp
  end

  def get_id
    @player_id = @@player_id
    increment_id
  end

  def get_symbol
    puts "Choose a symbol (1 character)"
    symbol = gets.chomp
    while (symbol.length > 1)
      puts "Symbols should be 1 character long"
      symbol = gets.chomp
    end
    @symbol = symbol
  end

  def get_character
    if @character.empty?
      show_characters
      pick_character
    else
      @character
    end
  end

  def show_characters
    i = 1 
    @@characters.each_value do |ascii_char, index|
      puts "#{i})  #{ascii_char}"
      i += 1
    end
  end

  def pick_character
    input = gets.chomp
    case input
      when 1 then @character = @@characters[:table]
      when 2 then @character = @@characters[:magician]
      when 3 then @character = @@characters[:pointer]
      when 4 then @character = @@characters[:drunk]
      when 5 then @character = @@characters[:angry]
    end
  end


  ####################
  #  PLAYER ACTIONS  #
  ####################

  # def choose_cell
  #   puts "????"
  #   @player_input = gets.chomp.capitalize
  # end
  
  def play
    print "\n\n\n#{self.name}'s turn. Select a cell: "
    gets.chomp.capitalize
  end

  private

  def increment_id
     @@player_id += 1
  end
end
