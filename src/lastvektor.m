function R = lastvektor(fim,npunkt,nelem,elem,last,nlast)
%lastvektor = fastinnspenningsmomenter + laster i felt

R = zeros(npunkt,1); %preallokerer svarvektor

%Legger til knutepunktsmomenter
for i = 1:nlast
    if last(i,1) == 4
        R(last(i,2)) = last(i,4);
    end %if
end %for

for i=1:nelem
% Sum av fastinnspenningsmomenter/krefter for alle tilst?tende elementer
% med motsatt fortegn

    R(elem(i,1),1) = R(elem(i,1),1) - fim(i,1); 
    R(elem(i,2),1) = R(elem(i,2),1) - fim(i,2);
    
end %for
R = R';
end %function
