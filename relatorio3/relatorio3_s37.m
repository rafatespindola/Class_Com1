

%    Aluno: Rafael Teles Espindola
%    Relatório 3
%    Laboratório Transmissão binária e análise de desempenho de erro
%    Parte 1

%    • Simular uma transmissão binária com os seguintes
%      parâmetros:
%        • Sequência de informação [0 1 1 0 1 0 1 1 0 1 0];
%        • Sinalização NRZ unipolar com nível de amplitude de 1V;
%        • Canal AWGN com SNR = 10 dB;
%        • Recepção com e sem filtro casado (implementar as duas
%          soluções)
%    • Apresentar os gráficos de todos os estágios da transmissão,
%      comentar e concluir os resultados;

% Unipolar:
% Info:[0 1 1 0 1 0 1 1 0 1 0]  
%  1_ |   ___   _   ___   _           
%  0_ | _|   |_| |_|   |_| |_             
% -1_ |

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pkg load signal           % upsample
pkg load communications   % awgn
close all; close all; clc               
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

A         = 1;                             % Amplitude do sinal em volts
N         = 10;                            % Cada bit possui N amostras 
limiar    = A/2;                           % Acima disso é 1. Abaixo é 0
info_bin  = [0 1 1 0 1 0 1 1 0 1 0];       % Sequência de informação
info_up   = upsample(info_bin, N);         % Sequência pronta para filtragem

filtro_tx = ones(1,N);                     % Preparando filtro
filtro_rx = fliplr(filtro_tx);             % Preparando filtro

info_tx   = filter(filtro_tx, 1, info_up); % Info filtrada/formatada pronta para enviar

info_rx        = awgn(info_tx,10);                 % Info que chega ao Rx passou por um canal awgn
info_rx_filter = filter(filtro_rx, 1, info_rx)/N;  % Info recebida filtrada com o filtro casado

info_hat_casada     = info_rx_filter(N:N:end) > limiar; % Infomação binária casada
info_hat_nao_casada = info_rx(N:N:end) > limiar;        % Informação binária não casada

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t = 0:1/(length(info_bin)*N):1-(1/(length(info_bin)*N));

figure(1)
    subplot(311)
        plot(t, info_tx, 'LineWidth', 2)
        ylim([-0.1*A 1.1*A])
        title('Info original saindo de Tx')
        
    subplot(312)
        plot(t, info_rx, 'LineWidth', 2)
        title('Info Rx não filtrada com filtro casado')
        
    subplot(313)
        plot(t, info_rx_filter, 'LineWidth', 2)
        title('Info Rx filtrada com filtro casado')



        
        
        
        
        
