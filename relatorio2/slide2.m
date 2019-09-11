% • Gerar 3 sinais (cosenos) nas frequências 1k, 2k e 3k
% • Realizar a multiplexação dos sinais para as frequências 10k,
%   12k e 14k para a transmissão em um canal de comunicação
% • Recuperar os sinais originais

close all
clear all
clc

fs = 90e3;
t  = 0:1/fs:1-(1/fs);

Am1 = 1; f1 = 1e3;  Ao1 = 0; % Modulante               
Am2 = 1; f2 = 2e3;  Ao2 = 0; % Modulante              
Am3 = 1; f3 = 3e3;  Ao3 = 0; % Modulante              
Ac1 = 1; f4 = 10e3; Ao4 = 0; % Portadora              
Ac2 = 1; f5 = 12e3; Ao5 = 0; % Portadora
Ac3 = 1; f6 = 13e3; Ao6 = 0; % Portadora

m_t1 = Ao1 + Am1*cos(2*pi*f1*t); % Modulante
m_t2 = Ao2 + Am2*cos(2*pi*f2*t); % Modulante
m_t3 = Ao3 + Am3*cos(2*pi*f3*t); % Modulante
c_t1 = Ao4 + Ac1*cos(2*pi*f4*t); % Portadora
c_t2 = Ao4 + Ac2*cos(2*pi*f5*t); % Portadora
c_t3 = Ao4 + Ac3*cos(2*pi*f6*t); % Portadora

s_t1 = m_t1.*c_t1; % Sinal modulado
s_t2 = m_t2.*c_t2; % Sinal modulado
s_t3 = m_t3.*c_t3; % Sinal modulado 

s_f1 = fft(s_t1);
s_f1 = fftshift(s_f1)/length(s_f1);

s_f2 = fft(s_t2);
s_f2 = fftshift(s_f2)/length(s_f2);

s_f3 = fft(s_t3);
s_f3 = fftshift(s_f3)/length(s_f3);

f = -0.5*fs:0.5*fs-1;

% Sinais na frequencia 
figure(1)
subplot(311)
plot(f, abs(s_f1))
subplot(312)
plot(f, abs(s_f2))
subplot(313)
plot(f, abs(s_f3))

% Filtros ideais
filtro_11k = [zeros(1, 33000) ones(1, 2000) zeros(1, 20000) ones(1, 2000) zeros(1, 33000)];
filtro_14k = [zeros(1, 30000) ones(1, 2000) zeros(1, 26000) ones(1, 2000) zeros(1, 30000)];
filtro_16k = [zeros(1, 28000) ones(1, 2000) zeros(1, 30000) ones(1, 2000) zeros(1, 28000)];

% Sinal filtrado na frequencia com filtro ideal
s_f1_filtrado = filtro_11k.*s_f1;
figure(2)
subplot(411)
plot(f, s_f1_filtrado)

s_f2_filtrado = filtro_14k.*s_f2;
subplot(412)
plot(f, s_f2_filtrado)

s_f3_filtrado = filtro_16k.*s_f3;
subplot(413)
plot(f, s_f3_filtrado)

% Sinal transmitido multiplexado 3 canais
subplot(414)
y_f = s_f1_filtrado + s_f2_filtrado + s_f3_filtrado;
plot(f, y_f)

% Recebendo sinal e filtrando em 11k 14k 16k
y_11k = y_f.*filtro_11k;
y_14k = y_f.*filtro_14k;
y_16k = y_f.*filtro_16k;

% Multiplicando sinal filtrado pela portadora
y_11k_1k = y_11k.*c_t1;
y_14k_2k = y_14k.*c_t2;
y_16k_3k = y_16k.*c_t3;

% Filtro pb 4kHz
filtro_pb_4k = [zeros(1, 41000) ones(1, 8000) zeros(1, 41000)]; 

%% Voltando para banda base
y_1k = conv(y_11k, filtro_pb_4k);
%y_2k = conv(y_14k, filtro_pb_4k);
%y_3k = conv(y_16k, filtro_pb_4k);

f2 = -fs:fs-2;

figure(3)
subplot(311)
plot(f2, y_1k)
%subplot(312)
%plot(f2, y_2k)
%subplot(313)
%plot(f2, y_3k)







