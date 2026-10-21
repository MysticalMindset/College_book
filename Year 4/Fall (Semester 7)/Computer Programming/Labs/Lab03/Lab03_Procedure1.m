format bank
nthyear = [0:5:30]; L = 100000; r = 0.06; n = 30;
B = L*((1 + r/12)^(12*n) - (1 + r/12).^(12*nthyear)) ./ ((1 + r/12)^(12*n) - 1);

disp(['Chapter 3, Question 7:' newline]);
disp([nthyear; B])
pause; clc; clear;

disp(['Chapter 3, Question 8:' newline]);
u = [-5.6, 11, -14];
length_u = sqrt(sum(u .* u));
disp(length_u);
pause; clc; clear;

disp(['Chapter 3, Question 9:' newline 'A)' newline ' U =']);
u = [4,13,-7];
disp(u);
pause;

disp(['Chapter 3, Question 9:' newline 'B)' newline ' Lu =']);
Lu = sqrt( sum(u.^2));
disp(Lu);
pause;

disp(['Chapter 3, Question 9:' newline 'C)' newline ' un =']);
un = (u/Lu);
disp(un);
pause;

disp(['Chapter 3, Question 9:' newline 'D)' newline ' un =']);
un = sqrt ( sum(un.^2));
disp(un);
pause; clc; clear;

disp(['Chapter 3, Question 10:']);
u1 = [3.2, -6.8, 9];
u2 = [-4, 2, 7];
theta = acosd(sum(u1 .* u2) / (sqrt(sum(u1 .* u1)) * sqrt(sum(u2 .* u2))));
disp(theta);
pause; clc; clear;