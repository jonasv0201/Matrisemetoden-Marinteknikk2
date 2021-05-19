function [Kn,Bn] = bc(npunkt,punkt,K,b)
%K stivhetsmatrisen
%b = lastvektor
randbet = punkt(:,3)';
%randbetingelser. 1 = fast innspent, 0 = fritt opplagt
for i = 1:npunkt
    if randbet(i) == 1 %sjekker om knutepunkt er fast innspent
        b(i)=0; %setter verdi i lastvektor tilh?rende knutepunkt i til null
        K(:,i) = 0; %setter verdier for rad i, i K til null
        K(i,:) = 0; %setter verdier for kollonne i, i K til null
        K(i,i)=1; %element (i,i) i K til 1
    end %if
end %for

Kn=K;
Bn=b';
end %function