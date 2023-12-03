require 'minitest/autorun'
require_relative 'main'

class MatrixTest < Minitest::Test
  def test_from_lines
    lines = [".1.", "2*.", "3.."]
    m = Matrix.from_lines(lines)

    assert_equal [%w(. 1 .), %w(2 * .), %w(3 . .)], m.matrix
    assert_equal 3, m.num_rows
    assert_equal 3, m.num_cols
  end

  def test_part_numbers
    lines = [
      "467..114..",
      "...*......",
      "..35..633.",
      "......#...",
      "617*......",
      ".....+.58.",
      "..592.....",
      "......755.",
      "...$.*....",
      ".664.598.."
    ]
    m = Matrix.from_lines(lines)

    assert_equal [467, 35, 633, 617, 592, 755, 664, 598], m.part_numbers
  end
end
