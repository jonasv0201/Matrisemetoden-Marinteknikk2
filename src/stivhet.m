function [Iy, z] = stivhet(Itverrsnitt, Stverrsnitt, nelem, elem)
%regner ut 2. arealmoment for alle bjelker, regner ut max avstand fra 
%arealsenter.
%lagrer data for hvert tverrsnitt i vektorer, data for tverrsnitt til
%element i i rad i
Iy = zeros(nelem,1); %vektor til 2. arealmoment for alle element
z = zeros(nelem,1); %vektor for max avstand fra arealsenter for alle element
for i=1:nelem
    if elem(i,4) == 1 %sjekker om det er et I tverrsnitt
        t_snitt = Itverrsnitt(elem(i,5),:); %finner riktig tverrsnitt for bjelken
        %henter ut tverrsnittsdata for elementet
        [flens_l, tFlens_t , bFlens_t, steg_t, steg_l]= deal(t_snitt(1),t_snitt(2),t_snitt(3),t_snitt(4),t_snitt(5)); 
        A_tFlens = tFlens_t*flens_l; %areal av toppflens
        A_bFlens = bFlens_t*flens_l; %areal av bunnflens
        Asteg = steg_t*steg_l; %areal av steg
        s_bFlens = bFlens_t/2; %avstand fra senter av bunnflens til "bunn"
        s_tFlens = bFlens_t+steg_l+tFlens_t/2; %avstand fra senter av toppflens til bunn av tverrsnitt
        s_steg = bFlens_t+steg_l/2; %avstand fra senter av steg til bunn av tverrsnitt
        senter= (A_tFlens*s_tFlens+A_bFlens*s_bFlens+Asteg*s_steg)/(A_bFlens+A_tFlens+Asteg); %tyngdepunkt/arealsenter til tverrsnitt
        %regner ut 2. arealmoment og legger inn i Iy
        Iy(i)= flens_l*tFlens_t^3/12+flens_l*bFlens_t^3/12+steg_t*steg_l^3/12 + A_bFlens*(senter-s_bFlens)^2+A_tFlens*(senter-s_tFlens)^2+Asteg*(s_steg-senter)^2; 
        z(i) = tFlens_t + steg_l/2; %regner ut max avstand fra arealsenter og legger inn i z
    elseif elem(i,4) == 2 %sjekker om det er et ror/sirkulaert tverrsnitt
        t_snitt = Stverrsnitt(elem(i,5),:); %finner riktig tverrsnitt
        R = t_snitt(1)/2; %Henter ut yttre diameter
        r = t_snitt(2)/2; %henter ut indre diameter
        Iy(i)=(pi/4)*(R^4-r^4); %regner ut 2. arealmoment og legger inn i Iy
        z(i)= R; %regner ut max avstand fra arealsenter
    else 
        error('et av tverrsnittene som er oppgitt er ikke et r?r eller en I-bjelke');
    end %if
end %for
end %function
%kommentar til rapport: kunne gjort dette mer effektivt ved ? regne ut
%dette for hvert tverrsnitt og ikke hvert element