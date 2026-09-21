% Q2a = nthroot( (8+(80/2.6)),3 ) + exp(3.5)
% Q2b = ( ((1/(sqrt(75))) + (73/(3.1)^3))^(1/4) ) + 55 * 0.41
% Q4a = ( ((3.8)^2)/(2.75-41*25) ) + ( (5.2+1.8^5)/sqrt(3.5) )
% Q4b = (2.1*(10^6)-15.2*(10^5))/(3*(nthroot(6*10^11,3)) )
% z = 4.5
% Q6a = (0.4*z)^4 + (3.1*z)^2 - 162.3*z - 80.7
% Q6b = (z^3-23)/(nthroot(z^2+17.5,3))
% x = 6.5; y= 3.8;
% Q8a = ((x^2+y^2)^(2/3))+((x*y)/(y-x))
% Q8b = (sqrt(x+y)/(x-y)^2)+ (2*x^2) - (x*y^2)
% x = pi/10
% Q10a1 = cos(x)^2 - sin(x)^2;
% Q10a2 = 1-2*sin(x)^2;
% Q10b1 = tan(x)/(sin(x)-2*tan(x))
% Q10b2 = 1/(cos(x)-2)

%{
rc = 15; ra = 10.5; rb = 4.5;
c = rc + ra;
a = ra + rb;
b = rb + rc;

gamma = ((a^2)+(b^2)-(c^2))/(2*a*b);
Q16a = acosd(gamma);

alpha = (sind(Q16a)*a)/(c);
Q16b = asind(alpha);

beta = (sind(Q16a)*a)/(b);
Q16c = asind(beta);

Q16a = round(Q16a);
Q16b = round(Q16b);
Q16c = round(Q16c);

sumtri = Q16c+Q16a+Q16b;
%}