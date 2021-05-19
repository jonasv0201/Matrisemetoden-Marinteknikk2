function [momenter, endemoment, Iy, z] = rammeanalyse2(npunkt,punkt,nelem,elem,nlast,last, nItverrsnitt, Itverrsnitt, nStverrsnitt, Stverrsnitt)

% -----Regner lengder til elementene-----
elementlengder=lengder(punkt,elem,nelem);

% ------2. arealmoment og max avstand fra arealsenter for elementene------
[Iy, z] = stivhet(Itverrsnitt, Stverrsnitt, nelem, elem);

% ------Fastinnspenningsmomentene------
fim=moment(nelem,nlast,last,elementlengder);

% ------Setter opp lastvektor-------
b=lastvektor(fim,npunkt,nelem,elem,last,nlast);

% ------Setter opp systemstivhetsmatrisen-------
elementstivhetsmatriser = elementstivehetsmatrise(nelem,elem,elementlengder, Iy);
K = systemstivhetsmatrisen(nelem,elem,elementlengder,npunkt,elementstivhetsmatriser);


% ------Innfoerer randbetingelser-------
[Kn,Bn] = bc(npunkt,punkt,K,b);


% -----L?ser ligningssytemet -------
rot = Kn\Bn;


% -----Finner endemoment for hvert element -------
endemoment=endeM(nelem,elem,elementlengder,rot,fim,Iy);

% -----Finner  for hvert element,moment p? midten av bjelke med fordelt last
% og der kraften virker ved punktlast -------
momenter = moment_f(nelem, nlast, last, elementlengder, endemoment);
%Regner ut moment p? midten av bjelke med fordelt last
% og der kraften virker ved punktlast

% ----Skriver ut hva rotasjonen ble i de forskjellige nodene-------
%disp('Rotasjonane i de ulike punkta:')
rot;


% -----Skriver ut hva momentene ble for de forskjellige elementene-------
%disp('Elementvis endemoment:')
%endemoment


end
