
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
        plot(t(1, 1:8*N), sinal_1(1, 1:8*N), 'LineWidth', 2)
        title('8 primeiros bits no sinal1 de tempo')
        ylabel('Volts')
        xlabel('Segundos')
        
    subplot(322)
        plot(t(1, 1:8*N), sinal_2(1, 1:8*N), 'LineWidth', 2)
        title('8 primeiros bits no sinal2 de tempo')
        ylabel('Volts')
        xlabel('Segundos')    
        
    subplot(323)
        plot(t(1, 1:8*N), info_rx1(1, 1:8*N), 'LineWidth', 2)
        title('Sinal recebido em Rx1 (8 bits)')
        
    subplot(324)
        plot(t(1, 1:8*N), info_rx2(1, 1:8*N), 'LineWidth', 2)
        title('Sinal recebido em Rx2 (8 bits)')
   
    subplot(3,2,[5 6])
        semilogy(0:15, taxa_erro1, 'LineWidth', 2)
        title('Probabilidade1 de erro de bit (Pb) vs. SNR')
        xlim([0 15])
        ylim([0.2 0.5])
        xlabel('SNR')
        ylabel('Pb')
        hold on
        semilogy(0:15, taxa_erro2, 'LineWidth', 2)
        title('Probabilidade2 de erro de bit (Pb) vs. SNR')
        xlim([0 15])
        ylim([0.2 0.5])
        xlabel('SNR')
        ylabel('Pb')
        
        legend('1V', '2V', 'Location','southwest')
        legend('boxoff') 
        
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   

% 2. 
 
N         = 50;                              % Cada bit/simbolo possui N amostras
A         = 1;                               % Amplitude do sinal em volts
limiar    = A/2;                             % Acima disso é 1. Abaixo é 0
bits      = 100000;                          % Número de bits na informação
Rb        = 1e4;                             % Taxa de transmissão

info_bin  = randi([0 1],1,bits);             % Sequência de informação
t         = 0:1/(Rb*N):(bits/Rb)-(1/(Rb*N)); % Tempo 10s

info_up   = upsample(info_bin, N);           % Sequência pronta para filtragem
filtro_tx = ones(1,N);                       % Preparando filtro Tx
filtro_rx = fliplr(filtro_tx);               % Preparando filtro Rx
info_tx   = filter(filtro_tx, 1, info_up);   % Info filtrada 
sinal     = info_tx*A;                       % Sinal ajustado sua amplitude



for SNR = 0:15
    
    info_rx          = awgn(sinal, SNR-10*(log10(N)));                 % Info não casada
    info_rx_casada   = filter(filtro_rx, 1, info_rx)/N;                % Info casada

    info_hat         = info_rx(N:N:end) > limiar;                      % Informação binária não casada
    info_hat_casada  = info_rx_casada(N:N:end) > limiar;               % Informação binária casada
    
    num_erro(SNR+1)  = sum(xor(info_bin, info_hat));                   % Número de erro não casada   
    taxa_erro(SNR+1) = num_erro(SNR+1)/length(info_bin);               % Probabilidade de erro não casada
   
    num_erro_casada(SNR+1)  = sum(xor(info_bin, info_hat_casada));     % Número de erro casada   
    taxa_erro_casada(SNR+1) = num_erro_casada(SNR+1)/length(info_bin); % Probabilidade de erro casada
    
end

figure(2)
    subplot(3,2,[1 2])
        plot(t(1, 1:8*N), sinal(1, 1:8*N), 'LineWidth', 2)
        title('8 primeiros bits no sinal de tempo')
        ylabel('Volts')
        xlabel('Segundos')
                
    subplot(323)
        plot(t(1, 1:8*N), info_rx(1, 1:8*N), 'LineWidth', 2)
        title('Sinal Rx não casada (8 bits)')
        
    subplot(324)
        plot(t(1, 1:8*N), info_rx_casada(1, 1:8*N), 'LineWidth', 2)
        title('Sinal Rx casada (8 bits)')
   
    subplot(3,2, [5 6])
        semilogy(0:15,taxa_erro, 'LineWidth', 2)
            xlim([0 15])
            xlabel('SNR')
            ylabel('Pb')
            hold on
        semilogy(0:15,taxa_erro_casada, 'LineWidth', 2)
            xlim([0 15])
            xlabel('SNR')
            ylabel('Pb')
            title('(Pb) vs. SNR')
        legend('Não casada', 'Casada', 'Location','southwest')
        legend('boxoff') 
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
% 3. e 4.   

N         = 50;                              % Cada bit/simbolo possui N amostras
A         = 1;                               % Amplitude do sinal em volts
limiar1   = 0.5;                             % Acima disso é 1. Abaixo é 0
limiar2   = 0;                               % Acima disso é 1. Abaixo é 0
bits      = 100000;                          % Número de bits na informação
Rb        = 1e4;                             % Taxa de transmissão
Bw        = Rb/2;                            % Banda

info_bin  = randi([0 1],1,bits);             % Sequência de informação
t         = 0:1/(Rb*N):(bits/Rb)-(1/(Rb*N)); % Tempo 10s

info_up   = upsample(info_bin, N);           % Sequência pronta para filtragem
filtro_tx = ones(1,N);                       % Preparando filtro Tx
filtro_rx = fliplr(filtro_tx);               % Preparando filtro Rx
info_tx   = filter(filtro_tx, 1, info_up);   % Info filtrada 
sinal_pol = info_tx*A;                       % Sinal polar ajustado a sua amplitude: 0 e 1
sinal_bip = info_tx*A*2-(A/2);               % Sinal bipolar ajustado a sua amplitude: -1 e 1 


for SNR = 0:15
    
    info_rx_pol          = awgn(sinal_pol, SNR-10*(log10(N)));    % Info recebida
    info_rx_pol_casada   = filter(filtro_rx, 1, info_rx_pol)/N;   % Info filtrada com filtro casado
    info_hat_pol         = info_rx_pol_casada(N:N:end) > limiar1; % Informação binária
    num_erro_pol(SNR+1)  = sum(xor(info_bin, info_hat_pol));      % Número de erro  
    taxa_erro_pol(SNR+1) = num_erro_pol(SNR+1)/length(info_bin);  % Probabilidade de erro
    ebno1                = (Bw/Rb)*10^(SNR/10);                   % Energia do bit teórica
    pb1(SNR+1)           = qfunc(sqrt(ebno1));                    % Probabilidade de erro teórica 
        
    info_rx_bip          = awgn(sinal_bip, SNR-10*(log10(N)));    % Info recebida
    info_rx_bip_casada   = filter(filtro_rx, 1, info_rx_bip)/N;   % Info filtrada com filtro casado
    info_hat_bip         = info_rx_bip_casada(N:N:end) > limiar2; % Informação binária
    num_erro_bip(SNR+1)  = sum(xor(info_bin, info_hat_bip));      % Número de erro  
    taxa_erro_bip(SNR+1) = num_erro_bip(SNR+1)/length(info_bin);  % Probabilidade de erro    
    ebno2                = (Bw/Rb)*10^(SNR/10);                   % Energia do bit teórica
    pb2(SNR+1)           = qfunc(sqrt(2*ebno2));                  % Probabilidade de erro teórica    
   
end


figure(3)
    subplot(521)
        plot(t(1, 1:8*N), sinal_pol(1, 1:8*N), 'LineWidth', 2)
        title('8 primeiros bits no sinal de tempo')
        ylabel('Volts')
        xlabel('Segundos')
                
    subplot(522)
        plot(t(1, 1:8*N), sinal_bip(1, 1:8*N), 'LineWidth', 2)
        title('8 primeiros bits no sinal de tempo')
        ylabel('Volts')
        xlabel('Segundos')                
                
    subplot(523)
        plot(t(1, 1:8*N), info_rx_pol(1, 1:8*N), 'LineWidth', 2)
        title('Sinal Rx Polar não casada (8 bits)')
        
    subplot(524)
        plot(t(1, 1:8*N), info_rx_bip(1, 1:8*N), 'LineWidth', 2)
        title('Sinal Rx Bipolar não casada (8 bits)')
   
    subplot(525)
        plot(t(1, 1:8*N), info_rx_pol_casada(1, 1:8*N), 'LineWidth', 2)
        title('Sinal Rx Polar casada (8 bits)')
        
    subplot(526)
        plot(t(1, 1:8*N), info_rx_bip_casada(1, 1:8*N), 'LineWidth', 2)
        title('Sinal Rx Bipolar casada (8 bits)')

    subplot(5,2, [7 10])
        semilogy(0:15,taxa_erro_pol, 'LineWidth', 2)
            xlim([0 15])
            xlabel('SNR')
            ylabel('Pb')
            hold on
        semilogy(0:15,taxa_erro_bip, 'LineWidth', 2)
            xlim([0 15])
            xlabel('SNR')
            ylabel('Pb')
            title('(Pb) vs. SNR')
        semilogy(0:15, pb1, 'LineWidth', 2)
            hold on
        semilogy(0:15, pb2, 'LineWidth', 2)
            legend('Polar', 'Bipolar', 'Teórico Polar', 'Teórico Bipolar', 'Location','southwest')
            legend('boxoff')     
   




