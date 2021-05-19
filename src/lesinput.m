function [npunkt,punkt,nelem,elem,nlast,last, nItverrsnitt, Itverrsnitt, nStverrsnitt, Stverrsnitt]=lesinput()


%i = heltall (integer)       %f : desimaltall (flyt-tall)


%?pner inputfila
filid = fopen('inputC.txt','r');


%Leser hvor mange punkt det er
npunkt = fscanf(filid,'%i',[1 1]);


% LESER INN XY-KOORDINATER TIL KNUTEPUNKTENE
% Nodenummer tilsvarer radnummer i "Node-variabel"
% x-koordinat lagres i f?rste kolonne, y-koordinat i 2.kolonne
% Grensebetingelse lagres i kolonne 3, fast innspent=1 og fri rotasjon=0
punkt = fscanf(filid,'%f %f %i',[3 npunkt])'; %x , y , grensebetingelse


%Leser hvor mange element det er
nelem = fscanf(filid,'%i',[1 1]); %antall element


%Leser konnektivitet: sammenheng elementender og knutepunktnummer. Og EI for elementene
% Elementnummer tilsvarer radnummer i "Elem-variabel"
% kolonne 1: Knutepunktnummer for lokal ende 1
% kolonne 2: Knutepunktnummer for lokal ende 2 
% kolonne 3: E-modul for materiale [GPa]
% kolonne 4: Tverrsnittstype, I-profil=1 og r?rprofil=2
% kolonne 5: Hvilket profil
elem = fscanf(filid,'%i %i %f %i %i',[5 nelem])'; %[knute, knute, E-modul, profil, type]
elem(:,3) = elem(:,3).*10^6; %E-modul oppgitt i GPa, gj?r om til Pa

%Les hvor mange laster som virker. 
nlast = fscanf(filid,'%i',[1 1]);


%Les lastdata
%lager en matrise med nlast antall rader og 5 kollonner
%kolonne 1: Lasttype
%       1: punktlast 
%       2: likt fordelt last 
%       3: lineaert fordelt last 
%       4: moment
%kolonne 2: elementnummer/knutepunkt
%           elementet lasten virker p?, 
%           moment: knutepunktet momentet virker i
%kolonne 3: punktlast: hvor langt fra lokal ende 1 lasten virker.
%           fordelt last og moment: ingen betydning 
%kolonne 4: punktlast, moment og likt fordelt last: st?rrelse. 
%           lieaert fordelt last: st?rrelse ved lokal ende 1
%kolonne 5: lineart fordelt last: st?rrelse ved lokal ende 2. 
%            Andre lasttyper: ingen betydning
last = fscanf(filid,'%i %i %f %f %f',[5 nlast])' ;
last(:,4) = last(:,4).*10^3; %Last oppgitt i kN, gj?r om til N
last(:,5) = last(:,5).*10^3; %Last oppgitt i kN, gj?r om til N

%antall iprofiler
nItverrsnitt = fscanf(filid,'%i',[1 1]);

%lager en matrise med dataene til alle I-profiler
%nItverrsnitt antall rader, 5 kolonner
%tar inn verdier til I-profil
%kolonne 1: flens lengde
%kolonne 2: toppflens tykkelse
%kolonne 3: bunnflens tykkelse
%kolonne 4: steg tykkelse
%kolonne 5: steg lengde
Itverrsnitt = fscanf(filid, '%f %f %f %f %f', [5 nItverrsnitt])';


%antall sirkul?re tverrsnitt
nStverrsnitt = fscanf(filid,'%i',[1 1]);

%lager en matrise med dataene til alle sirkulare/roer-profiler
%nStverrsnitt antall rader, 2 kolonner
%tar inn verdier til r?rprofil
%kollonne 1: ytre diameter
%kollonne 2: indre diameter
Stverrsnitt = fscanf(filid, '%f %f', [2 nStverrsnitt])';

% LUKKER INPUT-FILEN
fclose(filid);

end
