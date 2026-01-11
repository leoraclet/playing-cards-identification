function output = Erosion(input, taille)

  % input --> L'image d'entrée
  % taille --> Taille du carré morphologique
  % output --> L'image érodée

  pas = uint16((taille-1)/2);
  milieu = 1+((taille*taille)-1)/2;
  centre = pas + 1;
  lig = size(input,1);
  col = size(input,2);
  output = input;
  for r=centre:lig-pas
    for c=centre:col-pas
        output(r,c) = min(min(input(r-pas:r+pas,c-pas:c+pas)));
    endfor
  endfor
endfunction
