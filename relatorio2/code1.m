% Aluno: Rafael Teles Espindola

% Ex. 1:
% • Realizar um processo de modulação AM DSB e AM DSB-SC
% • Para o caso da modulação AM DSB-SC, realizar o processo
% de demodulação utilizando a função 'fir1'
% • Para o caso da modulaçao AM DSB, variar o 'fator de
% modulação' (0.25; 0.5; 0.75 e 1 e 1.5) e observar os efeitos no
% sinal modulado

close all
clear all
clc

fs = 90e3;
t  = 0:1/fs:1-(1/fs);

Am1 = 1; f1 = 440;  Ao1 = 1;                % Parametros AM DSB
Am2 = 1; f2 = 770;  Ao2 = 0;                % Parametros AM DSB-SC
Am3 = 1; f3 = 10e3; Ao3 = 0;                % Parametros Portadora1
Am4 = 1; f4 = 15e3; Ao4 = 0;                % Parametros Portadora2

som1 = Ao1 + Am1*cos(2*pi*f1*t);            % AM DSB
som2 = Ao2 + Am2*cos(2*pi*f2*t);            % AM DSB-SC
por1 = Ao3 + Am3*cos(2*pi*f3*t);            % Portadora 1
por2 = Ao4 + Am4*cos(2*pi*f4*t);            % Portadora 2

y1 = por1.*som1;                            % Sinal modulado1 AM DSB
y2 = por2.*som2;                            % Sinal modulado2 AM DSB-SC

y2_demod  = por2.*y2;                       % Sinal demodulado1 AM DSB
filtro_pb = fir1(500,(1000*2)/fs);          % filtro fir1
filtrado  = filter(filtro_pb, 1, y2_demod); % Sinal filtrado AM DSB


s_t025 = Am3*(1 + 0.25*cos(2*pi*f1*t)).*cos(2*pi*f3*t); 
s_t050 = Am3*(1 + 0.50*cos(2*pi*f1*t)).*cos(2*pi*f3*t);
s_t075 = Am3*(1 + 0.75*cos(2*pi*f1*t)).*cos(2*pi*f3*t);
s_t100 = Am3*(1 + 1.00*cos(2*pi*f1*t)).*cos(2*pi*f3*t);
s_t125 = Am3*(1 + 1.25*cos(2*pi*f1*t)).*cos(2*pi*f3*t);
s_t150 = Am3*(1 + 1.50*cos(2*pi*f1*t)).*cos(2*pi*f3*t);


figure(1)
subplot(211)
plot(t, y1)
hold on
plot(t, som1)
xlim([0 2*(1/f1)])
xlabel("Tempo (s)")
ylabel("Amplitude")
title("AM DSB - m(t) 440 Hz * c(t) 10KHz")

subplot(212)
plot(t, y2)
hold on
plot(t, som2)
xlim([0 2*(1/f2)])
xlabel("Tempo (s)")
ylabel("Amplitude")
title("AM DSB-SC - m(t) 770 Hz * c(t) 15KHz")

figure(2)
freqz(filtrado)

figure(3)
plot(t, filtrado)
xlim([0 10*(1/f1)])
title('Sinal filtrado no tempo')

figure(4)
subplot(511)
plot(t, s_t025)
xlim([0 10*(1/f1)])
title("Fator modulante de 0.25")

subplot(512)
plot(t, s_t050)
xlim([0 10*(1/f1)])
title("Fator modulante de 0.50")

subplot(513)
plot(t, s_t075)
xlim([0 10*(1/f1)])
title("Fator modulante de 0.75")

subplot(514)
plot(t, s_t100)
xlim([0 10*(1/f1)])
title("Fator modulante de 1.00")

subplot(515)
plot(t, s_t125)
xlim([0 10*(1/f1)])
title("Fator modulante de 1.25")

subplot(516)
plot(t, s_t150)
xlim([0 10*(1/f1)])
title("Fator modulante de 1.50")
