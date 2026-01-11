% -------------------------------------------------------------------- %
%
% Tire        : Taitement d'images de cartes à jouer
% Date        : 31 / 03 / 2023
% Fonctions   : Barycentres, Dilatation, Erosion, Etiquettage, Masque, NbEtiquettes, segmentation1, segmentation2, segmentation3
% Description : Le but de notre programme est de pouvoir identifier la valeur de chaque carte
% Limites     : On ne traite pas les cartes qui sont des figures ( Roi, Dame, Valet )
% Commentaire : L'affiche de l'image final ne ce fait qu'à la fin du traitement.
%               Le temps d'éxecution est plutôt long ( ~ 1 min ).
%               Le programme fonctionne pour les 4 images fournies.
%
% -------------------------------------------------------------------- %

% -------------------------------------------------------------------- %
% PRE-TRAITEMENT DE L'IMAGE
% -------------------------------------------------------------------- %

% Vide la mémoire et charge le paquet 'image' de Octave
clear all
close all
pkg load image

% Chargement de notre image de travail
img = imread('samples/quatre_cartes.jpg');

% On redimenssionne notre image afin qu'elle soit d'une taille inférieur ou égale à 400x400 pixels
% Comme les images prises par le téléphone sont en 4003x3003 pixels,
% nous devons alors réduire la taille de chaque image d'un facteur de 10.

img_rsz = imresize(img, [size(img,1)/1, size(img,2)/1]);
figure; imshow(img_rsz); % FIXME
print('original.png', '-dpng');

% On récupère la taille de notre image
taillex = size(img_rsz,1);
tailley = size(img_rsz,2);

disp(taillex);
disp(tailley);

% On transforme notre image RGB en image NVG
img_nvg = rgb2gray(img_rsz);

figure; imshow(img_nvg); % FIXME
print('card-grey.png', '-dpng');

% Opération de seuillage de notre image
img_seuil = Seuil(img_nvg, 1);

figure; imshow(img_seuil); % FIXME
print('card-black-white.png', '-dpng');

% -------------------------------------------------------------------- %
% TRAITEMENT DU MASQUE
% -------------------------------------------------------------------- %

% Dilatation et erosion de notre masque
msq = img_seuil;
for n=1:6
  msq = Dilatation(msq, 3);
endfor
for n=1:6
  msq = Erosion(msq, 3);
endfor

figure; imshow(msq); % FIXME
print('card-dilated.png', '-dpng');

% Segmentation des cartes présentes sur l'image
msq_seg1 = Segmentation1(msq);
msq_seg2 = Segmentation2(msq_seg1);
msq_seg3 = Segmentation3(msq_seg2);

% On renumérote les étiquettes des cartes
msq_etq = Etiquettage(msq_seg3);

% figure; imshow(msq_etq); % FIXME
% figure; imshow(msq_seg1); colormap('jet');% FIXME
% figure; imshow(msq_seg2); colormap('jet');% FIXME
% msq_seg3(msq_seg3 ~= 0) = msq_seg3(msq_seg3 ~= 0) + 10;
% figure; imagesc(msq_seg3, [min(msq_seg3(:)) + 1, max(msq_seg3(:))]); colormap('jet'); axis image; axis off;% FIXME
% print('card-seg.png', '-dpng');


% -------------------------------------------------------------------- %
% TRAITEMENT DE L'IMAGE
% -------------------------------------------------------------------- %

% On utilise l'image seuil de la carte pour réaliser une opération de masquage sur l'image origniale.
% Le but est de récupérer uniquement les parties de l'image original où les carte sont présentent.
img_msq = Masque(255-img_seuil, msq);

% Opération d'érosion n°1
img_er = Erosion(img_msq, 5);

% Opération de dilatation n°1
img_di = Dilatation(img_er, 5);

% Opération d'érosion n°2
img_er = Erosion(img_di, 7);

% Opération de dilatation n°2
img_di = Dilatation(img_er, 9);

figure; imshow(img_di); % FIXME
print('part-dilated.png', '-dpng');

% Segmentation des motifs présents sur les cartes
img_seg1 = Segmentation1(img_di);
img_seg2 = Segmentation2(img_seg1);
img_seg3 = Segmentation3(img_seg2);

% img_seg3(img_seg3 ~= 0) = img_seg3(img_seg3 ~= 0) + 10;
% figure; imagesc(img_seg3); colormap('jet'); axis image; axis off;% FIXME
% print('parts-seg.png', '-dpng');

% Détermine le nombres d'étiquettes différentes pour la segmentation des cartes et des motifs
nb_motifs = length(NbEtiquettes(img_seg3));
nb_cartes = length(NbEtiquettes(msq_etq));

% Détermine la position des barycentres de chaque motif et de chaque carte.
pos_motifs = (uint16)(Barycentres(img_seg3));
pos_cartes = (uint16)(Barycentres(msq_etq));

% Détermine le nombre de motifs présent sur chaque carte.
%
% Pour ce faire, pour chaque motif, on prend la position de son barycentre sur l'image,
% et on regarde dans quelle zone étiquetté de l'image des carte segmenté on se situe,
% ce qui nous permet d'associer à chaque étiquette, donc chaque carte, un nombre de motifs.

cartes = zeros(nb_cartes,1);
for j=1:nb_motifs
  cartes(msq_etq(pos_motifs(j,1),pos_motifs(j,2))) += 1;
endfor

% On affiche l'image originale
figure; imshow(img);

% On affiche le nombre de motifs de chaque à la position des barycentres de celles-ci
for m=1:length(pos_cartes(:,1))
	coord=(uint16)(pos_cartes(m,:));
	text(coord(2),coord(1), num2str(cartes(m)), "fontsize", 25, "color", "white", "fontweight", "bold")
end

disp("Script completed successfully !");
print('result.png', '-dpng');
