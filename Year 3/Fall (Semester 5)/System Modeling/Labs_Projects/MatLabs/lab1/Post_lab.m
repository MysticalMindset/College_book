% % --- Post Lab 1 --- %
% m = 1;         % mass (kg)
% b = 3;         % viscous friction coefficient %(changed 5 and 80)%
% k = 5;        % spring constant (N/m)
% 
% syms t x(t);    % Define symbolic variables and symbolic function
% 
% %---Definition of successive derivatives---%
% D1x = diff(x,1);
% D2x = diff(x,2);
% 
% % Defined Input %
% f = 1.5*t;
% 
% % Defined the dynamic model
% eqn = m*D2x + b*D1x + k*x == 10*f;
% 
% sol = dsolve(eqn, x(0)==0, D1x(0)==0) % Response of the model
% 
% % Plot the solution
% figure;
% fplot(sol, [0,10]), grid on
% xlabel('time (sec)'), ylabel('x(t)'), title('System Response')

% --- Post Lab 2 --- %
% Enter the input-output data
x = [0 2 4 6];
y = [4.5 39 72 94];

% Compute the slope
m = sum(x.*y)/sum(y.^2);

% Compute the stiffness k
k = 1/m;

% Compute the linear model from f=kx
xl = y./k;

% Plot the linear model and the data
figure;
plot(y,xl,y,x,'o')
title('Linear Model & Data')

% Compute the sum of the squares of the residuals 
J = sum((m*y-x).^2)