%
%  subplots_three_linlin_three_titles_ss.m  ver 1.1  by Tom Irvine
%

function[fig_num]=subplots_three_linlin_three_titles_ss(fig_num,xlabel3,ylabel1,ylabel2,ylabel3,data1,data2,data3,t_string1,t_string2,t_string3)


try
    close fig_num;
end
try
    close fig_num hidden;
end

hp=figure(fig_num);

subplot(3,1,1);
plot(data1(:,1),data1(:,2));
grid on;
ylabel(ylabel1);
title(t_string1);
qqq=get(gca,'ylim');
qmax1=max(abs(qqq));
ylim([-qmax1,qmax1]);

%
subplot(3,1,2);
plot(data2(:,1),data2(:,2));
grid on;
ylabel(ylabel2);
title(t_string2);
qqq=get(gca,'ylim');
qmax2=max(abs(qqq));
ylim([-qmax2,qmax2]);


%
subplot(3,1,3);
plot(data3(:,1),data3(:,2));
grid on;
xlabel(xlabel3);
ylabel(ylabel3);
title(t_string3);
qqq=get(gca,'ylim');
qmax3=max(abs(qqq));
ylim([-qmax3,qmax3]);


qmax=max( [ qmax1 qmax2 qmax3   ]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


try
    close fig_num;
end
try
    close fig_num hidden;
end

hp=figure(fig_num);

subplot(3,1,1);
plot(data1(:,1),data1(:,2));
grid on;
ylabel(ylabel1);
title(t_string1);
ylim([-qmax,qmax]);

%
subplot(3,1,2);
plot(data2(:,1),data2(:,2));
grid on;
ylabel(ylabel2);
title(t_string2);
ylim([-qmax,qmax]);


%
subplot(3,1,3);
plot(data3(:,1),data3(:,2));
grid on;
xlabel(xlabel3);
ylabel(ylabel3);
title(t_string3);
ylim([-qmax,qmax]);



fig_num=fig_num+1;
set(hp, 'Position', [50 50 650 650]);




