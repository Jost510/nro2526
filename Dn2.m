% Domača naloga 2
clear all; close all; clc;

% Branje podatkov o vozliščih
filename_vozlisca = 'vozlisca_temperature_dn2_2.txt';
fid = fopen(filename_vozlisca, "r");

% Preskočimo glavo
fgetl(fid);

% Preberemo število koordinat v x
line = fgetl(fid);
Nx = sscanf(line, "st. koordinat v x-smeri: %d");

% Preberemo število koordinat v y
line = fgetl(fid);
Ny = sscanf(line, "st. koordinat v y-smeri: %d");

% Skupno število vseh vozlišč
line = fgetl(fid);
N = sscanf(line, "st. vseh vozlišč: %d");

% Dejansa vozlišča
data = textscan(fid, "%f %f %f", "Delimiter", ",");
fclose(fid);

x = data{1};
y = data{2};
T = data{3};

fprintf("Nx = %d, Ny = %d\n", Nx, Ny);
fprintf("Prebranih vozlišč: %d\n", length(x));

% Branje celic
fn_cells = "celice_dn2_2.txt";
fid = fopen(fn_cells, "r");

% Preskočimo glavo
fgetl(fid);

% Število celic
line = fgetl(fid);
Nc = sscanf(line, "st. celic: %d");

% Preberemo podatke o celicah
C = textscan(fid, "%f %f %f %f", "Delimiter", ",");
fclose(fid);

celice = [C{1}, C{2}, C{3}, C{4}];
fprintf("Prebranih celic: %d\n", Nc);

% Točka za temperaturo
Tx = 0.403;
Ty = 0.503;

% 1. METODA: scatteredInterpolant
tic;
F1 = scatteredInterpolant(x, y, T, "linear", "none");
T1 = F1(Tx, Ty);
cas1 = toc;
fprintf("\n1. SCATTEREDINTERPOLANT:\n");
fprintf("   Temperatura = %.6f °C , čas = %.6f s\n", T1, cas1);

% 2. METODA: griddedInterpolant
% Pripravimo mrežo za griddedInterpolant
xu = unique(x);
yu = unique(y);
Tmat = reshape(T, Nx, Ny)';

tic;
F2 = griddedInterpolant({yu, xu}, Tmat, "linear");
T2 = F2(Ty, Tx);
cas2 = toc;
fprintf("\n2. GRIDDEDINTERPOLANT:\n");
fprintf("   Temperatura = %.6f °C , čas = %.6f s\n", T2, cas2);

% 3. METODA: Ročna bilinearna interpolacija
tic;
% Izračunamo korak mreže
dx = xu(2) - xu(1);
dy = yu(2) - yu(1);

% Poiščemo indekse celice
ix = floor((Tx - xu(1)) / dx) + 1;
iy = floor((Ty - yu(1)) / dy) + 1;

% Preverimo meje
ix = max(1, min(ix, Nx-1));
iy = max(1, min(iy, Ny-1));

% Temperatura v ogljiščih
T11 = Tmat(iy,   ix);
T21 = Tmat(iy,   ix+1);
T12 = Tmat(iy+1, ix);
T22 = Tmat(iy+1, ix+1);

% Koordinate ogljišč
x1 = xu(ix);   x2 = xu(ix+1);
y1 = yu(iy);   y2 = yu(iy+1);

% Bilinearna interpolacija
K1 = (x2 - Tx)/(x2 - x1) * T11 + (Tx - x1)/(x2 - x1) * T21;
K2 = (x2 - Tx)/(x2 - x1) * T12 + (Tx - x1)/(x2 - x1) * T22;
T3 = (y2 - Ty)/(y2 - y1) * K1 + (Ty - y1)/(y2 - y1) * K2;

cas3 = toc;
fprintf("\n3. BILINEARNA INTERPOLACIJA:\n");
fprintf("   Temperatura = %.6f °C, čas = %.6f s\n", T3, cas3);

% Največja temperatura
[Tmax, idx] = max(T);
fprintf("\nNAJVEČJA TEMPERATURA:\n");
fprintf("   Temperatura = %.6f °C\n", Tmax);
fprintf("   Koordinate  = (%.6f, %.6f)\n", x(idx), y(idx));

% Primerjava hitrosti metod
fprintf("\nPRIMERJAVA ČASOV:\n");
fprintf("   scatteredInterpolant: %.6f s\n", cas1);
fprintf("   griddedInterpolant:   %.6f s\n", cas2);
fprintf("   Bilinearna:           %.6f s\n", cas3);

[~, fastest] = min([cas1, cas2, cas3]);
methods = {'scatteredInterpolant', 'griddedInterpolant', 'Bilinearna'};
fprintf("\nNAJHITREJŠA METODA: %s\n", methods{fastest});