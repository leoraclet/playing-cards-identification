function output = Masque(input, masque)

  % input --> L'image d'entree
  % masque --> Le masque de passage
  % output --> L'image apres le masque

  output = (uint8)(zeros(size(input,1), size(input,2)));
  for r=1:size(input,1)
    for c=1:size(input,2)
      if (masque(r,c))
        output(r,c) = input(r,c);
      endif
    endfor
  endfor
endfunction
