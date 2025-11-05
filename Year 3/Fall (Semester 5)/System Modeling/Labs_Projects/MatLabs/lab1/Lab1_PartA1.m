% --- Part 1 --- %
m = 10;         % mass (kg)
b = 20;         % viscous friction coefficient %(changed 5 and 80)%
k = 100;        % spring constant (N/m)

syms t y(t);    % Define symbolic variables and symbolic function

%---Definition of successive derivatives of y(t)---%
D1y = diff(y,1);
D2y = diff(y,2);

% Defined ramp Input %
u = t;
Du = diff(u,t);

% Defined the dynamic model
eqn1 = m*D2y + b*D1y + k*y == b*Du + k*u;

sol1 = dsolve(eqn1, y(0)==0, D1y(0)==0) % Response of the model

% Plot the solution y(t) as a function of t
figure;
fplot(sol1, [0,10]), grid on
xlabel('time (sec)'), ylabel('y(t)'), title('Mass Displacement (Ramp Imput)')
