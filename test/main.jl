# Check if command-line argument is provided
if length(ARGS) != 1
  println("Usage: julia script.jl X")
  println("Please provide one argument X")
  exit(1)
end

# Parse command-line argument
X = 0.0
try
  global X = parse(Float64, ARGS[1])
catch
  println("Error: Please provide a valid number for X")
  exit(1)
end

# Calculate and print the arctangent of X
rad = atan(X)
deg = rad * 180 / π
deg = round(deg, digits=2)
println(deg)
