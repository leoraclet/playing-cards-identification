function output = Dilatation(input, taille)

  % img --> L'image originale
  % taille --> Taille du carré morphologique
  % output --> L'image dilatée

  pas = int16((taille-1)/2);
  milieu = 1+((taille*taille)-1)/2;
  centre = pas + 1;
  lig = size(input,1);
  col = size(input,2);
  output = input;
  for r=centre:lig-pas
    for c=centre:col-pas
        output(r,c) = max(max(input(r-pas:r+pas,c-pas:c+pas)));
    endfor
  endfor
endfunction
