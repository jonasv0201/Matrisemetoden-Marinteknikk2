function skjaerkrefter = skjaerkrefter( nelem, nlast, last, elementlengder, endemoment)
% Positiv retning definert med klokken
skjaerkrefter = zeros(nelem,2);
P = last(:,4); % Storrelse kraft

%Skjaerkraft endemomenter
for i = 1:nelem
    q = (endemoment(i,1) + endemoment(i,2)) / elementlengder(i); 
    skjaerkrefter(i,1) = q;
    skjaerkrefter(i,2) = q;
end

%Skj?rkraft last
for i = 1:nlast
    element = last(i,2); %Hvilket element
    if last(i,1) == 1 % Bidrag fra punktlast
        skjaerkrefter(element,1) = skjaerkrefter(element,1) + (P(i) * (1-last(i,3)));
        skjaerkrefter(element,2) = skjaerkrefter(element,2) - (P(i) * last(i,3));
    elseif last(i,1) == 2 % Bidra jevnt fordelt last
        skjaerkrefter(element,1) = skjaerkrefter(element,1) + (P(i) * elementlengder(element)) / 2;
        skjaerkrefter(element,2) = skjaerkrefter(element,2) - (P(i) * elementlengder(element)) / 2;
     elseif last(i,1) == 3 %Bidrag lin?rt fordelt last
         % Ser hvilken ende den har stoerst verdi
        if last(i,4) > last(i,5) % Maks i lokalt knutepunkt 1
            Pj = last(i,5); % st?rrelse p? jevnt fordelt last
            Pt =  last(i,4) - last(i,5); % st?rrelse p? trekant-last
            skjaerkrefter(element,1) = skjaerkrefter(element,1) + ((Pt * elementlengder(element)) / 3) + (Pj * elementlengder(element))/2 ;
            skjaerkrefter(element,2) = skjaerkrefter(element,2) - ((Pt * elementlengder(element)) / 6) -(Pj * elementlengder(element))/2 ;          
        elseif last(i,4) < last(i,5) % Maks i lokalt knutepunkt 2
            Pj = last(i,4); % st?rrelse p? jevnt fordelt last
            Pt =  last(i,5) - last(i,4); % st?rrelse p? trekant-last
            skjaerkrefter(element,1) = skjaerkrefter(element,1) + ((Pt * elementlengder(element)) / 6) +(Pj * elementlengder(element))/2 ;
            skjaerkrefter(element,2) = skjaerkrefter(element,2) - ((Pt * elementlengder(element)) / 3) -(Pj * elementlengder(element))/2 ;
        end
    end
end
end
    
    
    
    