%% Laboratório: Transmissão binária e análise de desempenho de erro
%  Simular uma transmissão binária com os seguintes parâmetros:
%  • Sequência de informação [0 1 1 0 1 0 1 1 0 1 0];
%  • Sinalização unipolar com nível de amplitude de 1V;
%  • Canal AWGN com SNR = 10 dB;
%  • Recepção com e sem filtro casado (implementar as duas
%  soluções)
%  • Apresentar os gráficos de todos os estágios da transmissão,
%  comentar e concluir os resultados;

% Unipolar:
% Info:[0 1 1 0 1 0 1 1 0 1 0]  
%  1_ |   ___   _   ___   _           
%  0_ | _|   |_| |_|   |_| |_             
% -1_ |


close all
clc

%% Parâmetros
info = [0 1 1 0 1 0 1 1 0 1 0];
N    = 10;                        % Numero de amostras por símbolo
Rb   = 11;                        % Taxa de transmissão
t    = 0:(1/Rb*N):size(info)*N-(1/Rb*N);             

%% Filtro 
filtro_tx = ones(1, N); % TX
filtro_rx = fliplr(filtro_tx);% RX
















