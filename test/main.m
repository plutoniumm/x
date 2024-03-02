% OCTAVE
args = argv();
if length(args) < 1
    error('Not enough input arguments');
end
x = str2num(args{1});

% bessel func
alpha = pi;
[ires, ierr] = besselj(alpha, x);
ires = round(ires .* 100) ./ 100;
disp(ires);