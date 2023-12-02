require 'minitest/autorun'
require_relative 'main'

class Test < Minitest::Test
  def test_leading_trailing_digits
    assert_equal 12, number_from_line("1abc2")
  end

  def test_digits_internal
    assert_equal 38, number_from_line("pqr3stu8vwx")
  end

  def test_multiple_digits
    assert_equal 15, number_from_line("a1b2c3d4e5f")
  end

  def test_single_digit
    assert_equal 77, number_from_line("trebu7chet")
  end

  def test_words_only
    assert_equal 12, number_from_line("onetwo")
  end

  def test_words_with_gibberish_between
    assert_equal 12, number_from_line("onefoobartwo")
  end

  def test_words_and_numbers
    assert_equal 14, number_from_line("1onetwothreefoobar4")
    assert_equal 13, number_from_line("1onetwothreefoobar")
    assert_equal 13, number_from_line("one2fivesix3")
  end
end

