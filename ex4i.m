pkg load control

num = [4]; den = [1 6 11 6];
T = 0.1;
G = tf(num, den);

Gz = c2d(G, T, 'zoh');

rlocus(G);

Kcr = 32;
sys_osc = feedback(Kcr*G, 1);
step(sys_osc);

Tcr = 2.5;

Kp = 0.6 * Kcr;
Ti = 0.5 * Tcr;;
Td = 0.125 * Tcr;

%Analógico
s = tf('s');
Gc = Kp * (1 + (1/(Ti * s)) + (Td * s));
sys_cl = feedback(Gc * G, 1);


Kd = Kp * Td / T;
Ki = Kp * T / Ti;
Kpi = Kp / (1 - T / (2 * Ti));


%Digital
z = tf('z', T);
Gcz = Kpi + Ki * T * z / (z - 1) + Kd * (z - 1) / (T * z);
sys_clz = feedback(Gcz * Gz, 1);


t = 0:T:10;
figure;
step(sys_cl, sys_clz, t);
legend("Contínuo", "Discreto");
title("Resposta ao degrau");
xlabel("Tempo (s)");
ylabel("Saída");
grid on;

