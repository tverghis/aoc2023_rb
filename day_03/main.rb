class Matrix
  attr_accessor :matrix

  def initialize(matrix)
    @matrix = matrix
  end

  def self.from_lines(lines)
    matrix = lines.map { |l| l.chars }
    Matrix.new(matrix)
  end

  def num_rows
    @matrix.length
  end

  def num_cols
    @matrix.first.length
  end

  def part_numbers
    visited = matrix.map { |row| row.map { |col| false } }
    part_numbers = []

    for i in 0...num_rows
      for j in 0...num_cols
        if !visited[i][j] && part_number?(i, j)
          n_start = n_end = j
          visited[i][j] = true

          while (n_start - 1 >= 0) && (digit?(@matrix[i][n_start - 1]))
            n_start -= 1
            visited[i][n_start] = true
          end

          while (n_end + 1 <= num_cols) && (digit?(@matrix[i][n_end + 1]))
            n_end += 1
            visited[i][n_end] = true
          end

          part_numbers << @matrix[i][n_start..n_end].join.to_i
        end
      end
    end

    part_numbers
  end

  private

  def part_number?(ridx, cidx)
    for r in ridx-1..ridx+1
      for c in cidx-1..cidx+1
        if (r < 0) || (r >= num_rows) ||
            (c < 0) || (c >= num_rows)
          next
        end

        if digit?(@matrix[ridx][cidx]) && symbol?(@matrix[r][c])
          return true
        end
      end
    end

    false
  end
end

def digit?(c)
  c in "0".."9"
end

def symbol?(c)
  # Assumes that the input only contains digits, symbols and periods
  !digit?(c) && (c != ".")
end

if __FILE__ == $0
  m = Matrix.from_lines(File.readlines("input.txt"))

  puts "Part 1: #{m.part_numbers.sum}"
end
