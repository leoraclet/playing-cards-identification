function imgseg = Etiquettage(img)

  % img --> L'image originale
  % imgfil --> Image apres étiquettage

  lig = size(img,1);
  col = size(img,2);
  imgseg = img;
  maxi = max(img(:));
  tab = zeros(maxi,1);
  numetiq = 1;
  for r=1:lig
    for c=1:col
        if (img(r,c) > 0)
          if (tab(img(r,c)) == 0)
            tab(img(r,c)) = numetiq;
            numetiq = numetiq+1;
          endif
          imgseg(r,c) =  tab(img(r,c));
          endif
    endfor
  endfor
endfunction
