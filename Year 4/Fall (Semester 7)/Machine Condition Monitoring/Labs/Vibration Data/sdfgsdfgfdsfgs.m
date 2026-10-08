

try
    p31_liftoff_psd_Barrett_6dB(:,2)=4*p31_liftoff_psd_Barrett(:,2);
    p31_liftoff_psd_Barrett_6dB(:,1)=p31_liftoff_psd_Barrett(:,1);
end

try
    p31_liftoff_psd_Barrett_sep_6dB(:,2)=0.339*p31_liftoff_psd_Barrett_6dB(:,2);
    p31_liftoff_psd_Barrett_sep_6dB(:,1)=p31_liftoff_psd_Barrett_6dB(:,1);
end


try
    p32_liftoff_psd_Barrett_6dB(:,2)=4*p32_liftoff_psd_Barrett(:,2);
    p32_liftoff_psd_Barrett_6dB(:,1)=p32_liftoff_psd_Barrett(:,1);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

liftoff_accel_psd_1_10dB_sep(:,2)=0.339*liftoff_accel_psd_1_10dB(:,2);
liftoff_accel_psd_1_10dB_sep(:,1)=liftoff_accel_psd_1_10dB(:,1);


ascent_accel_psd_max_1_4dB_sep(:,2)=0.339*ascent_accel_psd_max_1_4dB(:,2);
ascent_accel_psd_max_1_4dB_sep(:,1)=ascent_accel_psd_max_1_4dB(:,1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    liftoff_accel_psd_1_10dB(:,2)=4*liftoff_accel_psd_1_4dB(:,2);
    liftoff_accel_psd_1_10dB(:,1)=liftoff_accel_psd_1_4dB(:,1);
    liftoff_accel_psd_1_10dB(1,:)=[];
end


try
    p31_liftoff_sea_sep_10dB(:,2)=0.339*liftoff_accel_psd_1_10dB(:,2);  
    p31_liftoff_sea_sep_10dB(:,1)=liftoff_accel_psd_1_10dB(:,1); 
end

try
    liftoff_accel_psd_2_10dB(:,2)=4*liftoff_accel_psd_2_4dB(:,2);
    liftoff_accel_psd_2_10dB(:,1)=liftoff_accel_psd_2_4dB(:,1);
    liftoff_accel_psd_2_10dB(1,:)=[];
end

try
    liftoff_accel_psd_3_10dB(:,2)=4*liftoff_accel_psd_3_4dB(:,2);
    liftoff_accel_psd_3_10dB(:,1)=liftoff_accel_psd_3_4dB(:,1);
    liftoff_accel_psd_3_10dB(1,:)=[];
end

try
    liftoff_accel_psd_4_10dB(:,2)=4*liftoff_accel_psd_4_4dB(:,2);
    liftoff_accel_psd_4_10dB(:,1)=liftoff_accel_psd_4_4dB(:,1);
    liftoff_accel_psd_4_10dB(1,:)=[];
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    xp311_qual=p311_qual;
    xp312_qual=p312_qual;
    xp321_qual=p321_qual;
    xp322_qual=p322_qual;
    xsep_qual=sep_qual;
end