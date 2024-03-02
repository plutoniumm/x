(
  let ((omega 0.1))
  (setf iters (nth 3 command-line-args))
  (setf iters (string-to-number iters))
  (
    dotimes (i iters)
    (setf omega (/ (+ 1 omega) (+ 1 (exp omega))))
  )
  (print omega)
)