%% Vehicle params

param.width = 0.606; % [m]
param.sprocket_radius = 0.0856; % [m]
param.gearbox_ratio = 34.35;
param.long_slip_fit_coeff.inner  = [-0.0591   -0.2988];
param.long_slip_fit_coeff.outer = [0.0390    0.2499 ];

% only one of these should be used depending on the objective 
param.side_slip_exp_fit_coeff = [-0.5790   -7.0000   -0.0763];
param.side_slip_poly_fit_coeff = [ -0.1024, -0.0030];
param.side_slip_const = deg2rad(10.0);
param.alpha0 = 0.1745;


param.locked_wheel_coeff = [ 0.0006    0.0539];
param.slip_fit_coeff.min_value = -1;
param.enable_noise = false;
param.pose_fbk.mean = [0.0,0.0,0.0];
param.pose_fbk.var  = [0.001,0.001,deg2rad(0.5)].^2; % set as standard deviation

%% Simulation params
sim_param.dt = 0.001; % [s]
sim_param.initial_state = [-0.1, 0.0, deg2rad(0)]; % [m,m,rad]
sim_param.decimation = 10;
sim_param.motor_tau = 0.2; %[s] low pass filter 1/(tau*s+1)
% 
% v     = vm*t + vq;
% Omega = am*t + aq;


path_param.time_vec = [0,2,4];
path_param.linear_velocity.q  = [0.1,0.1,0.1]; % offset
path_param.linear_velocity.m  = [0,0,0]; %slope
path_param.angular_velocity.q = [0.1,-0.1,0.1];% offset
path_param.angular_velocity.m = [0,0,0];%slope

sim_param.t_end   = max(path_param.time_vec); % [s]
%% trajectory generation
path_param.init_pose = [0.0, 0.0, 0.0]; % [m,m,rad]
path_param.dt = 0.001; % [s]

%derivative %filters
param.tau_der = 0.01; % time constant of derivative filter
z = tf('z',sim_param.dt);
Gd2_be = (z-1)/(z*(sim_param.dt+param.tau_der)- param.tau_der);
[param.num_filt_be, param.den_filt_be] = tfdata(Gd2_be,'v');


%% Control law
ctrl_param.controller_type = 1; %'1: luigi'
ctrl_param.K_theta = 5;
ctrl_param.Kp = 10;%0.1;

% ctrl_param.controller_type = 2; %'2:kanayama'
% ctrl_param.K_theta = 5;
% ctrl_param.Kx = 10;%0.1;

if ~exist('model_unicycle','var')
    model_unicycle = 0;
end

