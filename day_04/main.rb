class Scratchcard
  attr_accessor :winning_numbers, :card_numbers

  def initialize(winning_numbers, card_numbers)
    @winning_numbers = winning_numbers
    @card_numbers = card_numbers
  end

  def self.from_string(str)
    winning_numbers, card_numbers = str.split(":")[1].split("|")

    winning_numbers = winning_numbers.split().map(&:to_i)
    card_numbers = card_numbers.split().map(&:to_i)

    Scratchcard.new(winning_numbers, card_numbers)
  end

  def num_matches
    @card_numbers.select { |n| @winning_numbers.include? n }.length
  end

  def points
    (2 ** (num_matches - 1)).floor
  end
end

def part_1(cards)
  cards.map { |c| c.points }.sum
end

def part_2(cards)
  counts = Array.new(cards.length, 1)

  for n in 0...cards.length
    counts[n].times do
      matches = cards[n].num_matches
      for j in 1..matches
        counts[n+j] += 1
      end
    end
  end

  counts.sum
end

if __FILE__ == $0
  cards = File.readlines("input.txt")
    .map { |l| Scratchcard.from_string l }

  puts "Part 1: #{part_1(cards)}"
  puts "Part 2: #{part_2(cards)}"
end
