function res=BoyeSpenning(mom,Iy,z, nelem)
%regner ut maksimal boyespenning ved alle steder der moment er oppgitt p?
%et element
rader = length(mom(1,:)); %antall momenter per bjelke
res= zeros(nelem,rader); %svarmatrise

for i=1:nelem 
    for j= 1: rader 
    avstand = z(i); %avstanden fra arealsenter
    I = Iy(i); %andre arealmoment
    res(i,j)= mom(i,j)*avstand/I; %regner ut spenning og legger inn i svarmatrise
    end %for
end %for

end %function