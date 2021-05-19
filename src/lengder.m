function svar=lengder(punkt,elem,nelem)
svar=zeros(nelem,1);

% Beregner elementlengder
for i=1:nelem
   dx = punkt(elem(i,1),1)-punkt(elem(i,2),1);
   dy = punkt(elem(i,1),2)-punkt(elem(i,2),2);
   svar(i) = sqrt(dx*dx + dy*dy);
end


end
