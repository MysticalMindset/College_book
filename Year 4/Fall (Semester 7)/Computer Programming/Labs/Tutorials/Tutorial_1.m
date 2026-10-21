% Tutorial 1 - Problem 2 Submission %

% Evaluated numbers already given %
V1 = 28; V2 = 36; V3 = 42;
R1 = 16; R2 = 10; R3 = 6; R4 = 12;
R5 = 8;  R6 = 14; R7 = 4; R8 = 5;

% Matrix A %
A = [-(R1+R3),R3,0,0;
     R3,-(R2+R3+R4+R6),R4,R6;
     0,R4,-(R4+R5+R7),R7;
     0,R6,R7,-(R6+R7+R8)]

% Matrix B %
B = [-V1;0;V2;-V3]

% Calculation's %
x = A\B
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

fprintf('Mesh currents: i1=%.4f, i2=%.4f, i3=%.4f, i4=%.4f A\n', i1,i2,i3,i4);
fprintf('R1=%.4f R2=%.4f R3=%.4f R4=%.4f\n', I_R1,I_R2,I_R3,I_R4);
fprintf('R5=%.4f R6=%.4f R7=%.4f R8=%.4f\n', I_R5,I_R6,I_R7,I_R8);

% To verify if its correct it should output the same values as B %
QED = A*x