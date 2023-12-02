require 'minitest/autorun'
require_relative 'main'

class SubsetTest < Minitest::Test
  def test_subset_from_string
    subset = Subset.from_string("3 blue, 4 red, 1 green")
    
    assert_equal Subset.new({ blue: 3, red: 4, green: 1 }), subset
  end

  def test_incomplete_from_string
    subset = Subset.from_string("3 red")
    assert_equal({red: 3, green: 0, blue: 0}, subset.counts)

    subset = Subset.from_string("3 green")
    assert_equal({red: 0, green: 3, blue: 0}, subset.counts)

    subset = Subset.from_string("3 blue")
    assert_equal({red: 0, green: 0, blue: 3}, subset.counts)
  end

  def test_possible
    subset = Subset.new({ red: 3, green: 4, blue: 1})

    assert subset.possible?({ red: 3, green: 4, blue: 1 })
    assert subset.possible?({ red: 10, green: 10, blue: 10 })
  end

  def test_impossible
    subset = Subset.new({ red: 3, green: 4, blue: 1})

    assert !subset.possible?({ red: 0, green: 5, blue: 5})
    assert !subset.possible?({ red: 5, green: 0, blue: 5})
    assert !subset.possible?({ red: 5, green: 5, blue: 0})
  end
end

class GameTest < Minitest::Test
  def test_game_from_string
    game = Game.from_string("Game 6: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green")

    assert_equal Game.new(6, [
      Subset.from_string("3 blue, 4 red"),
      Subset.from_string("1 red, 2 green, 6 blue"),
      Subset.from_string("2 green")
    ]), game
  end

  def test_possible
    game = Game.from_string("Game 6: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green")

    assert game.possible?({ red: 10, green: 10, blue: 10 })
  end

  def test_impossible
    game = Game.from_string("Game 6: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green")

    assert !game.possible?({ red: 0, blue: 10, green: 10 })
    assert !game.possible?({ red: 10, blue: 0, green: 10 })
    assert !game.possible?({ red: 10, blue: 10, green: 0 })
  end

  def test_mins
    game = Game.from_string("Game 6: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green")
    assert_equal({ red: 4, green: 2, blue: 6 }, game.mins)
  end

  def test_power_of_mins
    game = Game.from_string("Game 6: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green")
    assert_equal 48, game.power_of_mins
  end
end

