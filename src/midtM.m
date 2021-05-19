function svar = midtM(nElem, nLast, Last, elementlengder, endemoment)
% For beregning av endemoment

svar = zeros(nElem,1);  % Lager tom svarmatrise

for i = 1:nLast
    E = Last(i,3);          % Elementnummer
    L = elementlengder(E);  % Lengden til hvert element
    P = Last(i,2);          % Verdien / maksverdien til lastens kraft

    if Last(i,1) == 1       % Gjelder punktlaster
        a = Last(i,4) * L;  % Avstand fra lokalt knutepunkt 1 til lasten
        b = L - a;          % Avstand fra lokalt knutepunkt 2 til lasten
    
        % Bidrag fra endemomentene
        if abs(endemoment(E,2)) >= abs(endemoment(E,1))
            M2 = endemoment(E,1) - (endemoment(E,1) + endemoment(E,2)) * Last(i,4);
        else
            M2 = -endemoment(E,2) + (endemoment(E,1) + endemoment(E,2)) * (1-Last(i,4));
        end % if
        
        % Bidrag fra punktlasten
        M1 = (P * a * b) / L;
        svar(E,1) = - M1 + M2 + svar(E,1);
           
    elseif Last(i,1) == 2 % Jevnt fordelt last
        % Bidrag fra jevnt fordelt last
        M1 = (-P * (L^2)) / 8;
        % Bidrag fra endemomentene
        M2 = (endemoment(E,1) - endemoment(E,2)) / 2;
        svar(E,1) = M1 + M2 + svar(E,1);
        
    elseif Last(i,1) == 3 % Gjelder lineaert fordelt last        
        % Samme midtmoment uansett hvilken ende maks moment er i
        % Bidrag fra linaert fordelt last
        M1 = (-P * (L^2)) / 16;
        % Bidrag fra endemomentene er lagt til i jevnt fordelt last
        svar(E,1) = M1 + svar(E,1);
    end % if
end % for
end % function