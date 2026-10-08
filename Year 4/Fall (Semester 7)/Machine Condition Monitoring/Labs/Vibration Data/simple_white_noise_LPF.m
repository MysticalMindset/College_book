%
%   simple_white_noise_LPF.m  ver 1.0  by Tom Irvine
%
function[X]=simple_white_noise_LPF(mu,sigma,nt,dt,f)


X=randn(nt,1);
X=fix_size(X);
%
X=X-mean(X);
X=X*sigma/std(X);
X=X+mu;

[X]=simple_Butterworth_LP_filter_function(X,dt,f);
