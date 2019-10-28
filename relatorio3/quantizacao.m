

%    Aluno: Rafael Teles Espindola
%    Relatório 3
%    Laboratório PCM

%    • Capturar um sinal de áudio utilizando as ferramentas do
%      toolbox 'Data Acquisition'. Utilizar o matlab no windows.
%    • Realizar um processo de quantização uniforme do sinal (3, 5,
%      8 e 13 bits)
%    • Diponibilizar o sinal na placa de som do micro e observar os
%      efeitos da quantização

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all; close all; clc               
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

som    = audioread('slap.wav')';          % Som groove de baixo
fa     = 44100;                           % Frequencia de amostragem
tf     = (length(som)/fa)-1/fa;           % Tempo final
t      = [0:1/fa:tf];                     % Tempo
ta     = 1/fa;                            % Período de amostragem 


for k = [3 5 8 13 32]                     % Número de bits do_quantizador/por_amostra

    l            = 2^k;                   % Número de níveis de quantização
    somUp        = som+(min(som)*-1);     % Vetor som com os valores passados para cima do zero
    fator_estica = (l-1)/max(somUp);      % Número que eu multiplico para o máximo do som ir até meu máximo nível
    esticado     = somUp.*fator_estica;   % Meu som esticado até o limite do meu maior nível
    conv_de      = round(esticado);       % Arredonda os valores para inteiros
    quantizado   = conv_de./fator_estica; % Voltando para valores menores, mas ainda positivos
    som_final    = quantizado+(min(som)); % Voltando para valores positivos e negativos
    sound(som_final, 44100)               % Testando
    pause(1)
    
end





