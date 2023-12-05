require 'minitest/autorun'
require_relative 'main'

class ScratchcardTest < Minitest::Test
  def test_from_string
    str = "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53"

    c = Scratchcard.from_string(str)

    assert_equal [41, 48, 83, 86, 17], c.winning_numbers
    assert_equal [83, 86, 6, 31, 17, 9, 48, 53], c.card_numbers
  end

  def test_point
    c1 = Scratchcard.from_string("Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53")
    c2 = Scratchcard.from_string("Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19")
    c3 = Scratchcard.from_string("Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1")
    c4 = Scratchcard.from_string("Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83")
    c5 = Scratchcard.from_string("Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36")
    c6 = Scratchcard.from_string("Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11")

    assert_equal 8, c1.points
    assert_equal 2, c2.points
    assert_equal 2, c3.points
    assert_equal 1, c4.points
    assert_equal 0, c5.points
    assert_equal 0, c6.points
  end
end
