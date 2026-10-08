function[amp]=ws_scale(xmax,xmin,spec,exponent,amp,inn,nspec)
%    
    for(i=1:nspec)
%
        ave = (( abs(xmax(i)) + abs(xmin(i)) )/2.);
%
        ss= ( spec(i)/ave )^exponent;
%
        if(ss>=1.0e-20 && ss <=1.0e+20)
%
        else
%
            out1=sprintf('\n scale error: i=%ld  ss=%8.4g  ave=%8.4g  spec=%8.4g\n',i,ss,ave,spec(i));
            disp(out1);
%
        end
%
        amp(inn,i)=amp(inn,i)*ss;
% 
    end