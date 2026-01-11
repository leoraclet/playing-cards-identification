function imgseg = Segmentation2(img)

  % img --> L'image originale
  % imgseg --> Image apres 2eme passe de segmentation

  lig = size(img,1);
  col = size(img,2);
  imgseg = img;
  for r=lig-1:-1:2
    for c=col-1:-1:2
        if (imgseg(r,c) > 0)
          if (imgseg(r,c+1) > 0)
            if (imgseg(r+1,c) > 0)
              imgseg(r,c) = min(imgseg(r,c),min(imgseg(r,c+1),imgseg(r+1,c)));
            else
              imgseg(r,c) = min(imgseg(r,c),imgseg(r,c+1));
            endif
          else
            if (imgseg(r+1,c) > 0)
              imgseg(r,c) = min(imgseg(r,c),imgseg(r+1,c));
            endif
          endif
        endif
    endfor
  endfor
endfunction
