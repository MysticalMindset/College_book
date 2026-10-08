%
%    vibrationdata_mr_SRS.m  ver 1.0  by Tom Irvine
%
function[xmax,xmin,dmax,slope_p,slope_n,ref_error,ppp,nnn,nnnoct]=...
     vibrationdata_mr_SRS(dt,nspec,last,y,a1,a2,b1,b2,b3,f,good_freq,max_ref,min_ref,slope_goal)
%
for j=1:nspec
%
%%    clear yy;
%%    trailing=round(1./(dt*f(j)));
%%    yy=zeros((last+trailing),1);  
%%    yy(1:last)=y;
%    
    yy=y; 
    forward=[ b1(j),  b2(j),  b3(j) ];    
    back   =[     1, -a1(j), -a2(j) ];    
%    
    resp=filter(forward,back,yy);
%
    xmax(j)= max(resp);
    xmin(j)= abs(min(resp));
%
end
%
dmax=0;
%
ref_error=0.;
%
for j=1:nspec
%
    if(f(j)>good_freq)
        ref_error=ref_error+abs(20.*log10(xmax(j)/max_ref(j)))+abs(20.*log10(xmin(j)/min_ref(j)));
    end
% 
    db=abs(20.*log10(abs(xmax(j)/xmin(j))));
% 
    if(db>dmax)
       dmax=db;
    end 
    if(f(j)<=good_freq)
        ns=j;
    end    
end
%
ra=0;
rb=0;
%
for i=1:nspec
%       
     if(f(i)>good_freq)
        break;
     end
     for j=i+1:nspec
%       
          slope_p = 20.*log10(xmax(j)/xmax(i));
          slope_n = 20.*log10(xmin(j)/xmin(i));
%
          noct=log(f(j)/f(i))/log(2);
%
          slope_p=slope_p/noct;    
          slope_n=slope_n/noct; 
%
          slope_p=abs(slope_p-slope_goal);
          slope_n=abs(slope_n-slope_goal);
%
          if(slope_p>ra)
               ra=slope_p;
          end    
          if(slope_n>rb)
               rb=slope_n;
          end    
%            
     end
%     
	 ppp=xmax(ns)/xmax(1);
	 nnn=xmin(ns)/xmin(1);
	 nnnoct=log(f(ns)/f(1))/log(2.);
%
end
%
slope_p=ra;
slope_n=rb;