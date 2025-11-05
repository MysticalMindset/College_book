% Labs
% plot(out.tout,out.xout), grid on
% xlabel('Time (Sec)'), ylabel('x & y (m)')
% title('Displacement of Body & Road Profile - (Nonlinear Model)')
% 
% figure;
% plot(out.tout,out.force), grid on
% xlabel('Time (Sec)'), ylabel('Force (N)')
% title('Total transmitted force - (Nonlinear Model)')
% 
% figure;
% plot(out.tout,out.xout), grid on
% xlabel('time (sec)'), ylabel('x & y (m)')
% title('Displacement of Body & Road Profile – (Linear Model)')
% 
% figure;
% plot(out.tout,out.xout), grid on
% xlabel('time (sec)'), ylabel('x & y (m)')
% title('Displacement of Body & Road Profile with Controller (LA1)')
% 
% figure;
% plot(out.tout,out.xout2), grid on
% xlabel('time (sec)'), ylabel('x & y (m)')
% title('Displacement of Body & Road Profile with Controller (LA2)')

%--POST LAB--%
%Question 1

% figure;
% plot(out.yout), grid on
% xlabel('Time (sec)'), ylabel('Function')
% title('Post Lab Question 1')

% Question 2
plot(out.tout,out.xout), grid on
xlabel('Time (Sec)'), ylabel('x & y (m)')
title('Displacement of Body & Road Profile')

figure;
plot(out.tout,out.force), grid on
xlabel('Time (Sec)'), ylabel('Force (N)')
title('Total transmitted force')