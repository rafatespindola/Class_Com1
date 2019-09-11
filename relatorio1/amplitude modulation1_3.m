% 1. Gerar um vetor representando um ruído com distribuição
% normal utilizando a função 'randn' do matlab. Gere 1 segundo
% de ruído considerando um tempo de amostragem de 1/10k.

% 2. Plotar o histograma do ruído para observar a distribuição
% Gaussiana. Utilizar a função 'histogram'

% 3. Plotar o ruído no domínio do tempo e da frequência

% 4. Utilizando a função 'xcorr', plote a função de autocorrelação
% do ruído.

% 5. Utilizando a função 'filtro=fir1(50,(1000*2)/fs)', realize uma
% operação de filtragem passa baixa do ruído. Para visualizar a
% resposta em frequência do filtro projetado, utilize a função
% 'freqz'.

% 6. Plote, no domínio do tempo e da frequência, a saída do filtro
% e o histograma do sinal filtrado

% Aluno: Rafael Teles Espindola
% Exercicio referente ao terceiro slide

close all
clear all
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%% Ruído %%%%%%%%%%%%%%%%%%%%%%%%%%%%
fs = 10e3;
t = 0:1/fs:1-(1/fs);
f = -0.5*fs:0.5*fs-(1/fs);
noise = randn(1, fs);

figure(1)
hist(noise, 100)

%%%%%%%%%%%%%%%%%%%%%%%%%%% No tempo %%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2)
subplot(121)
plot(t, noise)
title('Ruído no domínio do tempo')
xlabel('tempo (s)')

%%%%%%%%%%%%%%%%%%%%%%%% Na frequência %%%%%%%%%%%%%%%%%%%%%%%%
noise_f = fftshift(fft(noise)/length(noise));
subplot(122)
plot(f, abs(noise_f))
xlabel('frequencia (Hz)')
title('Ruído no domínio da frequência')

%%%%%%%%%%%%%%%%%%%%%%% Autocorrelação %%%%%%%%%%%%%%%%%%%%%%%%
figure(10)
plot(xcorr(noise));


%%%%%%%%%%%%%%%%%%%%%%%%%% Filtragem %%%%%%%%%%%%%%%%%%%%%%%%%%
filtro_pb = fir1(50,(1000*2)/fs);
filtrado = filter(filtro_pb, 1, noise);

figure(4)
freqz(filtrado)

%%%%%%%%%%%%%%%%%%%%% Filtragem no tempo %%%%%%%%%%%%%%%%%%%%%%

figure(5)
plot(t, filtrado)
title('Sinal filtrado no tempo')

%%%%%%%%%%%%%%%%%%%%% Filtragem na freq %%%%%%%%%%%%%%%%%%%%%%%
figure(6)
filtrado_f = (fftshift(fft(filtrado)));
plot(f, abs(filtrado_f))
title('Sinal filtrado na frequência')


figure(7)
hist(filtrado, 100)
title('Histograma')







