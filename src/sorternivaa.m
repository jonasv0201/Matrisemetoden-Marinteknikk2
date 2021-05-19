function [vnivaa, hnivaa] = sorternivaa(npunkt, punkt, elem, nelem)
%sorterer elementene etter hvilket nivaa de ligger p?, og returnerer to
%matriser, en for vertikale nivaaer og en for horisontale, der
%elementnummer er sortert. Alle elementer p? samme nivaa ligger i samme
%kolonne
x = []; %matrise for x-koordinat for hvert vertikale nivaa
y = []; %matrise for y-koordinat for hvert horisontale nivaa
for i = 1:npunkt
    %legger inn x-koordinater for hvert vertikale nivaa i x
    dx = punkt(i,1);
    if ~ismember(dx, x) 
        x = [x, dx];
    end %i
    %legger inn y-koordinater for hvert horisontale nivaa i y
    dy = punkt(i,2);
    if ~ismember(dy, y)
        y = [y, dy];
    end %if
    
end %for
y= sort(y); %sorterer vertikale nivaaer slik at nivaa lengst til venstre er f?rst i matrise
x= sort(x); %sorterer horisontale nivaaer slik at nederste nivaa er f?rst i matrise
vnivaa = zeros(length(y)-1,length(x)); %svarmatrise for vertikale nivaa
hnivaa = zeros(length(x)-1, length(y)); %svarmatrise for horisontale nivaa

tellerh=1;
tellerv=1;
for i = 1:nelem
    
    if elem(i,4) ==2; %sjekker om element er vertikalt
        koordx= punkt(elem(i,1),1); %x-koordinatet til lokal ende 1 for bjelke i
        for j = 1:length(x) %itererer over nivaa
            if koordx == x(j) %sjekker om elemntet ligger i nivaaet
                for k = 1:length(x)
                    %legger inn elementet i f?rste ledige rad i riktig
                    %kollonne
                    if vnivaa( k,j) == 0 
                        vnivaa( k,j) = i;
                        tellerv=1;
                        break
                    end %if
                end %for
                tellerv = tellerv+1;
                break
            end %if
        end %for
        
    else
        koordy= punkt(elem(i,1),2); %y-koordinatet til lokal ende 1 for bjelke i
        for j = 1:length(y) %itererer over nivaa
            if koordy == y(j) %sjekker om elemntet ligger i nivaaet
                for k = 1:length(y)
                    %legger inn elementet i f?rste ledige rad i riktig
                    %kollonne
                    if hnivaa( k,j) == 0
                        hnivaa( k,j) = i;
                        break
                    end %if
                end %for
                
                tellerh = tellerh+1;
                break
            end %if
        end %for
    end %if
    
end
end