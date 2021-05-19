function endemoment=endeM(nelem,elem,elementlengder,rot,fim,Iy)
endemoment = zeros(nelem, 2); %setter opp svarmatrise
k = [4,2;2,4]; %lokal stivhetsmatrise

for i= 1:nelem %for hvert element
    E = elem(i,3); %elementets E-modul
    
    r = [rot(elem(i,1));rot(elem(i,2))]; %rotasjon i endepunktene
    m = [fim(i,1);fim(i,2)]; %fastinnspenningsmomenter
    kk = (E*Iy(i)/elementlengder(i)) * k; %4EI/L
    M = (kk * r) + m; 
    endemoment(i,1) = -M(1);
    endemoment(i,2) = -M(2);
end %for
end %function