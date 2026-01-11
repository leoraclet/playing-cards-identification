function object_position = Barycentres(img_seg)

  % img_seg --> Image segmentée
  % object_position --> Position des objets

  etiquettes = NbEtiquettes(img_seg);
  object_position=zeros(length(etiquettes),2);
  for m=1:length(etiquettes)
	  sumi=0;
	  sumj=0;
	  effectif=0;
    for i=2:size(img_seg,1)
        for j=2:size(img_seg,2)
            if (img_seg(i,j) == etiquettes(m))
                sumi=sumi+i;sumj=sumj+j;
                effectif=effectif+1;
            endif
        endfor
    endfor
    object_position(m,:)=[sumi/effectif,sumj/effectif];
  endfor
endfunction
