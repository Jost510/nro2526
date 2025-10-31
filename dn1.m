% NALOGA 1

fid = fopen('naloga1_1.txt', 'r');

% - Prva vrstica
fgetl(fid);

% - Druga vrstica
fgetl(fid);

t = fscanf(fid, '%f');

fclose(fid);

% rezultat
disp('Vektor t:');
disp(t);


% NALOGA 2

fid = fopen('naloga1_2.txt', 'r');

% - prva vrstica
vrstica = fgetl(fid);
n = sscanf(vrstica, 'stevilo_podatkov_P: %d');

% vektor P
P = zeros(n, 1);


for i = 1:n
    P(i) = fscanf(fid, '%f', 1);
end

fclose(fid);

% Izris grafa P(t)
figure;
plot(t, P, 'b-', 'LineWidth', 1.5);
xlabel('t [s]');
ylabel('P [W]');
grid on;


% NALOGA 3

% t in P od prej
n = length(t); 
integral = 0;

% Trapezna metoda - brez trap
for i = 1:n-1
    dt = t(i+1) - t(i);
    povprecje = (P(i) + P(i+1)) / 2;
    integral = integral + povprecje * dt;
end

% Rezultat
disp('Rezultat trapezne metode:')
disp(integral)




