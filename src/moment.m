function fim=moment(nelem,nlast,last,elementlengder)
%regner ut fastinnspenningsmoment for bjelkene, returnerer som en matrise
%der moment i lokal ende 1 ligger i kollonne 1 og moment i lokal ende 2 ligger i
%kollonne 2. Hver rad har data for et element
fim= zeros(nelem,2); %lager matrise til a lagre fastinnspenningsmoment i hver ende av element
for i= 1:nlast
    l= elementlengder(last(i,2)); %lengde av element
    switch last(i, 1) %henter ut type last
        case 1 %punklast
            a= l*last(i,3); % avstand fra lokal ende 1
            b = l-a; % avstand fra lokal ende 2
            p1=last(i,4); %storrelse p? kraft
            % formel fra side 281 i kompendiet del 1
            fim(last(i,2),1) = -(p1*a*(b^2))/l^2; %regner ut og setter inn fastinnspenningsmoment 1 i fim
            fim(last(i,2),2) = (p1*(a^2)*b)/l^2; %regner ut og setter inn fastinnspenningsmoment 2 i fim
        case 2 %likt fordelt last
            p1=last(i,4); %storrelse p? fordelt last
            % formel fra side 281 i kompendiet del 1
            fim(last(i,2),1)= -(p1*l^2)/12; %regner ut og setter inn fastinnspenningsmoment 1 i fim
            fim(last(i,2),2) = (p1*l^2)/12; %regner ut og setter inn fastinnspenningsmoment 2 i fim
            
        case 3 %ulikt fordelt last, line?r fordeling, fordelt last kan kun v?re over hele elementlengden, ikke kun deler av den
            p1=last(i,4); %verdi til fordelt last ved lokal ende 1
            p2= last(i,5); %verdi til fordelt last ved lokal ende 2
            
            % deler opp fordelt last i "firkantlast" og "trekantlast og
            % legger sammen bidragene
            if (p1> p2) %sjekker om fordelt last er st?rst ved lokal ende 1
                % formeler fra side 281 i kompendiet del 1
                q1 = -p2*l^2/12; %moment fra firkantlast i ende 1
                    q2 = -( p1-p2)*l^2 /20; %moment fra trekantlast i ende 1
                q3 = p2*l^2/12; %moment fra firkantlast i ende 2
                q4 =  ( p1-p2)*l^2 /30; %moment fra trekantlast i ende 2
                fim(last(i,2),1) = q1 + q2; %regner ut og setter inn fastinnspenningsmoment 1 i fim
                fim(last(i,2),2) = q3 + q4; %regner ut og setter inn fastinnspenningsmoment 2 i fim
            else %hvis fordelt last ikke er st?rst ved ende 1 er den st?rst ved ende 2
                % formel fra side 281 i kompendiet del 1
                q1 =-(p1*l^2)/12 ; %moment fra firkantlast i ende 1
                q2 = -(p2-p1)*l^2/30; %moment fra trekantlast i ende 1
                q3 = (p1*l^2)/12; %moment fra firkantlast i ende 2
                q4 = ((p2-p1)*l^2)/20; %moment fra trekantlast i ende 2
                
                fim(last(i,2),1) = q1 + q2; %regner ut og setter inn fastinnspenningsmoment 1 i fim
                fim(last(i,2),2) = q3 + q4; %regner ut og setter inn fastinnspenningsmoment 2 i fim
            end %if
    end %switch
end %for
end %function