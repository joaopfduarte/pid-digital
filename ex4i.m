pkg load control
num = [4]; den = [1 6 11 6];

G = tf(num, den);

rlocus(G);

Kcr = 32;
sys_osc = feedback(Kcr*G, 1);
step(sys_osc);

Tcr = 2.5;

Kp = 0.6 * Tcr;
Ti = 0.5 * Tcr;;
Td = 0.125 * Tcr;

s = tf('s');
Gc = Kp * (1 + (1/(Ti * s)) + (Td * s));

figure;
sys_cl = feedback(Gc * G, 1);
step(sys_cl);
title("Resposta ao degrau");
