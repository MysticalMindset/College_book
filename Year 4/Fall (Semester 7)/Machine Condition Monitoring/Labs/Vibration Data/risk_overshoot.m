
% risk_overshoot.m  ver 1.0  by Tom Irvine

function[ps]=risk_overshoot(fn,T,ax)

arg=fn*T;

[ps]=maximax_peak(fn,T); 

ccc=(1-(1-ax)^(1/arg));
        
term=-log(ccc);
        
ps=ps*sqrt(term/log(arg));   % ECSS method 