%
%   simple_white_noise.m  ver 1.1  by Tom Irvine
%
function[X]=simple_white_noise(mu,sigma,nt)

X=randn(nt,1);
X=fix_size(X);
%
X=X-mean(X);
X=X*sigma/std(X);
X=X+mu;
X=fix_size(X);