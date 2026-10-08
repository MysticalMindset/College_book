        if(abs(fc(i)-1000)<1)
            
            out1=sprintf(' fc=%g   dB1=%g   mpa=%8.4g',fc(i),dB1(i),mpa(1));
            out2=sprintf(' Ap1=%8.4g  Uc=%8.4g  cp(1)=%8.4g  a1=%g  a2=%g',Ap1,Uc,cp(1),a_1,a_2);
            out3=sprintf(' power_dB1=%8.4g  power1=%8.4g',power_dB1(i),power1(i));
            
            disp(out1);
            disp(out2);
            disp(out3);
            
            
            return;
        end    