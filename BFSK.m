% IFSC - Instituto Federal de Santa Catarina
% Aluno: Rafael Teles Espindola
% Disciplina: Sistemas de comunicação 1
% Professor : Mário de Noronha Neto
%
%
% Laboratório sobre: BFSK com detecção não coerente
%
%              _____                                                               ________       
%             | MUX |                  --> Filtro PF -> Valor abs -> Filtro PB -> |        | 
% f1   ------>|     | onda = f1 ou f2 |                                           |Decisão |-> Info original  
% f2   ------>|     |-----------------|                                           |        |
% info ------>|sel  |                 |--> Filtro PF -> Valor abs -> Filtro PB -> |________|  
%             |_____|                    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; close all; clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f1    = 5e3;                    % Frequência da portadora       
f2    = 10e3;                   % Frequência da portadora    
bits  = 1000:                   % Número de bits da informação
info  = randi([0 1], 1, nBits); % Informação 
Rb    = 1000;                   % Taxa de transmissão por segundo
t     = 0:1/Rb:1;               % Tempo

onda_f1 = cos(2*pi*t*f1);       % Onda f1 no tempo
onda_f2 = cos(2*PI*t*f2);       % Onda f2 no tempo









