disp(' ');
disp(' Results');
disp(' ');
disp(' Case   Amplitude   fn(Hz)   Phase(rad)  ');
%
tp=2*pi;
%
for ie=1:nfr
    out4 = sprintf('  %d  %10.4f  %10.4f  %10.4f  ',ie,x1r(ie),x2r(ie)/tp,x3r(ie));
    disp(out4)      
end    


x1r=fix_size(x1r);
x2r=fix_size(x2r);
x3r=fix_size(x3r);

aaa=[x1r x2r/tp x3r];
bbb=sortrows(aaa,2);
setappdata(0,'curve_fit_table',bbb);


%%%%%%%%%%%





%
disp(' ');
disp(' Results');
disp(' ');
disp(' Case   Amplitude   fn(Hz)       damp      Phase(rad)  Delay(sec) ');
%
for ie=1:nfr
    out4 = sprintf('  %d  %10.4f  %10.4f  %10.4f  %10.4f  %10.4f ',...
                            ie,x1r(ie),x2r(ie)/tp,x4r(ie),x3r(ie),x5r(ie));
    disp(out4)      
end    
%
%%%%
%

x1r=fix_size(x1r);
x2r=fix_size(x2r);
x3r=fix_size(x3r);
x4r=fix_size(x4r);
x5r=fix_size(x5r);

aaa=[x1r x2r x3r x4r x5r];

bbb=sortrows(aaa,2);

sx1r=bbb(:,1);
sx2r=bbb(:,2);
sx3r=bbb(:,3);
sx4r=bbb(:,4);
sx5r=bbb(:,5);

bbb(:,2)=bbb(:,2)/tp;

setappdata(0,'curve_fit_table',bbb);

ccc=sortrows(aaa,-1);

ax1r=ccc(:,1);
ax2r=ccc(:,2);
ax3r=ccc(:,3);
ax4r=ccc(:,4);
ax5r=ccc(:,5);

% % % % % %

disp(' ');
disp(' Results, sorted by frequency');
disp(' ');
disp(' Case   Amplitude   fn(Hz)       damp      Phase(rad)  Delay(sec) ');
%
for ie=1:nfr
    out4 = sprintf('  %d  %10.4f  %10.4f  %10.4f  %10.4f  %10.4f ',...
                            ie,sx1r(ie),sx2r(ie)/tp,sx4r(ie),sx3r(ie),sx5r(ie));
    disp(out4)      
end    

% % % % % %

disp(' ');
disp(' Results, sorted by Amplitude');
disp(' ');
disp(' Case   Amplitude   fn(Hz)       damp      Phase(rad)  Delay(sec) ');
%
for ie=1:nfr
    out4 = sprintf('  %d  %10.4f  %10.4f  %10.4f  %10.4f  %10.4f ',...
                            ie,ax1r(ie),ax2r(ie)/tp,ax4r(ie),ax3r(ie),ax5r(ie));
    disp(out4)      
end    
