

%  beam_stress_B  ver  1.0  by Tom Irvine

function[B]=beam_stress_B(x,L)

% http://web.mae.ufl.edu/nkim/eml5526/Lect05.pdf

B(1)=-6+12*x;
B(2)=L*(-4+6*x);
B(3)=-B(1);
B(4)=L*(-2+6*x);

B=B/L^2;