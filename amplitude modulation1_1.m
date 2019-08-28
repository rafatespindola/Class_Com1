% Exercícios

% 1. Gerar um sinal s(t) composto pela somatória de 3 cossenos com
% amplitudes de 6V, 2V e 4V e frequências de 1, 3 e 5 kHz,
% respectivamente.

% 2. Plotar em uma figura os três cossenos e o sinal 's ' no domínio do
% tempo e da frequência.

% 3. Utilizando a função 'norm', determine a potência média do sinal 's'.

% 4. Utilizando a função 'pwelch', plote a Densidade Espectral de
% Potência do sinal 's'.

% Aluno: Rafael Teles Espindola
% Exercicio referente ao primeiro slide

clear all
close all
clc

%%%%%%%%%%%%%%%%%%%%%%%    No Tempo   %%%%%%%%%%%%%%%%%%%%%%%

fs   = 90000;
t = 0:1/fs:1-(1/fs);

A1 = 6; f1 = 1000;
A2 = 2; f2 = 3000;
A3 = 4; f3 = 5000;

s1 = A1*cos(2*pi*f1*t);
s2 = A2*cos(2*pi*f2*t);
s3 = A3*cos(2*pi*f3*t);

s_t =  s1 +s2 +s3;

%%%%%%%%%%%%%%%%%%%%%%% Na Frequencia %%%%%%%%%%%%%%%%%%%%%%%

s_f  = fft(s_t);
s_f1 = fftshift(s_f)/length(s_f);
f    = -45000:45000-1;

s1_f  = fft(s1);
s1_f1 = fftshift(s1_f)/length(s1_f);
f1    = -45000:45000-1;

s2_f  = fft(s2);
s2_f1 = fftshift(s2_f)/length(s2_f);
f2    = -45000:45000-1;

s3_f  = fft(s3);
s3_f1 = fftshift(s3_f)/length(s3_f);
f3    = -45000:45000-1;


%%%%%%%%%%%%%%%%%%%%%%% Potencia media %%%%%%%%%%%%%%%%%%%%%%

pm = (norm(s_t)^2)/length(s_t)

%%%%%%%% Densidade Espectral de potencia do sinal 's' %%%%%%%

figure(3)
pwelch(s_t, [], [], fs)

%%%%%%%%%%%%%%%%%%%%%%%   Plot s(t)   %%%%%%%%%%%%%%%%%%%%%%%

figure(1)

subplot(421)
plot(t, s_t)
xlim([0 1/500])
ylim([-12 12])
title('Soma de cossenos no tempo')
xlabel('Hz')
ylabel('V')

subplot(423)
plot(t, s1)
xlim([0 1/500])
ylim([-6 6])
title('Cosseno no tempo 6V 1KHz')
xlabel('Hz')
ylabel('V')

subplot(425)
plot(t, s2)
xlim([0 1/500])
ylim([-2 2])
title('Cosseno no tempo 2V 3KHz')
xlabel('Hz')
ylabel('V')

subplot(427)
plot(t, s3)
xlim([0 1/500])
ylim([-4 4])
title('Cossenos no tempo 4V 5KHz')
xlabel('Hz')
ylabel('V')

subplot(422)
plot(f, abs(s_f1))
xlim([-6000 6000])
ylim([0 4])
title('Espectro de frequência do sinal')
xlabel('Hz')
ylabel('V')

subplot(424)
plot(f, abs(s1_f1))
title('Cosseno na frequência 6V 1KHz')
xlim([-6000 6000])
ylim([0 4])
xlabel('Hz')
ylabel('V')

subplot(426)
plot(f, abs(s2_f1))
title('Cosseno na frequência 2V 3KHz')
xlim([-6000 6000])
ylim([0 4])
xlabel('Hz')
ylabel('V')

subplot(428)
plot(f, abs(s3_f1))
title('Cossenos na frequência 4V 5KHz')
xlim([-6000 6000])
ylim([0 4])
xlabel('Hz')
ylabel('V')








