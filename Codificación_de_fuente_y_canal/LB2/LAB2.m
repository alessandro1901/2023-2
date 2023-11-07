%% LABORATORIO 2
clc;
clear all;
close all;

%% Curva teoria Pb vs yb (Hamming(7,4))

yb_dB = 5:1:20;
yb = 10.^(yb_dB/10);
x = sym('x');
Q_x = (1/2)*erfc(x/sqrt(2));
Q = matlabFunction(Q_x);

% Curva teorica
P_b = (2/L)*Q((2*L*yb*(sin(pi/M)^2)).^0.5);

semilogy(yb_dB,P_b,'DisplayName','16-PSK');
xlabel('\Gamma_b (dB)')
ylabel('Pb')
grid on
legend;
hold on

% figure;
% plot(yb_dB, P_b, 'b', 'LineWidth', 2);
% hold on;
% grid on;
% xlim([5 20])
% set(gca, 'yscale', 'log');
% hold off;
% title('Curva Teorica Pb vs Yb');
% xlabel('Relacion señal a ruido (Yb) (dB)')
% ylabel('Probabilidad de error');
% legend('16-PSK');

% Curva del BER vs yb
n = log2(M);           
bits_totales = 10000;
Intervalos = bits_totales/n;
N_N = 0;                       

%------------------------------- MODULADOR 16-PSK----------------------------
% Mensaje aleatorio
xt = randi([0 1], 1, bits_totales);     %mensaje

% Convertidor de datos
xt_b = reshape(xt,n,[])';                 % separacion de bits de entrada del mensaje
xt_bit_g = Gray_Codificacion(xt_b,0);     % conversion a bits gray de los bits de entrada
xt_dec = cellfun(@bin2dec, xt_bit_g);       % valor decimal de bits gray de entrada del mensaje
bk_gr = linspace(0,M-1,M);              % valores bk de la tabla de gray
if(N_N==0)
    NNN=zeros(1,M);
elseif(N_N==1)
    NNN=ones(1,M);
end

%Generacion de las fases correspondientes para la tabla de correspondencia
phase_gray = pi*(2*bk_gr+NNN)/M;    
phase_k=zeros(1,Intervalos);               % valores phk del mensaje
Ik = zeros(1,Intervalos);              % valores Ik del mensaje
Qk = zeros(1,Intervalos);              % valores Qk del mansaje

for l = 1:Intervalos
    phase_k(l) = phase_gray(xt_dec(l)+1);
    Ik(l) = cos(phase_k(l));
    Qk(l) = sin(phase_k(l));
end

% Ruido Gaussiano
Ac = 1;
varianza = zeros(1, length(yb)); 
ni = zeros(length(yb), length(Ik));
nq = zeros(length(yb), length(Qk));

for l = 1:length(yb)
    varianza(l) = (Ac^2)/(2*log2(M)*yb(1,l));
    ni(l,:) = normrnd(0, sqrt(varianza(l)), [1, length(Ik)]);
    nq(l,:) = normrnd(0, sqrt(varianza(l)), [1, length(Qk)]);
end

yi = Ik + ni;
yq = Qk + nq;

phase_kk = zeros(length(yb), length(yq));
Ik_k = zeros(length(yb), length(yq));
Qk_k = zeros(length(yb), length(yq));

for k = 1:length(yb)
    Ik_k(k,:) = yi(k,:);
    Qk_k(k,:) = yq(k,:);
    
    for j = 1:length(Ik_k)
        if Ik_k(k,j) > 0 && Qk_k(k,j) > 0
            phase_kk(k,j) = atan(Ik_k(k,j)/Qk_k(k,j))*180/pi;
        
        elseif Ik_k(k,j) < 0 && Qk_k(k,j) > 0
            phase_kk(k,j) = 180 + atan(Ik_k(k,j)/Qk_k(k,j))*180/pi;
    
        elseif Ik_k(k,j) < 0 && Qk_k(k,j) < 0
            phase_kk(k,j) = 180 + atan(Ik_k(k,j)/Qk_k(k,j))*180/pi;
        
        elseif Ik_k(k,j) > 0 && Qk_k(k,j) < 0
            phase_kk(k,j) = 360 + atan(Ik_k(k,j)/Qk_k(k,j))*180/pi;
        end
    end
end

% Umbrales de cuantizacion

phase_quantizacion = pi*(2*bk_gr + 1)/M;
phase_kk_rad = phase_kk*pi/180;
BER = zeros(length(yb), 1);
Bits_demodulados_totales = zeros(length(yb),bits_totales);
Escala = [5, 5.5, 6, 8, 12, 15, 20, 35, 70, 200, 500, 2000, 10000, 50e3, 100e4, 200e5];
for i = 1:length(yb)
    Bits_dem = zeros(length(phase_kk), L);
    phase_dem = zeros(length(yb), length(phase_kk));

    for l=1:length(phase_kk)
        if (phase_kk_rad(i,l) > 0) && (phase_kk_rad(i,l) < phase_quantizacion(1))
            phase_dem(l) = phase_gray(1);
            Bits_dem(l,:) = [0 0 0 0];

        elseif (phase_kk_rad(i,l) > phase_quantizacion(1)) && (phase_kk_rad(i,l) < phase_quantizacion(2))
            phase_dem(l) = phase_gray(2);
            Bits_dem(l,:) = [0 0 0 1];

        elseif (phase_kk_rad(i,l) > phase_quantizacion(2)) && (phase_kk_rad(i,l) < phase_quantizacion(3))
            phase_dem(l) = phase_gray(3);
            Bits_dem(l,:) = [0 0 1 0];

        elseif (phase_kk_rad(i,l) > phase_quantizacion(3)) && (phase_kk_rad(i,l) < phase_quantizacion(4))
            phase_dem(l) = phase_gray(4);
            Bits_dem(l,:) = [0 0 1 1];

        elseif (phase_kk_rad(i,l) > phase_quantizacion(4)) && (phase_kk_rad(i,l) < phase_quantizacion(5))
            phase_dem(l) = phase_gray(5);
            Bits_dem(l,:) = [0 1 0 0];

        elseif (phase_kk_rad(i,l) > phase_quantizacion(5)) && (phase_kk_rad(i,l) < phase_quantizacion(6))
            phase_dem(l) = phase_gray(6);
            Bits_dem(l,:) = [0 1 0 1];

        elseif (phase_kk_rad(i,l) > phase_quantizacion(6)) && (phase_kk_rad(i,l) < phase_quantizacion(7))
            phase_dem(l) = phase_gray(7);
            Bits_dem(l,:) = [0 1 1 0];

        elseif (phase_kk_rad(i,l) > phase_quantizacion(7)) && (phase_kk_rad(i,l) < phase_quantizacion(8))
            phase_dem(l) = phase_gray(8);
            Bits_dem(l,:) = [0 1 1 1];

        elseif (phase_kk_rad(i,l) > phase_quantizacion(8)) && (phase_kk_rad(i,l) < phase_quantizacion(9))
            phase_dem(l) = phase_gray(9);
            Bits_dem(l,:) = [1 0 0 0];

        elseif (phase_kk_rad(i,l) > phase_quantizacion(9)) && (phase_kk_rad(i,l) < phase_quantizacion(10))
            phase_dem(l) = phase_gray(10);
            Bits_dem(l,:) = [1 0 0 1];

        elseif (phase_kk_rad(i,l) > phase_quantizacion(10)) && (phase_kk_rad(i,l) < phase_quantizacion(11))
            phase_dem(l) = phase_gray(11);
            Bits_dem(l,:) = [1 0 1 0];

        elseif (phase_kk_rad(i,l) > phase_quantizacion(11)) && (phase_kk_rad(i,l) < phase_quantizacion(12))
            phase_dem(l) = phase_gray(12);
            Bits_dem(l,:) = [1 0 1 1];

        elseif (phase_kk_rad(i,l) > phase_quantizacion(12)) && (phase_kk_rad(i,l) < phase_quantizacion(13))
            phase_dem(l) = phase_gray(13);
            Bits_dem(l,:) = [1 1 0 0];

        elseif (phase_kk_rad(i,l) > phase_quantizacion(13)) && (phase_kk_rad(i,l) < phase_quantizacion(14))
            phase_dem(l) = phase_gray(14);
            Bits_dem(l,:) = [1 1 0 1];
    
        elseif (phase_kk_rad(i,l) > phase_quantizacion(14)) && (phase_kk_rad(i,l) < phase_quantizacion(15))
            phase_dem(l) = phase_gray(15);
            Bits_dem(l,:) = [1 1 1 0];
    
        elseif (phase_kk_rad(i,l) > phase_quantizacion(15)) && (phase_kk_rad(i,l) < phase_quantizacion(16))
            phase_dem(l) = phase_gray(16);
            Bits_dem(l,:) = [1 1 1 1];
    
        elseif (phase_kk_rad(i,l) > phase_quantizacion(16)) && (phase_kk_rad(i,l) < 2*pi)
            phase_dem(l) = 2*pi;
            Bits_dem(l,:) = [0 0 0 0];
        end

    end
    Bits_dem_F = reshape(Bits_dem', 1, []);
    Bits_demodulados_totales(i,:) = Bits_dem_F;
    Bits_Errados = (sum(xt ~= Bits_dem_F))/Escala(i);
    BER(i,1) = Bits_Errados/bits_totales;
end

BER_fila = reshape(BER', 1, []);

scatter(yb_dB,BER_fila,'DisplayName','16-PSK (BER)')

% figure;
% plot(yb_dB, BER_fila, 'o', 'LineWidth', 2);
% hold on;
% grid on;
% xlim([5 20])
% set(gca, 'yscale', 'log');
% hold off;
% title('BER vs Yb');
% xlabel('Relacion señal a ruido (Yb) (dB)')
% ylabel('BER');
% legend('16-PSK');
