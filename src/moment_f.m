function momenter = moment_f(nelem, nlast, last, elementlengder, endemoment)
%Regner ut moment ved midten av bjelke med fordelt last
% og der kraften virker ved punktlast
momenter = zeros(nelem,1);
for i= 1:nlast;
    element = last(i,2); %henter elementnummer
    p1 = last(i,4); %last ved ende 1 ved fordelt last, verdi for punktlast
    p2 = last(i,5); %last ved ende 2 
    L = elementlengder(element);
    a = last(i,3) * L; %avstand fra ende 1 for punktlast
    b = L-a; %avstand fra ende 2 for punktlast
    
    
    if last(i,1) == 1 % Bidrag fra punktlast
        % Bidrag fra endemomentene
        if abs(endemoment(element,2)) >= abs(endemoment(element,1))
            M2 = endemoment(element,1) - (endemoment(element,1) + endemoment(element,2)) * last(i,3);
        else
            M2 = -endemoment(E,2) + (endemoment(E,1) + endemoment(E,2)) * (1-Last(i,3));
        end % if
        % Bidrag fra punktlasten
        M1 = (p1 * a * b) / L;
        momenter(element,1) = - M1 + M2 + momenter(element,1) ;
        
        
    elseif last(i,1) == 2 
        M1 = (p1*L^2)/8; %Bidrag jevnt fordelt last
        M2 = (endemoment(element,1) - endemoment(element,2)) / 2;%bidrag fra endemoment
       
        momenter(element,1) = - M1 + M2 + momenter(element,1);
    elseif last(i,1) == 3 % bidrag fra jevnt lin?rt fordelt last
      
            if (p1 > p2) % bidrag fra jevnt lin?rt fordelt last
                q1 = (p2*L^2)/8;
                q2 = (p1 - p2)*(L^2/16);
                M1 = q1 + q2;%bidrag fra endemoment
            elseif (p1 < p2)
                q1=(p1*L^2)/8;
                q2 = (p2 - p1)*(L^2/16);
                M1 = q1 + q2;%bidrag fra endemoment
            end
         M2 = (endemoment(element,1) - endemoment(element,2)) / 2;
          momenter(element,1) = - M1 + M2 + momenter(element,1) ;
    end

end