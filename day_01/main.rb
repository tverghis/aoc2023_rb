DIGIT_WORDS = %w(one two three four five six seven eight nine)

def number_from_line(line)
  first, last = nil

  for i in 0...line.length
    c = line[i]
    if char_is_digit(c)
      first ||= c
      last = c
      next
    end

    for j in (i+1)...line.length
      if char_is_digit(line[j])
        break
      end
      word = line[i..j]
      if word_is_digit(word)
        digit = (DIGIT_WORDS.index(word) + 1).to_s
        first ||= digit
        last = digit
      end
    end
  end

  (first + last).to_i
end

def char_is_digit(b)
  b >= '0' and b <= '9'
end

def word_is_digit(w)
  DIGIT_WORDS.include? w
end

if __FILE__ == $0
  puts File.readlines("input.txt").map { |l| number_from_line(l) }.sum
end

