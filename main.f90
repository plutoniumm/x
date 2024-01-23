! Montgomery Modular Exponentiation
function mod_exp(base, exponent, modulus) result(result_mod)
  implicit none
  integer(kind=8), intent(in) :: base, exponent, modulus
  integer(kind=8) :: result_mod, base_mod, exponent_mod, exp_hold

  base_mod = mod(base, modulus)
  result_mod = 1
  exp_hold = exponent

  do while (exp_hold > 0)
    exponent_mod = mod(exp_hold, 2)
    if (exponent_mod == 1) then
      result_mod = mod(result_mod * base_mod, modulus)
    end if
    base_mod = mod(base_mod * base_mod, modulus)
    exp_hold = exp_hold / 2
  end do

end function mod_exp

! Miller-Rabin Prime Test
function isprime(n) result(is)
  implicit none
  logical :: is
  integer(kind=8), intent(in) :: n
  integer :: r, saved_r,i
  integer(kind=8), dimension(3) :: w = [2, 3, 5]
  integer(kind=8) :: d, hold, witness, mod_exp, two

  two = 2

  is = .false.
  d = n - 1
  r = 0
  do while(mod(d, 2) == 0)
    d = d / 2
    r = r + 1
  end do

  do i = 1, size(w)
    is = .false.
    witness = w(i)
    hold = mod_exp(witness, d, n)
    if (hold == 1) then
      is = .true. ! PROBABLY prime
    else
      saved_r = r
      powers: do while (saved_r > 0)
        if (hold == n - 1) then
          is = .true. ! PROBABLY prime>>>
          exit powers
        else
          hold = mod_exp(hold,two, n)
          saved_r = saved_r - 1
        end if
      end do powers
    end if
    ! if is false here, then its not prime for the current witness
    if (.not. is) then
      exit
    end if
  end do
end function isprime

! main, check if 123456789 is prime
program main
  implicit none
  integer(kind=8) :: n
  character(len=2) :: cin
  logical :: isprime
  logical :: is
  ! n = 1234567

  call get_command_argument(1, cin)
  read(cin, *) n

  if (n < 0) then
    print *, "not a positive integer"
    stop
  end if

  ! if <10 and 2,3,5,7 then prime
  if (n < 10) then
    if (n == 2 .or. n == 3 .or. n == 5 .or. n == 7) then
      is = .true.
    else
      is = isprime(n)
    end if
  end if

  if (is) then
    print *, "prime"
  else
    print *, "composite"
  end if
end program main