function K = systemstivhetsmatrisen(nelem,elem,elementlengder,npunkt,elementstivhetsmatriser)
% Setter opp systemstivhetsmatrisen
MNPC = zeros(2,nelem); %Matrix of Nodal Points Correspondance

for i = 1:nelem
    element=elem(i,:); 
    r1 = element(1); %knutepunkt i ende 1
    r2 = element(2); %knutepunkt i ende 2
    MNPC(1,i)=r1; %setter inn element i MNPC
    MNPC(2,i)=r2; %setter inn element i MNPC
end %for
K=zeros(npunkt, npunkt); %setter opp tom matrise som systemstivhetsmatrisen
for i = 1:nelem
    s = elementstivhetsmatriser(i,:); %henter ut elementstivhetsmatrise for bjelke i.
    koord=MNPC(:,i)';
    %Finner koordinater i MNPC, setter verdier inn i K
    K(koord(1),koord(1)) = K(koord(1),koord(1)) + s(1); 
    K(koord(1),koord(2)) = K(koord(1),koord(2)) + s(2);
    K(koord(2),koord(1)) = K(koord(2),koord(1)) + s(3);
    K(koord(2),koord(2)) = K(koord(2),koord(2)) + s(4);
end %for
end %end function
