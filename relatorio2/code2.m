% • Gerar 3 sinais (cosenos) nas frequências 1k, 2k e 3k
% • Realizar a multiplexação dos sinais para as frequências 10k,
%   12k e 14k para a transmissão em um canal de comunicação
% • Recuperar os sinais originais

%clear all
close all
clc

fs = 90e3;                          % Frequencia de amostragem
t  = 0:1/fs:1-(1/fs);               % Tempo

Am1 = 1; f1 = 1e3;  Ao1 = 0;        % Amplitude, frequencia e componente DC do Modulante               
Am2 = 1; f2 = 2e3;  Ao2 = 0;        % Amplitude, frequencia e componente DC do Modulante              
Am3 = 1; f3 = 3e3;  Ao3 = 0;        % Amplitude, frequencia e componente DC do Modulante              
Ac1 = 1; f4 = 10e3; Ao4 = 0;        % Amplitude, frequencia e componente DC da Portadora              
Ac2 = 1; f5 = 12e3; Ao5 = 0;        % Amplitude, frequencia e componente DC da Portadora
Ac3 = 1; f6 = 14e3; Ao6 = 0;        % Amplitude, frequencia e componente DC da Portadora

m_t1 = Ao1 + Am1*cos(2*pi*f1*t);    % Sinal Modulante no tempo
m_t2 = Ao2 + Am2*cos(2*pi*f2*t);    % Sinal Modulante no tempo
m_t3 = Ao3 + Am3*cos(2*pi*f3*t);    % Sinal Modulante no tempo
c_t1 = Ao4 + Ac1*cos(2*pi*f4*t);    % Sinal Portadora no tempo
c_t2 = Ao4 + Ac2*cos(2*pi*f5*t);    % Sinal Portadora no tempo
c_t3 = Ao4 + Ac3*cos(2*pi*f6*t);    % Sinal Portadora no tempo
s_t1 = m_t1.*c_t1;                  % Sinal Modulado  no tempo
s_t2 = m_t2.*c_t2;                  % Sinal Modulado  no tempo
s_t3 = m_t3.*c_t3;                  % Sinal Modulado  no tempo

m_f1 = fft(m_t1);                   % Transformada de fourier 
m_f1 = fftshift(m_f1)/length(m_f1); % Sinal c_t1 no domínio da frequencia
m_f2 = fft(m_t2);                   % Transformada de fourier
m_f2 = fftshift(m_f2)/length(m_f2); % Sinal c_t2 no domínio da frequencia
m_f3 = fft(m_t3);                   % Transformada de fourier
m_f3 = fftshift(m_f3)/length(m_f3); % Sinal c_t1 no domínio da frequencia
c_f1 = fft(c_t1);                   % Transformada de fourier 
c_f1 = fftshift(c_f1)/length(c_f1); % Sinal c_t1 no domínio da frequencia
c_f2 = fft(c_t2);                   % Transformada de fourier
c_f2 = fftshift(c_f2)/length(c_f2); % Sinal c_t2 no domínio da frequencia
c_f3 = fft(c_t3);                   % Transformada de fourier
c_f3 = fftshift(c_f3)/length(c_f3); % Sinal c_t1 no domínio da frequencia
s_f1 = fft(s_t1);                   % Transformada de fourier 
s_f1 = fftshift(s_f1)/length(s_f1); % Sinal s_t1 no domínio da frequencia
s_f2 = fft(s_t2);                   % Transformada de fourier
s_f2 = fftshift(s_f2)/length(s_f2); % Sinal s_t2 no domínio da frequencia
s_f3 = fft(s_t3);                   % Transformada de fourier
s_f3 = fftshift(s_f3)/length(s_f3); % Sinal s_t1 no domínio da frequencia

f = -0.5*fs:0.5*fs-1;               % Eixo das abiscissas no plot do dominio na frequencia

% Plot dos sinais modulados no dominio da frequencia 
figure(1)
subplot(331)
plot(f, abs(m_f1))
title("m1(f) 1Khz")
xlim([-4000 4000])
ylim([0 0.6])
subplot(334)
plot(f, abs(m_f2))
title("m2(f) 2Khz")
xlim([-4000 4000])
ylim([0 0.6])
subplot(337)
plot(f, abs(m_f3))
title("m3(f) 3Khz")
xlim([-4000 4000])
ylim([0 0.6])
subplot(332)
plot(f, abs(c_f1))
title("c1(f) 10Khz")
xlim([-18000 18000])
ylim([0 0.6])
subplot(335)
plot(f, abs(c_f2))
title("c2(f) 12Khz")
xlim([-18000 18000])
ylim([0 0.6])
subplot(338)
plot(f, abs(c_f3))
title("c3(f) 14Khz")
xlim([-18000 18000])
ylim([0 0.6])
subplot(333)
plot(f, abs(s_f1))
title("s1(f) 9Khz e 11Khz")
xlim([-18000 18000])
ylim([0 0.6])
subplot(336)
plot(f, abs(s_f2))
title("s2(f) 10Khz e 14KHz")
xlim([-18000 18000])
ylim([0 0.6])
subplot(339)
plot(f, abs(s_f3))
title("s3(f) 11Khz e 17KHz")
xlim([-18000 18000])
ylim([0 0.6])


% Filtros ideais para usar na filtragem no dominio da frequencia
filtro_11k = [zeros(1, 33000) ones(1, 2000) zeros(1, 20000) ones(1, 2000) zeros(1, 33000)];
filtro_14k = [zeros(1, 30000) ones(1, 2000) zeros(1, 26000) ones(1, 2000) zeros(1, 30000)];
filtro_17k = [zeros(1, 27000) ones(1, 2000) zeros(1, 32000) ones(1, 2000) zeros(1, 27000)];

                                  % Sinal filtrado na frequencia com filtro ideal
                                  % Filtrado apenas banda lateral superior
s_f1_filtrado = filtro_11k.*s_f1; % Excluindo componente de frequencia de 9KHz
s_f2_filtrado = filtro_14k.*s_f2; % Excluindo componente de frequencia de 10KHz
s_f3_filtrado = filtro_17k.*s_f3; % Excluindo componente de frequencia de 11KHz

figure(2)
subplot(331)
plot(f, s_f1)
xlim([-18000 18000])
ylim([0 0.3])
title("s1(f) 9KHz e 11KHz")
subplot(334)
plot(f, s_f2)
xlim([-18000 18000])
ylim([0 0.3])
title("s2(f) 10KHz e 14KHz")
subplot(337)
plot(f, s_f3)
xlim([-18000 18000])
ylim([0 0.3])
title("s3(f) 11KHz e 17KHz")
subplot(332)
plot(f, filtro_11k)
xlim([-18000 18000])
ylim([0 1.1])
title("Filtro PB 11KHz")
subplot(335)
plot(f, filtro_14k)
xlim([-18000 18000])
ylim([0 1.1])
title("Filtro PB 14KHz")
subplot(338)
plot(f, filtro_17k)
xlim([-18000 18000])
ylim([0 1.1])
title("Filtro PB 17KHz")
subplot(333)
plot(f, s_f1_filtrado)
xlim([-18000 18000])
ylim([0 0.3])
title("Filtrado 11KHz")
subplot(336)
plot(f, s_f2_filtrado)
xlim([-18000 18000])
ylim([0 0.3])
title("Filtrado 14KHz")
subplot(339)
plot(f, s_f3_filtrado)
xlim([-18000 18000])
ylim([0 0.3])
title("Filtrado 17KHz")


% Sinal filtrado na frequencia multiplexado em 3 canais
% Este eh o sinal a ser transmidito pela antena
y_f = s_f1_filtrado + s_f2_filtrado + s_f3_filtrado;

figure(3)
subplot(411)
plot(f, s_f1_filtrado)
xlim([-18000 18000])
ylim([0 0.3])
title("Filtrado 11KHz")
subplot(412)
plot(f, s_f2_filtrado)
xlim([-18000 18000])
ylim([0 0.3])
title("Filtrado 14KHz")
subplot(413)
plot(f, s_f3_filtrado)
xlim([-18000 18000])
ylim([0 0.3])
title("Filtrado 17KHz")
subplot(414)
plot(f, y_f)
xlim([-18000 18000])
ylim([0 0.3])
title("Sinais somados ou Sinal transmitido")


% Recebendo sinal e filtrando em 11k 14k 17k no dominio da frequencia
y_11k = y_f.*filtro_11k;
y_14k = y_f.*filtro_14k;
y_17k = y_f.*filtro_17k;

figure(4)
subplot(411)
plot(f, y_f)
xlim([-18000 18000])
ylim([0 0.3])
title("Sinal de entrada")
subplot(412)
plot(f, y_11k)
xlim([-18000 18000])
ylim([0 0.3])
title("Filtrado em 11KHz")
subplot(413)
plot(f, y_14k)
xlim([-18000 18000])
ylim([0 0.3])
title("Filtrado em 14KHz")
subplot(414)
plot(f, y_17k)
xlim([-18000 18000])
ylim([0 0.3])
title("Filtrado em 17KHz")


                              % Convoluindo sinal filtrado e portadora
                              % para obter o sinal na frequencia original
y_21k_1k = conv(y_11k, c_f1); % Convoluindo 11KHz com 10KHz
y_26k_2k = conv(y_14k, c_f2); % Convoluindo 14KHz com 12KHz
y_31k_3k = conv(y_17k, c_f3); % Convoluindo 17KHz com 14KHz

f2 = -fs:fs-2; % Eixo da frequencia do sinal convoluido

figure(5)
subplot(331)
plot(f, y_11k)
xlim([-18000 18000])
ylim([0 0.3])
title("Sinal em 11KHz")
subplot(334)
plot(f, y_14k)
xlim([-18000 18000])
ylim([0 0.3])
title("Sinal em 14KHz")
subplot(337)
plot(f, y_17k)
xlim([-18000 18000])
ylim([0 0.3])
title("Sinal em 17KHz")
subplot(332)
plot(f, c_f1)
xlim([-15000 15000])
ylim([0 0.6])
title("Portadora c1(f) 10KHz")
subplot(335)
plot(f, c_f2)
xlim([-15000 15000])
ylim([0 0.6])
title("Portadora c2(f) 12KHz")
subplot(338)
plot(f, c_f3)
xlim([-15000 15000])
ylim([0 0.6])
title("Portadora c3(f) 14KHz")
subplot(333)
plot(f2, y_21k_1k)
xlim([-32000 32000])
ylim([0 0.6])
title("Sinal convoluido 21KHz e 1KHz")
subplot(336)
plot(f2, y_26k_2k)
xlim([-32000 32000])
ylim([0 0.6])
title("Sinal convoluido 26KHz e 2KHz")
subplot(339)
plot(f2, y_31k_3k)
xlim([-32000 32000])
ylim([0 0.6])
title("Sinal convoluido 31KHz e 3KHz")


% Filtro pb 4kHz
% Com apenas este filtro ja eh capaz de pegar o sinal original
% para os 3 sinais
filtro_pb_4k = [zeros(1, 86000) ones(1, 7999) zeros(1, 86000)];

                               % Filtrando apenas a frequencia original
y_1k = y_21k_1k.*filtro_pb_4k; % Obtendo apenas a frequencia de 1kHz
y_2k = y_26k_2k.*filtro_pb_4k; % Obtendo apenas a frequencia de 2kHz
y_3k = y_31k_3k.*filtro_pb_4k; % Obtendo apenas a frequencia de 3kHz

figure(6)
subplot(311)
plot(f2, y_1k)
xlim([-4000 4000])
title("Sinal recuperado de 1KHz")
subplot(312)
plot(f2, y_2k)
xlim([-4000 4000])
title("Sinal recuperado de 2KHz")
subplot(313)
plot(f2, y_3k)
xlim([-4000 4000])
title("Sinal recuperado de 3KHz")
 

