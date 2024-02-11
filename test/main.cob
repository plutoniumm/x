       identification division.
       program-id. Calculate-V.
       data division.
       working-storage section.
       01 M pic 9(10)V9(2).
      *>  01 V pic 9(6)V9(2).
       01 V pic 99999V99.
       01 V2 pic ZZZZZZ.99.
       01 G pic 9(16)V9(14) VALUE 0.00000000006674.
       01 R pic 9(10) VALUE 6400000.
       01 ARG pic X(100).

       procedure division.
           accept ARG from command-line.
           if ARG = spaces then
               display "Please provide multiple of earth M as CL arg"
           else
               move function numval(ARG) to M
               compute V = function sqrt((2 * G * M * 5.97219E24) / R)
               compute V = V / 0000011160.53
                move V to V2
                display V2
           end-if.
       stop run.
