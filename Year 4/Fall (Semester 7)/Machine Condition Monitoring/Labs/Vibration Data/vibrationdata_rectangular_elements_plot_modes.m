%
%  vibrationdata_rectangular_elements_plot_modes.m  ver 1.2  May 26, 2015
%
function[fig_num]=...
vibrationdata_rectangular_elements_plot_modes(nodex,nodey,fig_num,ModeShapes,fn,number_nodes,k,iu)
%
ips=1;
%

%
if(ips==1)
    clear aaa;
    clear abc;
    abc=zeros(number_nodes,2);
    abc=[ nodex  nodey ];
    aaa=max(abc);
    xmin=-aaa;
    ymin=-aaa;
    xmax=aaa;
    ymax=aaa;
end  


if(ips==1)
%    
  
    clear zzr;
    zzr=zeros(number_nodes,1);
%%    mode_num=input(' Enter mode number ');
    mode_num=k;
%
    h=figure(fig_num);
    fig_num=fig_num+1;
%
    maxr=0;

    maxnode=zeros(1,1);
    
    kk=1;
    
    for i=1:number_nodes
        ndof=3*i-2;
        zzr(i)=ModeShapes(ndof,mode_num);
        
        if(abs(zzr(i))>maxr)
            maxr=abs(zzr(i));
            mnode=i;
        end
    end
    
    kk=kk+1;
    
    maxnode(1)=mnode;
    
    for i=1:number_nodes
        ndof=3*i-2;
        zzr(i)=ModeShapes(ndof,mode_num);
        
        yy=(maxr-abs(zzr(i)))/maxr;
        
        yy=abs(yy);
        
        if(i~=mnode && yy<0.004)
            maxnode(kk)=i;
            kk=kk+1;
        end
    end    
    
    maxnode=sort(maxnode);
    
%
    out1=sprintf('\n Mode %d   fn=%8.4g Hz ',mode_num,fn(mode_num));
    disp(out1);
    nn=length(maxnode);
    if(nn==1)
        out2=sprintf(' Maximum response at node %d',maxnode(1));
        disp(out2);
    else
        disp(' Maximum response at nodes: ');
        for i=1:nn
            out3=sprintf('          %d',maxnode(i));
            disp(out3);
        end
    end
    out4=sprintf(' Corresponding eigenvector term = %8.4g',maxr);
    disp(out4);
    
    
%    
    if(iu==1)
        tri = delaunay ( nodex, nodey );
        trisurf ( tri, nodex, nodey, zzr );
        xlabel('X (in)');
        ylabel('Y (in)');       
    else
        tri = delaunay ( 1000*nodex, 1000*nodey );
        trisurf ( tri, 1000*nodex, 1000*nodey, zzr );
        xlabel('X (mm)');
        ylabel('Y (mm)');         
    end
    
%
    out1=sprintf(' Mode %d   fn=%8.4g Hz ',mode_num,fn(mode_num));
    title(out1);
    grid on;
%    
    a=-37.5+90;
    view([a 30])     
    pname=sprintf('ModeShape_%d_view_1.emf',mode_num);
    out1=sprintf('plot file:   %s',pname);
    disp(out1);
    set(gca,'Fontsize',12);
    print(h,pname,'-dmeta','-r300');
%
%%    view([-37.5 30])     
%%    pname=sprintf('ModeShape_%d_view_2.emf \n',mode_num);
%%    out1=sprintf('plot file:   %s',pname);
%%    disp(out1);
%%    set(gca,'Fontsize',12);
%%    print(h,pname,'-dmeta','-r300');
%
end