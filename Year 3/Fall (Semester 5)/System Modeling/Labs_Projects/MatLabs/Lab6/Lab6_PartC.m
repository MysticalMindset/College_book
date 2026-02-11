R = 100; 				% Resistance (Ohms) 
C = 0.05; 				% Capacitance (F) 
L = 5; 					% Inductance (H) 

num = [1/(L*C)]; 			% Numerator coefficients 
den = [1 R/L 1/(L*C)]; 		% Denominator coefficients 
G = tf(num,den) 			% Create transfer function

z = R*sqrt(C/L)/2			% Damping Ratio
wn = 1/sqrt(L*C)			% Undamped Natural Frequency (rad/sec)

P = pole(G)				% Poles

figure; pzmap(G)			% Pole-Zero Map
figure; step(G)			% Step response plot
xlim([0 30])            	      % Time axis limit of step response plot

stepinfo(G)				% Step response specifications