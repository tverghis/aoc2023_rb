class Subset
  attr_accessor :counts

  def self.from_string(str)
    counts = str.split(",")
      .map(&:strip)
      .map(&:split)
      .map { |c| { c.last.to_sym => c.first.to_i }}
      .reduce(&:merge!)

    Subset.new(counts)
  end

  def initialize(counts)
    @counts = {red: 0, green: 0, blue: 0}.merge! counts
  end

  def ==(other)
    @counts = other.counts
  end

  def to_s
    @counts.to_s
  end

  def possible?(totals)
    @counts[:red] <= totals[:red] &&
      @counts[:green] <= totals[:green] &&
      @counts[:blue] <= totals[:blue]
  end
end

class Game
  attr_accessor :id, :subsets

  def self.from_string(str)
    name_str, subsets_str = str.split(":")
    id = name_str.split.last.to_i

    subsets = subsets_str.split(";").map(&:strip).map(&Subset.method(:from_string))
    Game.new(id, subsets)
  end

  def initialize(id, subsets)
    @id = id
    @subsets = subsets
  end

  def ==(other)
    @id = other.id && @subsets = other.subsets
  end

  def to_s
    @subsets.to_s
  end

  def possible? (totals)
    @subsets.all? { |s| s.possible? totals }
  end

  def mins
    m = @subsets.first.counts
    for s in subsets
      m[:red] = [m[:red], s.counts[:red]].max
      m[:green] = [m[:green], s.counts[:green]].max
      m[:blue] = [m[:blue], s.counts[:blue]].max
    end

    m
  end

  def power_of_mins
    self.mins.values.inject(:*)
  end
end

def sum_of_possible_games(games, totals)
  games.select { |g| g.possible? totals }
    .map(&:id)
    .sum
end

def sum_of_power_of_mins(games)
  games.map(&:power_of_mins).sum
end

if __FILE__ == $0
  totals = { red: 12, green: 13, blue: 14 }
  games =  File.readlines("input.txt").map(&Game.method(:from_string))

  puts "Part 1: #{sum_of_possible_games(games, totals)}"
  puts "Part 2: #{sum_of_power_of_mins(games)}"
end

