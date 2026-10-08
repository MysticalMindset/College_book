function[xapsdfine]=env_interp_best(nbreak,n_ref,xf,xapsd,f_ref)
%
    xffine(1)=xf(1);
	xapsdfine(1)=xapsd(1);
%
	for i=1:nbreak-1
		xslope(i)=log(xapsd(i+1)/xapsd(i))/log(xf(i+1)/xf(i));
    end
%
    for i=1:n_ref 
	
		xffine(i)=f_ref(i);

        for j=1:nbreak-1
		
			if( ( xffine(i) >= xf(j) ) &&  ( xffine(i) <= xf(j+1) )  )
					
				xapsdfine(i)=xapsd(j)*( ( xffine(i) / xf(j) )^xslope(j) );
				break;
            end
        end
    end