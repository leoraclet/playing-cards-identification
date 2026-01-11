function output = Seuil(input, fond)

  % input --> L'image d'entrée
  % fond --> Le fond est-il clair ?
  % output --> Image seuilée

  moy = mean(input(:));
  output = (uint8)(((input < moy*0.5) & fond) | ((input > moy*1.5) & !fond))*255;
endfunction
