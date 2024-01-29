-- get args from stdin
local args = { ... }
if not args[1] then
  print("Usage: lua main.lua <filename>")
  os.exit(1)
end

-- calculate 2^args[1]
local function base7(n)
  n = tonumber(n)
  local result = 0
  local i = 0
  while n > 0 do
    local d = n % 7
    n = math.floor(n / 7)
    result = result + d * 10 ^ i
    i = i + 1
  end
  -- remove the .0
  return string.sub(tostring(result), 1, -3)
end

print(base7(args[1]))
