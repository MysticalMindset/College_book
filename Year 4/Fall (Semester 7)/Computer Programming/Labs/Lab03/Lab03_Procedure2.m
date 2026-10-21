disp('Chapter 3, Question 20:');
a = [7, -4, 6];
b = [-4, 7, 5];
c = [5, -6, 8];

LHS = cross(a, cross(b,c));
disp("Left Hand Side:");
disp(LHS);
RHS = (b*dot(a,c))-(c*dot(a,b));
disp("Right Hand Side:");
disp(RHS);
identity = isequal(LHS,RHS);
disp("Should return with a 1 if the identity is equal to each other:")
disp(identity);
pause; clc; clear;

format long

disp(['Chapter 3, Question 22:' newline 'A)' newline 'n = ']);
n1 = 1:5;
sum5 = sum(1./n1.^2);
disp(sum5);
pause;

disp(['Chapter 3, Question 22:' newline 'B)' newline 'n = ']);
n2 = 1:50;
sum50 = sum(1./n2.^2);
disp(sum50);
pause;

disp(['Chapter 3, Question 22:' newline 'C)' newline 'n = ']);
n3 = 1:5000;
sum5000 = sum(1./n3.^2);
disp(sum5000);
pause;

exact = (pi^2)/6;

err = exact - [sum5, sum50, sum5000];
disp("The sum of 5000 is the closest.");
disp(err);
pause; clc; clear;


format long
x = 2;

disp(['Chapter 3, Question 24:' newline 'A)' newline 'n = ']);
n1 = 0:5;
sum5 = sum(x.^n1 ./ factorial(n1));
disp(sum5);
pause;

disp(['Chapter 3, Question 24:' newline 'B)' newline 'n = ']);
n2 = 0:15;
sum15 = sum(x.^n2 ./ factorial(n2));
disp(sum15);
pause;

disp(['Chapter 3, Question 24:' newline 'C)' newline 'n = ']);
n3 = 0:25;
sum25 = sum(x.^n3 ./ factorial(n3));
disp(sum25);
pause;

exact = exp(2);

err = exact - [sum5, sum15, sum25];
disp("The sum of 25 is the closest.");
disp(err);
pause; clc; clear;


A = [5 -3 7; 1 0 -6; -4 8 9];
B = [3 2 -1; 6 8 -7; 4 4 0];
C = [-9 8 3; 1 7 -5; 3 3 6];

disp(['Chapter 3, Question 29:' newline 'A)']);
id_1 = A+B;
id_2 = B+A;

disp(id_1);
disp(id_2);
disp("Should return with a 1 if the identity is equal to each other:");
id_ans1 = isequal(id_1, id_2);
disp(id_ans1);
pause;

disp(['Chapter 3, Question 29:' newline 'B)']);
id_3 = A*(B*C);
id_4 = (A*B)*C;

disp(id_3);
disp(id_4);
disp("Should return with a 1 if the identity is equal to each other:");
id_ans2 = isequal(id_3, id_4);
disp(id_ans2);
pause;

disp(['Chapter 3, Question 29:' newline 'C)']);
id_5 = 5*(B+C);
id_6 = (5*B)+(5*C);

disp(id_5);
disp(id_6);
disp("Should return with a 1 if the identity is equal to each other:");
id_ans3 = isequal(id_5, id_6);
disp(id_ans3);
pause;

disp(['Chapter 3, Question 29:' newline 'D)']);
id_7 = (A+B)*C;
id_8 = (A*C)+(B*C);

disp(id_7);
disp(id_8);
disp("Should return with a 1 if the identity is equal to each other:");
id_ans4 = isequal(id_7, id_8);
disp(id_ans4);
pause; clc; clear;

format bank
disp(['Chapter 3, Question 33:']);
%eq1 -> -2x+5y+7z = -17.5
%eq2 -> 3x-6y+2z = 40.6
%eq3 -> 9x-3y+8z = 56.2
LHS = [-2 5 7; 3 -6 2; 9 -3 8];
RHS = [-17.5; 40.6; 56.2];
equ = LHS \ RHS;
disp(equ);
pause; clc; clear;

disp(['Chapter 3, Question 37:']);
V1 = 28; V2 = 36; V3 = 42; 
R1 = 16; R2 = 10; R3 = 6; 
R4 = 12; R5 = 8;  R6 = 14; 
R7 = 4; R8 = 5;

% Matrix A %
A = [-(R1+R3),R3,0,0; 
    R3,-(R2+R3+R4+R6),R4,R6; 
    0,R4,-(R4+R5+R7),R7; 
    0,R6,R7,-(R6+R7+R8)];
% Matrix B %
B = [-V1;0;V2;-V3];

% Calculation's %
x = A\B;
i1 = x(1); i2 = x(2); i3 = x(3); i4 = x(4);

% Current through each resistor
I_R1 = i1;
I_R2 = i2;
I_R3 = i1 - i2;
I_R4 = i2 - i3;
I_R5 = i3;
I_R6 = i4 - i2;
I_R7 = i4 - i3;
I_R8 = i4;

fprintf('Mesh currents:\ni1=%.4f, i2=%.4f, i3=%.4f, i4=%.4f A\n', i1,i2,i3,i4);
fprintf('R1=%.4f R2=%.4f R3=%.4f R4=%.4f\n', I_R1,I_R2,I_R3,I_R4);
fprintf('R5=%.4f R6=%.4f R7=%.4f R8=%.4f\n\n', I_R5,I_R6,I_R7,I_R8);

% To verify if its correct it should output the same values as B %
QED = A*x;
disp("QED =");
disp(QED);
