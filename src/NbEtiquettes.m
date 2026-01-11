function nb = NbEtiquettes(image)

  % image --> Image etiquettée
  % nb --> Nombre d'étiquettes

  for k=1:255
	  f(k)=sum(sum(image == k));
  endfor
  nb=(find(f));
endfunction
