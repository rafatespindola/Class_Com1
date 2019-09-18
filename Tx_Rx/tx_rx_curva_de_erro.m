%% Continuando hoje 18/09 aula do dia 16/09 >> Mexendo com o SNR, e fazendo gráfico dele

clear all
close all
clc

% Formatando em mais de 2 níveis
% Voltamos pra 2 níveis pra fazer o comparador lá no final.

N = 100;
M = 2;  % Número de níveis
A = 1; % Amplitude máxima
dist_nivel = 2; %Distancia entre níveis
%SNR = 0;
% Número de bits por nível
l = log2(M);

limiar = 0;
SNR_min = 0;
SNR_max = 15;
SNR_vec = [SNR_min:SNR_max];
% Gerando número de símbolos:
num_simb = 1000000;

% Informação de entrada
info_bin = randi([0 1], 1, num_simb*l);
% Fazendo o reshape para o bi2de
info_bin = transpose(reshape(info_bin, l , num_simb));

% Transformando em decimal à cada 2 bits:
info = bi2de(info_bin, 'left-msb')*dist_nivel-A;%----- Mapeamento: 00 --> 0 --> -3
info_up = upsample(info,N);                 %             01 --> 1 --> -1
                                            %             10 --> 2 -->  2
                                            %             11 --> 3 -->  3
% Filtrando
filtro = ones(1, N);
info_tx = filter(filtro, 1, info_up);

% Gerando o sinal de saída com ruído:
vari = 2;
mean = 0;                                                        %outramaneira: Não utilizar vari, utiliza AWGN, relação sinal ruído                                                                          
%ruido = sqrt(vari)*rand(length(info_tx), 1)+mean;       %SNR = 10; (dB)
for SNR = SNR_min:SNR_max
    info_rx = awgn(info_tx,SNR, 'measured'); % sinal já implementando o ruído
    %info_rx = info_tx + ruido;
    info_hat = info_rx(N/2:N:end) > limiar; % Pega amostragens e compara com o limiar
    num_erro(SNR+1) = sum(xor(info_bin, info_hat)); % Verifica os erros na recepção
    taxa_erro(SNR+1) = num_erro(SNR+1)/length(info_bin);
end

semilogy(SNR_vec, taxa_erro);
% plotando

% subplot(2,1,1);
% plot(info_tx)
% xlim([0 20*N])
% ylim([-4 4])
% title('Sinal');
%
% subplot(2,1,2);
% plot(info_rx)
% xlim([0 20*N])
% ylim([-5 5])
% title('Sinal com ruído');


info_hat = transpose(info_hat); % de coluna para linha
info_bin = transpose(info_bin);



figure(2);
plot(info_hat);
%xlim([0 50]);
ylim([-0.3 1.3]);
