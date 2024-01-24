def cns(r)
  return (Math.cos(r)*6 + Math.sin(r)*9).abs().floor()
end

# Example usage
input_integer = ARGV[0].to_i

if input_integer.nil?
  puts "Please provide an integer argument."
else
  result = cns(input_integer)
  puts "#{result}"
end
