# The answer is 9183 when min = 2 and max = 100

def distinct_powers(min, max)
  Array(min..max).map do |base|
    Array(min..max).map do |exponent|
      base ** exponent
    end
  end.flatten.uniq.count
end
