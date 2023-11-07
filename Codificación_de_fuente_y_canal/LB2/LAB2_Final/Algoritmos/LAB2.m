clear all;
clc;
close all;
%-----------------------------------------Parte sin codificacion

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

%----------------------------------------Parte simulada

% Secuencia larga de bits (1 Millón está bien)
M = entrada_modulador(10^6);%entrada_modulador(1000000); %secuencia larga de 1's y 0's

%Valores necesarios para generar ruido:
%Se incorporarán los valores en la función normrnd(media,desviación
% estándar, M (filas), N (columnas))

% Valores de gammas
Yubv_dB = 2:2:12; %requieren pasarse a valores reales
Yubv = 10 .^ (Yubv_dB / 10);

% Varianzas
varianzas = 1 ./ (2 * Yubv);

% Desviacion estandar
desviacion = sqrt(varianzas);

% Programa

for i = 1:length(desviacion)
    % Generación de ruidos
    ruido_gaussiano = normrnd(0, desviacion(i), 1, length(M));
    % Genero la salida del sampling and holding
    sampling = salida_demodulador(M, ruido_gaussiano); %señal
    %modulada con errores
    % Comparador del demodulador
    salida_demo = comparador(sampling); %conversión a 1's y 0's
    % Contabilizo el error
    error = 0;
    for k = 1:length(M)
        if M(k) ~= salida_demo(k)
            error = error + 1;
        end
    end
    % Agrego al BER los datos
    BER(i) = error / length(M);
end

disp(BER);
%Grafico la grafica con los datos simulados

plot(Yubv_dB, BER, 'x', 'Color', 'red', 'DisplayName', 'Simulado sin codificar');
hold off

%-------------------------------------------Parte con codificar
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

%Se utiliza la misma secuencia de ceros generada anteriormente.

%----------------------------------------Parte simulada

%Codificador de Hamming (7,4)

%Matriz P:
P = [1 0 1;
     1 1 1;
     1 1 0;
     0 1 1];
cod = []; %matriz de cod
palabra = [];
A = [];
B = [];
C = 0;
SXOR = 0;
%g=0;
fprintf('0')
for i=1:(k):length(M)
    A = M(i:i+3);
    cod = [cod A];
    for j=1:5
        B = P(1:4,j)';
        C = A.*B;
        for l=1:26
            SXOR = xor(SXOR,C(l));
            if (i==(1000000-3) && j==5)
                fprintf(' xor %1.0f',C(l))
            end
        end
        cod = [cod SXOR];
        SXOR = 0;
    end
    A = [];
    B = [];
    C = [];
    
end


% Secuencia larga de bits (1 Millón está bien)
% M = entrada_modulador(1000000); %secuencia larga de 1's y 0's

%Valores necesarios para generar ruido:
%Se incorporarán los valores en la función normrnd(media,desviación
% estándar, M (filas), N (columnas))

% Valores de gammas
Ybv_dB = 2:2:12; %requieren pasarse a valores reales
Ybv = 10 .^ (Ybv_dB / 10);

% Valores de k y n
n = 31;
k = 26;
t = 1; % Ya que el dmin siempre es 3
Rc = k/n;
Ycv = Rc * Ybv;

% Varianzas
varianzas = 1 ./ (2 * Ycv);

% Desviacion estandar
desviacion = sqrt(varianzas);

% Programa

for i = 1:length(desviacion)
    % Generación de ruidos
    ruido_gaussiano = normrnd(0, desviacion(i), 1, length(M));
    % Genero la salida del sampling and holding
    sampling = salida_demodulador(M, ruido_gaussiano); %señal
    %modulada con errores
    % Comparador del demodulador
    salida_demo = comparador(sampling); %conversión a 1's y 0's
    %Se contabilizará el BER en la salida del decodificador
%     % Contabilizo el error
%     error = 0;
%     for k = 1:length(M)
%         if M(k) ~= salida_demo(k)
%             error = error + 1;
%         end
%     end
%     % Agrego al BER los datos
%     BER(i) = error / length(M);
end

