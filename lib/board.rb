class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @name1 = name1
    @name2 = name2
    @cups = Array.new(14) { Array.new }
    place_stones
  end

  def place_stones
    @cups.each_with_index do |el, i|
      next if i == 6 || i == 13
      @cups[i] = [:stone, :stone, :stone, :stone]
    end
  end

  def valid_move?(start_pos)
    raise "Invalid starting cup" if start_pos < 0 || start_pos > 12
    raise "Invalid starting cup" if @cups[start_pos].empty?
  end

  def make_move(start_pos, current_player_name)
    stones = @cups[start_pos]
    @cups[start_pos] = []
    index = start_pos
    until stones.empty?
      index += 1
      next if current_player_name == @name1 && index == 13
      next if current_player_name == @name2 && index == 6
      new_pos = index % 14
      @cups[new_pos].push(stones.pop)
    end

    render
    next_turn(new_pos)
  end

  def next_turn(ending_cup_idx)

    if ending_cup_idx == 6 || ending_cup_idx == 13
      :prompt
    elsif @cups[ending_cup_idx].size > 1
      ending_cup_idx
    else
      :switch
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    @cups.take(6).all? { |cup| cup.empty? } ||
    @cups[7..12].all? { |cup| cup.empty? }
  end

  def winner
    if @cups[6].size == @cups[13].size
      :draw
    else
      @cups[6].size > @cups[13].size ? @name1 : @name2
    end
  end
end
