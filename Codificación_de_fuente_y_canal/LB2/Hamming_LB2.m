clc;
close all;
clear all;
t = [2,4,6,8,10];
n = 7;
k = 4;
q = n - k;
v_opt = 0;
tam_M = 10^5;
M = randi([0,1],1,tam_M);

%Ruido
%Se genera una matriz donde cada fila es
%el ruido a cada valor de snr
i =1;
ruido = zeros(5,tam_M);
for yub_db =  2:2:10
    yub = 10^(yub_db/10);
    varianza = 1/(2*yub);
    r = randn(1,tam_M)*sqrt(varianza);
    ruido(i,:) = r;
    i = i +1;
end

%Calculamos los vectores 1 y -1
vector_mas_menos = zeros(1,tam_M);
for i = 1:1:length(M)
    if M(i) == 0
        vector_mas_menos(i) = -1;
    else 
        vector_mas_menos(i) = 1;
    end
end

%Sumamos 
vector_suma = zeros(5,tam_M);
vector_salida = zeros(5,tam_M);
for i = 1:1:5
    vector_suma(i,:) = ruido(i,:) + vector_mas_menos;
    %Calculamos el vector de salida del modulador
    for j = 1:1:tam_M
        if vector_suma(i,j)>v_opt
            vector_salida(i,j) = 1;
        else
            vector_salida(i,j) = 0;
        end
    end
end

%calculamos el BER
vector_error = zeros(5,tam_M);
vector_BER = zeros(1,5);
for i = 1:5
    vector_error(i,:) = xor(M,vector_salida(i,:));
    vector_BER(i) = sum(vector_error(i,:)==1)/tam_M;
end

% Valores Yub
Yub = linspace(1, 10, 100); % Abarco valores de 0 a 10 YubdB
YubdB = 10 * log10(Yub);

% Genero lista de Probabilidades sin codificar con Yub de 0 a 10 dB
Pub = erfc(sqrt(2 * Yub)/2^0.5)/2; %función Q(x)

% Grafica Teorica limitada de 2 a 10 dB
figure(1);
plot(YubdB, Pub, 'DisplayName', 'Teórico sin codificar');
title('Pub y BER vs Yub');
xlim([2, 10]);
xlabel('Yub (dB)');
ylabel('Pb');
set(gca, 'YScale', 'log'); %colocar el eje y a escala logarítmica
hold on;

scatter(t,vector_BER);
%%
%Codificacion
% Valores Yub
Yb = linspace(1, 10, 100); % Abarco valores de 0 a 10 YubdB
YbdB = 10 * log10(Yub);

% Valores de k y n
n = 7;
k = 4;
t = 1; % Ya que el dmin siempre es 3
Rc = k/n;
Yc = Rc * Yb;

% Genero lista de Probabilidades sin codificar con Yub de 0 a 10 dB
alfa = erfc(sqrt(2*Yc)/2^0.5)/2;

% Probabilidad
comb = factorial(n-1)/(factorial(t)*(factorial(n-1-t))); %nchoosek(n-1,t)
Pb = comb * (alfa.^(t+1));

% Grafica Teorica
figure(2)
plot(YbdB, Pb, 'DisplayName', 'Teórico con codificar');
title('Pub y BER vs Yb');
xlim([2, 10]);
xlabel('Yb (dB)');
ylabel('Pb');
set(gca, 'YScale', 'log'); %colocar el eje y a escala logarítmica
hold on