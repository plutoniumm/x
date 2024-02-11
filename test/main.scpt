on logyX(zx as real, zy as real) -- limitation: zx>0 and zy≠1
	if zx ≤ 0 then return "The parameter zx should be >0"
	if zy ≤ 0 or zy = 1 then return "The base zy should be  >0 and ≠1"
	set x to (zx - 1) / (zx + 1) --convert big number zx to number -1<x<1
	set y to (zy - 1) / (zy + 1) --convert big number zy to number -1<y<1
	set theAccuracy to 1.0E-6 -- the precision
	set {Ln1, Ln2} to {2 * x, 2 * y} -- first Tailor serie's member
	set anLn to x / y
	set oldLn to anLn
	set {a1, a2} to {x, y} -- parts of Tailor serie's member
	set n to 1 -- counter of Tailor serie's member
	repeat
		set n to n + 1
		set {a1, a2} to {a1 * x * x, a2 * y * y} -- update part of Tailor serie's member
		set {adding1, adding2} to {2 * a1 / (2 * n - 1), 2 * a2 / (2 * n - 1)} -- new Tailor serie's members
		set {Ln1, Ln2} to {Ln1 + adding1, Ln2 + adding2}
		set anLn to Ln1 / Ln2 -- update ln's value
		if anLn > oldLn then --
			if anLn - oldLn < 0.1 * theAccuracy then exit repeat
		else
			if oldLn - anLn < 0.1 * theAccuracy then exit repeat
		end if
		set oldLn to anLn
	end repeat

  return anLn div 1 + (round 1000000 * (anLn mod 1)) / 1.0E+6
end logyX


on benford(num)
  set num to character 1 of num as integer
  set prob to logyX((1 + 1/num), 10)

  return prob*100
end benford

on run args
  set arg to "0"
  if class of args is list then
    set arg to item 1 of args
  else
    exit
  end if

  set arg to benford(arg)

  return arg
end run