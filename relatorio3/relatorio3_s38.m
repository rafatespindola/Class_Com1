
%    Aluno: Rafael Teles Espindola
%    Relatório 3
%    Transmissão binária e análise de desempenho de erro.
%    Parte 2

%    • Fazer simulação de desempenho de erro para comparar,
%      através de um gráfico de Probabilidade de erro de bit (Pb) vs.
%      SNR, os seguintes sistemas:
%          1. Transmissão utilizando sinalização NRZ unipolar com
%             amplitude de 1V e 2V, ambos sem a utilização de filtro casado;
%          2. Transmissão utilizando sinalização NRZ unipolar com
%             amplitude de 1V, com e sem filtro casado;
%          3. Transmissão utilizando sinalização NRZ unipolar e bipolar,
%             ambos com a utilização de filtro casado;
%          4. Plote as expressões teóricas de Pb das sinalizações Polar e
%             Bipolar (eq. 3.73 e 3.76) e compare-as com os resultados da
%             simulação do item 3. Observe que as simulações anteriores
%             estão em função de SNR e as expressões em função de Eb/No!
%          5. Comentar e concluir todos os resultados

% Unipolar:
% Info:[0 1 1 0 1 0 1 1 0 1 0]  
%  1_ |   ___   _   ___   _           
%  0_ | _|   |_| |_|   |_| |_             
% -1_ |

% Bipolar:
% Info:[0 1 1 0 1 0 1 1 0 1 0]  
%         ___   _   ___   _       
%  1_ |  |   | | | |   | | |
%  0_ |--|---|-|-|-|---|-|-|- 
% -1_ | _|   |_| |_|   |_| |_ 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all; clear all; clc              
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 1. 
N         = 50;                             % Cada bit/simbolo possui N amostras
A1        = 1;                              % Amplitude do sinal em volts
A2        = 2;                              % Amplitude do sinal em volts 
limiar1   = A1/2;                           % Acima disso é 1. Abaixo é 0
limiar2   = A2/2;                           % Acima disso é 1. Abaixo é 0
bits      = 100000;                         % Número de bits na informação
Rb        = 1e4;                            % Taxa de transmissão

info_bin  = randi([0 1],1,bits);            % Sequência de informação
t         = 0:1/(Rb*N):(bits/Rb)-(1/(Rb*N));% Tempo 10s

info_up1  = upsample(info_bin, N);          % Sequência pronta para filtragem
info_up2  = upsample(info_bin, N);          % Sequência pronta para filtragem

filtro_tx = ones(1,N);                      % Preparando filtro

info_tx1  = filter(filtro_tx, 1, info_up1); % Info filtrada 
info_tx2  = filter(filtro_tx, 1, info_up2); % Info filtrada 

sinal_1   = info_tx1*A1;                    % Sinal ajustado sua amplitude
sinal_2   = info_tx2*A2;                    % Sinal ajustado sua amplitude


for SNR = 0:15
    
    info_rx1  = awgn(sinal_1, SNR-10*(log10(N)));           % Info que chega ao Rx passou por um canal awgn
    info_rx2  = awgn(sinal_2, SNR-10*(log10(N)));           % Info que chega ao Rx passou por um canal awgn
    
    info1_hat = info_rx1(N:N:end) > limiar1;                % Informação binária não casada
    info2_hat = info_rx2(N:N:end) > limiar2;                % Informação binária não casada    
    
    num_erro1(SNR+1)  = sum(xor(info_bin, info1_hat));     % Número de erro
    num_erro2(SNR+1)  = sum(xor(info_bin, info2_hat));     % Número de erro
    
    taxa_erro1(SNR+1) = num_erro1(SNR+1)/length(info_bin);  % Probabilidade de erro
    taxa_erro2(SNR+1) = num_erro2(SNR+1)/length(info_bin);  % Probabilidade de erro
    
end

figure(1)
    subplot(321)
        plot(t(1, 1:8*N), info_tx1(1, 1:8*N), 'LineWidth', 2)
        title('8 primeiros bits no sinal1 de tempo')
        ylabel('Volts')
        xlabel('Segundos')
        
    subplot(322)
        plot(t(1, 1:8*N), info_tx2(1, 1:8*N), 'LineWidth', 2)
        title('8 primeiros bits no sinal1 de tempo')
        ylabel('Volts')
        xlabel('Segundos')    
        
    subplot(323)
        plot(t(1, 1:8*N), info_rx1(1, 1:8*N), 'LineWidth', 2)
        title('Sinal recebido em Rx1 (Referente aos primeiros 8 bits)')
        
    subplot(324)
        plot(t(1, 1:8*N), info_rx2(1, 1:8*N), 'LineWidth', 2)
        title('Sinal recebido em Rx2 (Referente aos primeiros 8 bits)')
   
figure(11)
    semilogy(0:15,taxa_erro1)
    title('Probabilidade de erro de bit (Pb) vs. SNR')
    xlim([0 15])
    ylim([0.2 0.5])
    xlabel('SNR')
    ylabel('Pb')
    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   

%% 2. 
%A         = 1;                             % Amplitude do sinal em volts
%N         = 10;                            % Cada bit possui N amostras 
%limiar    = A/2;                           % Acima disso é 1. Abaixo é 0
%info_bin  = [0 1 0 1 1 0 0 1 1 0 1];       % Sequência de informação
%info_up   = upsample(info_bin, N);         % Sequência pronta para filtragem
%
%filtro_tx = ones(1,N);                     % Preparando filtro
%filtro_rx = fliplr(filtro_tx);             % Preparando filtro
%
%info_tx   = filter(filtro_tx, 1, info_up); % Info filtrada/formatada pronta para enviar
%
%info_rx        = awgn(info_tx,10);                % Info que chega ao Rx passou por um canal awgn
%info_rx_filter = filter(filtro_rx, 1, info_rx)/N; % Info recebida filtrada com o filtro casado
%
%info_hat_casada     = info_rx_filter(N:N:end) > limiar; % Infomação binária casada
%info_hat_nao_casada = info_rx(N:N:end) > limiar;        % Informação binária não casada
%
%
%t = 0:1/(length(info_bin)*N):1-(1/(length(info_bin)*N)); % Tempo para os plots
%
%figure(2)
%    subplot(311)
%        plot(t, info_tx, 'LineWidth', 2)
%        ylim([-0.1*A 1.1*A])
%        title('Info original saindo de Tx')
%        
%    subplot(312)
%        plot(t, info_rx, 'LineWidth', 2)
%        title('Info Rx não filtrada com filtro casado')
%        
%    subplot(313)
%        plot(t, info_rx_filter, 'LineWidth', 2)
%        title('Info Rx filtrada com filtro casado')
%    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    
%% 3.   
%A         = 1;                             % Amplitude do sinal em volts
%N         = 10;                            % Cada bit possui N amostras 
%limiar    = A/2;                           % Acima disso é 1. Abaixo é 0
%info_bin  = [0 1 0 1 1 0 0 1 1 0 1];       % Sequência de informação
%info_up   = upsample(info_bin, N);         % Sequência pronta para filtragem
%
%filtro_tx = ones(1,N);                     % Preparando filtro
%filtro_rx = fliplr(filtro_tx);             % Preparando filtro
%
%info_tx   = filter(filtro_tx, 1, info_up); % Info filtrada/formatada pronta para enviar
%
%info_rx         = awgn(info_tx,10);                 % Info que chega ao Rx passou por um canal awgn
%info_rx_filter  = filter(filtro_rx, 1, info_rx)/N;  % Info recebida filtrada com o filtro casado
%info_hat_casada = info_rx_filter(N:N:end) > limiar; % Infomação binária casada
%
%t = 0:1/(length(info_bin)*N):1-(1/(length(info_bin)*N)); % Tempo para os plots
%
%figure(3)
%    subplot(321)
%        plot(t, info_tx, 'LineWidth', 2)
%        ylim([-0.1*A 1.1*A])
%        title('Info original saindo de Tx')
%        ylabel('Volst')
%        xlabel('Segundos')
%        
%    subplot(323)
%        plot(t, info_rx, 'LineWidth', 2)
%        title('Info Rx chegando não filtrada')    
%        ylabel('Volst')
%        xlabel('Segundos')
%        
%    subplot(325)
%        plot(t, info_rx_filter, 'LineWidth', 2)
%        title('Info Rx filtrada com filtro casado')
%        ylabel('Volst')
%        xlabel('Segundos')
%        
%Ap        =  1;                            % Amplitude positiva do sinal
%An        = -1;                            % Amplitude negativa do sinal       
%N         = 10;                            % Cada bit possui N amostras 
%limiar    = (Ap+An)/2;                     % Acima disso é 1. Abaixo é 0
%info_bin  = [0 1 0 1 1 0 0 1 1 0 1];       % Sequência de informação
%info_amp  = (info_bin.*2)-1;               % Sequência tratada para seus valores bipolares
%info_up   = upsample(info_amp, N);         % Sequência pronta para filtragem
%
%filtro_tx = ones(1,N);                     % Preparando filtro
%filtro_rx = fliplr(filtro_tx);             % Preparando filtro
%
%info_tx   = filter(filtro_tx, 1, info_up); % Info filtrada/formatada pronta para enviar
%
%info_rx         = awgn(info_tx,10);                 % Info que chega ao Rx passou por um canal awgn
%info_rx_filter  = filter(filtro_rx, 1, info_rx)/N;  % Info recebida filtrada com o filtro casado
%info_hat_casada = info_rx_filter(N:N:end) > limiar; % Infomação binária casada
%
%t = 0:1/(length(info_bin)*N):1-(1/(length(info_bin)*N)); % Tempo para os plots
%
%    subplot(322)
%        plot(t, info_tx, 'LineWidth', 2)
%        ylim([1.1*An 1.1*Ap])
%        title('Info original saindo de Tx')
%        ylabel('Volst')
%        xlabel('Segundos')
%
%    subplot(324)
%        plot(t, info_rx, 'LineWidth', 2)
%        title('Info Rx chegando não filtrada')    
%        ylabel('Volst')
%        xlabel('Segundos')
%        
%    subplot(326)
%        plot(t, info_rx_filter, 'LineWidth', 2)
%        title('Info Rx filtrada com filtro casado')
%        ylabel('Volst')
%        xlabel('Segundos')    
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%% 4.
