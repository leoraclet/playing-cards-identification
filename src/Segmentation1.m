function imgseg = Segmentation1(img)

  % img --> L'image originale
  % imgseg --> Image apres une passe de segmentation

  lig = size(img,1);
  col = size(img,2);
  imgseg = img;
  etiquette = 1;
  for r=2:lig-1
    for c=2:col-1
        if (imgseg(r,c) == 255)
          if (imgseg(r,c-1) > 0)
            if (imgseg(r-1,c) > 0)
              imgseg(r,c) = min(imgseg(r,c-1),imgseg(r-1,c));
            else
              imgseg(r,c) = imgseg(r,c-1);
            endif
          else
            if (imgseg(r-1,c) > 0)
              imgseg(r,c) = imgseg(r-1,c);
            else
              imgseg(r,c) = etiquette;
              etiquette = etiquette+1;
            endif
          endif
        endif
    endfor
  endfor
endfunction
