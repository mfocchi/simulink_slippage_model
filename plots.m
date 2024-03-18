clear all;close all;
% load params
multiplot = true; %
tracked_robot_param

path_param.time_vec = [0,5,10];
sim_param.t_end   = max(path_param.time_vec); % [s]
path_param.linear_velocity.q  = [0.1,0.1,0.1]; % offset
path_param.linear_velocity.m  = [0,0,0]; %slope
path_param.angular_velocity.q = [0.1,1,0.1];% punt mootonic increase in omega, otherwise we have unconvergence due to the zero crossing

slip_compensation = 0;
out_unicycle = sim('tracked_robot.slx');
slip_compensation = 1;
out_side_slip = sim('tracked_robot.slx');


figure
subplot(4,1,1);
plot(out_unicycle.x_des.Time, squeeze(out_unicycle.x_des.Data(1,1,:)),'r','linewidth',3); hold on; grid on;
plot(out_unicycle.x.Time, out_unicycle.x.Data(:,1),'k','linewidth',2);hold on; grid on;
plot(out_side_slip.x.Time, out_side_slip.x.Data(:,1),'b','linewidth',2);
ylabel('X');
legend({'ref','no slip comp', 'slip comp'});

subplot(4,1,2)
plot(out_unicycle.x_des.Time, squeeze(out_unicycle.x_des.Data(1,2,:)),'r','linewidth',3); hold on; grid on;
plot(out_unicycle.x.Time, out_unicycle.x.Data(:,2),'k','linewidth',2);hold on; grid on;
plot(out_side_slip.x.Time, out_side_slip.x.Data(:,2),'b','linewidth',2);
ylabel('Y');

subplot(4,1,3)
plot(out_unicycle.x_des.Time, squeeze(out_unicycle.x_des.Data(1,3,:)),'r','linewidth',3); hold on; grid on;
plot(out_unicycle.x.Time, out_unicycle.x.Data(:,3),'k','linewidth',2);hold on; grid on;
plot(out_side_slip.x.Time, out_side_slip.x.Data(:,3),'b','linewidth',2);
ylabel('Z');

subplot(4,1,4)
plot(out_side_slip.x.Time, rad2deg(out_side_slip.alpha.Data),'r','linewidth',3); hold on; grid on;
ylabel('alpha [deg]');

