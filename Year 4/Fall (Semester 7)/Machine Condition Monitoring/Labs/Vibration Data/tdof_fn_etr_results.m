
%
% tdof_fn_etr_results.m  ver 1.2  by Tom Irvine
%

function[fn,ModeShapes,pff,emm]=tdof_fn_etr_results(mass,stiffness,iu)

[fn,~,ModeShapes,MST]=Generalized_Eigen(stiffness,mass,2);
%
dof=length(fn);
%
v=ones(dof,1)';

disp(' ');
mass

stiffness


%
disp('        Natural    Participation    Effective      ');
disp('Mode   Frequency      Factor        Modal Mass     ');
%
LM=MST*mass*v';
pf=LM;
sum=0;
%    
mmm=MST*mass*ModeShapes;   
%

pff=zeros(dof,1);
emm=zeros(dof,1);

fn(abs(fn)<1.0e-05) = 0;

for i=1:dof
        pff(i)=pf(i)/mmm(i,i);
        emm(i)=pf(i)^2/mmm(i,i);
        out1 = sprintf('%d  %10.4g Hz   %10.4g   %10.4g   %10.4g',i,fn(i),pff(i),emm(i));
        disp(out1)
        sum=sum+emm(i);
end
out1=sprintf('\n modal mass sum = %8.4g ',sum);
disp(out1);


ModeShapes



 
etr=zeros(2,2);
em=zeros(2,1);
 
for i=1:2
    for k=1:2
        etr(i,k)=ModeShapes(i,k)*pff(k);
    end    
end

em(1)=pff(1)^2;
em(2)=pff(2)^2;

disp(' ');

if(iu==1)
    disp(' Effective Masses (lbm) ');
    out1=sprintf('\n  M00,1= %7.3g \n  M00,2= %7.3g \n ',em(1)*386,em(2)*386);
else
    disp(' Effective Masses (kg) ');
    out1=sprintf('\n  M00,1= %7.3g \n  M00,2= %7.3g \n ',em(1),em(2));    
end    
   
disp(out1);


disp(' ');
disp(' Effective Transmissibilities ');
disp(' ');

out1=sprintf('  T01,1= %7.3g \n  T01,2= %7.3g \n ',etr(1,1),etr(1,2));
disp(out1);

out1=sprintf('  T02,1= %7.3g \n  T02,2= %7.3g  ',etr(2,1),etr(2,2));
disp(out1);


assignin('base', 'two_dof_mass', mass);
assignin('base', 'two_dof_stiffness', stiffness);

assignin('base', 'two_dof_fn', fn);
assignin('base', 'two_dof_ModeShapes', ModeShapes);

disp(' ');
disp(' Output arrays:  two_dof_mass       ');  
disp('                 two_dof_stiffness  ');
disp('                 two_dof_fn         ');
disp('                 two_dof_ModeShapes ');

