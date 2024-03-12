clear all;close all;

tracked_robot_param

slip_compensation = 0;
out_unicycle = sim('tracked_robot.slx');
slip_compensation = 1;
out_side_slip = sim('tracked_robot.slx');


figure
subplot(3,1,1);
plot(out_unicycle.x_des.Time, squeeze(out_unicycle.x_des.Data(1,1,:)),'r','linewidth',3); hold on; grid on;
plot(out_unicycle.x.Time, out_unicycle.x.Data(:,1),'k','linewidth',3);
plot(out_side_slip.x.Time, out_side_slip.x.Data(:,1),'b','linewidth',3);
ylabel('X');

subplot(3,1,2)
plot(out_unicycle.x_des.Time, squeeze(out_unicycle.x_des.Data(1,2,:)),'r','linewidth',3); hold on; grid on;
plot(out_unicycle.x.Time, out_unicycle.x.Data(:,2),'k','linewidth',3);
plot(out_side_slip.x.Time, out_side_slip.x.Data(:,2),'b','linewidth',3);
ylabel('Y');

subplot(3,1,3)
plot(out_unicycle.x_des.Time, squeeze(out_unicycle.x_des.Data(1,3,:)),'r','linewidth',3); hold on; grid on;
plot(out_unicycle.x.Time, out_unicycle.x.Data(:,3),'k','linewidth',3);
plot(out_side_slip.x.Time, out_side_slip.x.Data(:,3),'b','linewidth',3);
ylabel('Z');

set_param('tracked_robot','InitFcn','tracked_robot_param');