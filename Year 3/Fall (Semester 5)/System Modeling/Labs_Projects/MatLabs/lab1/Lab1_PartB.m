% Enter the input-output data
x = [0 0.15 0.23 0.35 0.37 0.5 0.6 0.57 0.68 0.77];		% Beam deflection (cm)	
f = [0 100 200 300 400 500 550 600 700 800];			% Applied force (N)

% 
% % Plot the data
% figure;
% plot(f,x,'o')
% xlabel('Applied Force (N)'), ylabel('Beam deflection (cm)')
% title('Beam deflection vs Applied force')

% Compute the slope
m = sum(f.*x)/sum(f.^2)

% Compute the stiffness k
k = 1/m

% Compute the linear model from f=kx
xl = f./k;

% Plot the linear model and the data
figure;
plot(f,xl,f,x,'o')
xlabel('Applied Force (N)'), ylabel('Beam deflection (cm)')
title('Linear Model & Data')

% Compute the sum of the squares of the residuals 
J = sum((m*f-x).^2)
