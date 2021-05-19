clear all
close all

% -----Leser input-data-----
[npunkt,punkt,nelem,elem,nlast,last, nItverrsnitt, Itverrsnitt, nStverrsnitt, Stverrsnitt] = lesinput();

% -----Regner lengder til elementene-----
elementlengder=lengder(punkt,elem,nelem);

% ------2. arealmoment og max avstand fra arealsenter for alle elementene------
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

%----regner ut boyespenning----
mom= horzcat(endemoment,momenter) %setter sammen endemomenter og midtmomenter
spenning= BoyeSpenning(mom, Iy,z, nelem);

%----regner ut skjaerkrefter----
skjaerkrefter = skjaerkrefter( nelem, nlast, last, elementlengder, endemoment);

% -----Skriver ut hva momentene ble for de forskjellige elementene-------
disp('Elementvis endemoment:')
endemoment



