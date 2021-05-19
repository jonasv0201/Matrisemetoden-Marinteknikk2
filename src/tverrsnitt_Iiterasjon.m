%dette scriptet iterer over alle elementene i rammen, finner der det er
%storst spenning og oker dimensjonene paa hele nivaaet/etasjen der spenningen
%finnes

%scriptet bruker en modifisert versjon av "rammeanalyse" kalt
%"rammeanalyse2" som gjor akkurat de samme beregningene, men tar inn
%data i funksjonskallet i stedet for a hente de fra "lesinput". Lesinput
%blir kjort av dette scriptet.

%------henter data-------
[npunkt,punkt,nelem,elem,nlast,last, nItverrsnitt, Itverrsnitt, nStverrsnitt, Stverrsnitt]=lesinput();
%antar kun en type rortverrsnitt og I-tverrsnitt som input fra fil

%------sorterer elementene etter vertikale og horisontal nivaa/etasje-----
%lagrer hvilke elementer som horer til i hvilke nivaaer i matrisene
%vnivaa(vertikale nivaaer) og hnivaa(horisontale nivaaer), alle elementer
%paa samme nivaa ligger i samme kolonne. De plassene i matrisen der
[vnivaa, hnivaa] = sorternivaa(npunkt, punkt, elem, nelem);

%setter flytespenning 
flytespenning = 320*10^6;

%her lages et eget tverrsnitt til hvert niv?, slik at tverrsittene til
%niv?ene kan endres samtidig og uanhengig av andre ni?er

tverrsnitt_startverdi_forhold = 0.3; %forholdstall skalerer tverrsnitt ned for a vaere sikker paa at max spenning er over 70%flytespenning

Stverrsnitt_temp= Stverrsnitt.*tverrsnitt_startverdi_forhold; %tar vare paa dataen til det ene oppgitte tverrsnittet, og skalerer det utgangspunktlige tverrsnittet
Stverrsnitt = zeros(length(length(vnivaa(:,1))),length(Stverrsnitt(1,:))); %gir tverrsnittsmatrisen like mange rader som nivaaer og samme antall kollonner som foer, for ? preallokere til flere forskjellige tverrsnitt
for i= 1:length(vnivaa(1,:)) %g?r gjennom hver rad
    %legger inn et tverrsnitt for hvert vertikale nivaa
    for j = 1:length(vnivaa(:,1)) %g?r gjennom hver kolonne
        if vnivaa(j,i) ~= 0 
            elem(vnivaa(j,i), 5) = i;
        end
    end
    Stverrsnitt(i, :) =  Stverrsnitt_temp;
end
%setter en type tverrsnitt per horisontale nivaa
Itverrsnitt_temp = Itverrsnitt.*tverrsnitt_startverdi_forhold; %tar vare p? dataen til det ene oppgitte tverrsnittet
Itverrsnitt = zeros(length(length(hnivaa(:,1))),length(Itverrsnitt(1,:))); %gir tverrsnittsmatrisen like mange rader som nivaaer og samme antall kollonner som for
for i= 1:length(hnivaa(1,:))
    %legger inn et tverrsnitt for hvert vertikale nivaa
    for j = 1:length(hnivaa(:,1))
        if hnivaa(j,i) ~= 0
            elem(hnivaa(j,i), 5) = i; 
        end
    end
    Itverrsnitt(i, :) = Itverrsnitt_temp; 
end
[momenter, endemoment, Iy, z] = rammeanalyse2(npunkt,punkt,nelem,elem,nlast,last, nItverrsnitt, Itverrsnitt, nStverrsnitt, Stverrsnitt);
maxSpenning = inf;

%regner ut max spenning for hele rammen, dersom spenningen er storre en 70%
%av flytespenning okes tverrsnittet til nivaaet spenningen fant sted.
%Itererer helt til ingen spenninger er storre enn 70% av flytespenning
while maxSpenning > flytespenning*0.7
    [momenter, endemoment, Iy, z] = rammeanalyse2(npunkt,punkt,nelem,elem,nlast,last, nItverrsnitt, Itverrsnitt, nStverrsnitt, Stverrsnitt);
    moment = horzcat(endemoment, momenter); %samler alle momenter p? samme bjelke i en vektor
    Spenning_bjelker = BoyeSpenning(moment, Iy,z, nelem); %finner spenning p? hver bjelke, ved hvert moment
    maxSpenning_bjelke = max(abs(Spenning_bjelker'))'; %finner max spenning p? hver bjelke
    [maxSpenning, index] = max(maxSpenning_bjelke); %finner max spenning (tallverdi) p? rammen, og elementet det tilh?rer
    if maxSpenning > flytespenning*0.7
        if elem(index, 4)== 1 %sjekker om bjelken er horisontal
            Itverrsnitt(elem(index,5),:) = Itverrsnitt(elem(index,5),:).*1.1;
        else     %hvis ikke bjelken er horisontal m? den v?re vertikal
            Stverrsnitt(elem(index,5),:) = Stverrsnitt(elem(index,5),:).*1.1;
        end
    end
end
Itverrsnitt
Stverrsnitt
moment(:,2) = -moment(:,2);
moment
Spenning_bjelker
maxSpenning_bjelke
maxSpenning
