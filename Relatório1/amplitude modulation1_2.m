% 1. Gerar um sinal s(t) composto pela somatória de 3 senos com amplitudes
% de 5V, 5/3V e 1V e frequências de 1, 3 e 5 kHz, respectivamente.

% 2. Plotar em uma figura os três cossenos e o sinal 's ' no domínio do tempo e
% da frequência

% 3. Gerar 3 filtros ideais:
% • Passa baixa (frequência de corte em 2kHz)
% • Passa alta (banda de passagem acima de 4kHz)
% • Passa faixa (banda de passagem entre 2 e 4kHz)

% 4. Plotar em uma figura a resposta em frequência dos 3 filtros

% 5. Passar o sinal s(t) através dos 3 filtros e plotar as saídas, no domínio do
% tempo e da frequência, para os 3 casos

% Aluno: Rafael Teles Espindola
% Exercicio referente ao segundo slide

clear all
close all
clc

%%%%%%%%%%%%%%%%%%%%%%%    No Tempo   %%%%%%%%%%%%%%%%%%%%%%%

fs = 90000;
t  = 0:1/fs:1-(1/fs);

A1 = 5;   f1 = 1000;
A2 = 5/3; f2 = 3000;
A3 = 1;   f3 = 5000;

s1 = A1*cos(2*pi*f1*t);
s2 = A2*cos(2*pi*f2*t);
s3 = A3*cos(2*pi*f3*t);

s_t =  s1 +s2 +s3;


%%%%%%%%%%%%%%%%%%%%%%% Na Frequencia %%%%%%%%%%%%%%%%%%%%%%%

s_f   = fft(s_t);
s_f1  = fftshift(s_f)/length(s_f);

s1_f  = fft(s1);
s1_f1 = fftshift(s1_f)/length(s1_f);

s2_f  = fft(s2);
s2_f1 = fftshift(s2_f)/length(s2_f);

s3_f  = fft(s3);
s3_f1 = fftshift(s3_f)/length(s3_f);

f     = -0.5*fs:(0.5*fs)-1;

%%%%%%%%%%%%%%%%%%%%%%%    Filtros    %%%%%%%%%%%%%%%%%%%%%%%

% Passa baixa (frequência de corte em 2kHz)
f_pb_2k = [zeros(1, (fs/2)-2000) ones(1, 4001) zeros(1, (fs/2)-2001)];

%Passa alta (banda de passagem acima de 4kHz)
f_pa_4k = [ones(1, 41000) zeros(1, 8001) ones(1, 40999)];

%Passa faixa (banda de passagem entre 2 e 4kHz)
f_pf_2k_4k = ~(f_pb_2k + f_pa_4k);


%%%%%%%%%%%%%%%%%%%%%%% s(t) filtrado %%%%%%%%%%%%%%%%%%%%%%%

% Filtrado na frequencia
s_f_pb = s_f1.*f_pb_2k;
s_f_pa = s_f1.*f_pa_4k;
s_f_pf = s_f1.*f_pf_2k_4k;

% Passando o sinal filtrado na frequencia para o tempo
s_t_pb = ifft(ifftshift(s_f_pb)*length(s_f_pb));
s_t_pa = ifft(ifftshift(s_f_pa)*length(s_f_pa));
s_t_pf = ifft(ifftshift(s_f_pf)*length(s_f_pf));


%%%%%%%%%%%%%%%%%%%%%%%     Plots     %%%%%%%%%%%%%%%%%%%%%%%



% Figura 1
figure(1)
subplot(421)
plot(t, s_t)
xlim([0 1/500])
ylim([-12 12])
title('Soma de cossenos no tempo')
xlabel('s')
ylabel('V')

subplot(423)
plot(t, s1)
xlim([0 1/500])
ylim([-5 5])
title('Cosseno no tempo 5V 1KHz')
xlabel('s')
ylabel('V')

subplot(425)
plot(t, s2)
xlim([0 1/500])
ylim([-5/3 5/3])
title('Cosseno no tempo 5/3V 3KHz')
xlabel('s')
ylabel('V')

subplot(427)
plot(t, s3)
xlim([0 1/500])
ylim([-1 1])
title('Cossenos no tempo 1V 5KHz')
xlabel('s')
ylabel('V')

subplot(422)
plot(f, abs(s_f1))
xlim([-6000 6000])
ylim([0 3])
title('Espectro de frequência do sinal S(f)')
xlabel('Hz')
ylabel('V')

subplot(424)
plot(f, abs(s1_f1))
xlim([-6000 6000])
ylim([0 3])
title('Cosseno na frequência 5V 1KHz')
xlabel('Hz')
ylabel('V')

subplot(426)
plot(f, abs(s2_f1))
xlim([-6000 6000])
ylim([0 2])
title('Cosseno na frequência 5/3V 3KHz')
xlabel('Hz')
ylabel('V')

subplot(428)
plot(f, abs(s3_f1))
xlim([-6000 6000])
ylim([0 1])
title('Cosseno na frequência 1V 5KHz')
xlabel('Hz')
ylabel('V')

% Figura 3
figure(3)
subplot(311)
plot(f, f_pb_2k)
title('Filtro passa baixa')
axis([-7000 7000 0 1.5])

subplot(312)
plot(f, f_pa_4k)
title('Filtro passa alta')
axis([-7000 7000 0 1.5])

subplot(313)
plot(f, f_pf_2k_4k)
title('Filtro passa faixa')
axis([-7000 7000 0 1.5])

% Figura 4
figure(4)
subplot(321)
plot(t, s_t_pb)
xlim([0 0.002])
title('s(t) filtrado PB')

subplot(322)
plot(f, s_f_pb)
xlim([-6000 6000])
ylim([0 3])
title('S(f) filtrado PB')

subplot(323)
plot(t, s_t_pa)
xlim([0 0.002])
title('s(t) filtrado PA')

subplot(324)
plot(f, s_f_pa)
xlim([-6000 6000])
ylim([0 0.6])
title('S(f) filtrado PA')

subplot(325)
plot(t, s_t_pf)
xlim([0 0.002])
title('s(t) filtrado PF')

subplot(326)
plot(f, s_f_pf)
xlim([-6000 6000])
title('S(f) filtrado PF')
ylim([0 1])
