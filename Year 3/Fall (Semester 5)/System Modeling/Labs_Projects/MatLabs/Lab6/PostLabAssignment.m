% % Question 1
% num1 = 2.5;         % Numerator coefficients 
% den1 = [1 3 2];     % Denominator coefficients 
% G1 = tf(num1,den1)  % Create transfer function
% 
% num2 = 2.5;         % Numerator coefficients 
% den2 = [1 2 1];     % Denominator coefficients 
% G2 = tf(num2,den2)  % Create transfer function
% 
% num3 = 5;           % Numerator coefficients 
% den3 = [1 4 13];    % Denominator coefficients 
% G3 = tf(num3,den3)  % Create transfer function
% 
% num4 = 10;          % Numerator coefficients 
% den4 = [1 0 10];    % Denominator coefficients 
% G4 = tf(num4,den4)  % Create transfer function
% 
% figure; step(G1);
% figure; step(G2);
% figure; step(G3);
% figure; 
% step(G4);
% xlim([0 30]);
% ylim([0 2]);
% 
% figure; pzmap(G1);
% figure; pzmap(G2);
% figure; pzmap(G3);
% figure; pzmap(G4);

% % Question 2
% % Define the transfer function
% numerator = 96.0985;
% denominator = [1, 7.027, 90.659];
% system = tf(numerator, denominator);
% 
% % Mark steady-state value, peak time, rise time, and settling time
% steady_state_value = 1.06;
% peak_time = 0.355;
% rise_time = 0.15;
% settling_time = 1.13;
% 
% % Plot the step response
% t = 0:0.001:2;
% [y, t] = step(system, t);
% figure;
% plot(t, y, 'b-', 'MarkerSize', 1, 'DisplayName', 'Step Response');
% hold on;
% 
% % Key point markers
% h_peak = plot(t(find(t >= peak_time, 1)), y(find(t >= peak_time, 1)), 'o', 'MarkerFaceColor', 'blue', 'DisplayName', 'Peak Time');
% h_rise = plot(t(find(t >= rise_time, 1)), y(find(t >= rise_time, 1)), 'o', 'MarkerFaceColor', 'magenta', 'DisplayName', 'Rise Time');
% h_settle = plot(t(find(t >= settling_time, 1)), y(find(t >= settling_time, 1)), 'o','MarkerFaceColor', 'red', 'DisplayName', 'Settling Time');
% 
% % Green dashed line at steady-state value
% h1 = plot([0 max(t)], [steady_state_value steady_state_value], 'g--', 'LineWidth', 1);
% % Green steady-state marker
% h2 = plot(t(end), steady_state_value, 'go', 'MarkerFaceColor', 'green');
% % --- Combine steady-state line + marker into ONE legend entry ---
% h_ss = [h1 h2];
% 
% % Labels
% title('Step Response of the Second-Order System');
% xlabel('Time (seconds)');
% ylabel('Response');
% 
% % Final legend call (clean)
% legend([h_peak h_rise h_settle h_ss], {'Peak Time', 'Rise Time', 'Settling Time', 'Steady-State Value'});

