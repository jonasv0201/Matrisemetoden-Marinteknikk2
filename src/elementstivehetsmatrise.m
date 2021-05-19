function elementstivhetsmatriser = elementstivehetsmatrise(nelem,elem,elementlengder, Iy)
elementstivhetsmatriser = zeros(nelem,4); %svarmatrise, like mange rader 
%som element, data til et element i en rad
m = [1 1/2 1/2 1]; % standard stivhetsmatrise
 % nelem: hvor mange element det er
 % Elementnummer tilsvarer radnummer i "Elem-variabel"
 % element - knute, knute, E-modul, profil, st?rrelse
 % elementlengder fra egen funksjon
 
 for i = 1 : nelem
     element = elem(i,:); %element
     E = element(3); %E-modul til element
     L = elementlengder(i); %lengde av element
     I = Iy(i); %2. arealmoment for element
     
 k = ((4*E*I)/L) .* m; %regner ut elementstivhetsdata for element
 elementstivhetsmatriser(i,:) = k; %lagrer dataene i en rad
 end %for
 
end %function