%
%  subplots_two_linlin_two_titles.m  ver 1.1  by Tom Irvine
%

function[fig_num]=subplots_two_linlin_two_titles(fig_num,xlabel2,ylabel1,ylabel2,data1,data2,t_string1,t_string2)


try
    close fig_num;
end
try
    close fig_num hidden;
end

figure(fig_num);


subplot(2,1,1);
plot(data1(:,1),data1(:,2));
ylabel(ylabel1);
title(t_string1);
qqq=get(gca,'ylim');
qmax=max(abs(qqq));
ylim([-qmax,qmax]);
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','lin',...
                     'YScale','lin','XminorTick','off','YminorTick','off');
%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');

%
subplot(2,1,2);
plot(data2(:,1),data2(:,2));
xlabel(xlabel2);
ylabel(ylabel2);
title(t_string2);
qqq=get(gca,'ylim');
qmax=max(abs(qqq));
ylim([-qmax,qmax]);
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','lin',...
                     'YScale','lin','XminorTick','off','YminorTick','off');
%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');

fig_num=fig_num+1;