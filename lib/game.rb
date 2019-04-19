# @board : String, use for display & primary analysis
# @game_state : Hash, use for determine victory
# @player1, @player2 : <Player>, our 2 players
# @turn : Integer, use for dertimine who's turn it is
# @victory : I struggled with that. We should talk about that !


# :display_board : display board
# :error_input : warn user of wrong input, ask him to re-type it
# :who_play : check who's turn is it
# :next_turn : increment @turn, used to determine who's turn is it
#
# :play : a turn routine
# :update_board : place player's pawn on the board. DOES NOT refresh @game_state
# :available? : boolean, true if no pawn on this cell yet
# :define_cell_selected : link between user input and cell's position 
#                         cell n = @board[n]
# 
# :analyze_[stuff] : check @board[n] element, store it in @game_state
#
# :check_victory : compare each @game_state values to 3 times each player's symbole
# :someone_win? : boolean, is there a winner yet ?



require 'pry'
require_relative 'player'

class Game
  attr_accessor :board, :game_state, :update_board, :play, :define_cell_selected
  attr_reader :victory


  ##############
  #    META    #
  ##############

  def initialize
    @board = "
      1   2   3
    +---+---+---+
  A |   |   |   |
    +---+---+---+
  B |   |   |   |
    +---+---+---+
  C |   |   |   |
    +---+---+---+"
    @game_state = {
      '1': '',
      '2': '',
      '3': '',
      'A': '',
      'B': '',
      'C': '',
      'diag1': '',
      'diag2': ''
    }
    @player1 = Player.new
    @player2 = Player.new
    @turn = 0
    @victory = ''
  end

  def display_board
    puts @board
  end

  # > Warn + ask again
  def error_input
    puts "Invalid input"
    who_play
  end

  # > Determine who's turn it is
  def who_play
    (@turn % 2 == 0) ? update_board(@player1) : update_board(@player2)
  end

  def next_turn
    @turn += 1
  end


  ##############
  #    TURN    #
  ##############

  # > Main loop
  def play
    display_board
    self.who_play
    next_turn
    analyze_board
    check_victory
  end

  # > Place pawn
  def update_board(player)
    cell = define_cell_selected(player)
    while @board[cell] != ' '
      display_board
      cell = define_cell_selected(player)
    end
    @board[cell] = player.symbol
  end

  def available?(cell)
    cell == ' ' ? true : false
  end

  # > user input <=> cell position
  def define_cell_selected(player)
    input = player.play
    case input
    when "A1" then 41
    when "A2" then 45
    when "A3" then 49
    when "B1" then 77
    when "B2" then 81
    when "B3" then 85
    when "C1" then 113
    when "C2" then 117
    when "C3" then 121
    else
      error_input
    end
  end


  ##################
  # BOARD ANALYSIS #
  ##################

  # > Update @game_state (used for win conditions)
  def analyze_board
      analyze_rows
      analyze_columns
      analyze_diags
  end

  def analyze_rows
    @game_state[:'A'] = @board[41] + @board[45] + @board[49] # A1 + A2 + A3
    @game_state[:'B'] = @board[77] + @board[81] + @board[85] # B1 + B2 + B3
    @game_state[:'C'] = @board[113] + @board[117] + @board[121] # C1 + C2 + C3
  end

  def analyze_columns
    @game_state[:'1'] = @game_state[:'A'][0] + @game_state[:'B'][0] + @game_state[:'C'][0]
    @game_state[:'2'] = @game_state[:'A'][1] + @game_state[:'B'][1] + @game_state[:'C'][1]
    @game_state[:'3'] = @game_state[:'A'][2] + @game_state[:'B'][2] + @game_state[:'C'][2]
  end

  def analyze_diags
    @game_state[:'diag1'] = @game_state[:'A'][0] + @game_state[:'B'][1] + @game_state[:'C'][2]
    @game_state[:'diag2'] = @game_state[:'A'][2] + @game_state[:'B'][1] + @game_state[:'C'][0]
  end


  #################
  # WIN CONDITION #
  #################

  # > Determine victory
  def check_victory
    @game_state.each_value do |line|
      if line == @player1.symbol * 3
        puts "#{@player1.name} won !"
        return someone_win(@player1)
      elsif line == @player2.symbol * 3
        puts "#{@player2.name} won !"
        return someone_win(@player2)
      end
    end
  end

  # > Couldnt return 'true' with the previous method (check_victory)
  # > Help welcome ! :)
  def someone_win?(player)
    puts 'yes mamen'
    @victory = 'yes mamen'
    true
  end
end
