T_s = 0.001;
tau_v = 4e-3/4;                             % speed IIR filter time constant [s]
beta_v = T_s/(T_s+tau_v);                   % speed IIR filter parameter
tau_der = 0.01
N_e = 12; %bits



% design derivative filter

z = tf('z',T_s)
G = tf([1 0], [tau_der 1]);
Gd = c2d(G, T_s, 'tustin')
[num_filt_tu, den_filt_tu] = tfdata(Gd,'v')
Gd2 = 2* (z-1)/(z*(T_s+2*tau_der) +(T_s - 2*tau_der))
minreal(zpk(Gd)*zpk(1/Gd2)) %sanity check should be 1

z = tf('z',T_s)
%forward euler (is not zoh of c2d!!!)
Gd2_fe = (z-1)/(z*(tau_der)+ T_s -tau_der)
[num_filt_fe, den_filt_fe] = tfdata(Gd2_fe,'v')

%backward euler
Gd2_be = (z-1)/(z*(T_s+tau_der)- tau_der)
[num_filt_be, den_filt_be] = tfdata(Gd2_be,'v')