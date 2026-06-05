#----------------------- RK4 Function ------------------------------------
function [t, theta1, theta2, omega1, omega2] = RK4(t, dt, g, m1, m2, L1, L2, theta1, theta2, omega1, omega2)
     
   k1theta1_dot = dt*calc_theta1_dot(g, t, theta1, theta2, omega1, omega2, m1, m2, L1, L2);
   k1theta2_dot = dt*calc_theta2_dot(g, t, theta1, theta2, omega1, omega2, m1, m2, L1, L2);
   k1omega1_dot = dt*calc_omega1_dot(g, t, theta1, theta2, omega1, omega2, m1, m2, L1, L2);
   k1omega2_dot = dt*calc_omega2_dot(g, t, theta1, theta2, omega1, omega2, m1, m2, L1, L2);
   
   k2theta1_dot = dt*calc_theta1_dot(g, t+.5*dt, theta1+.5*k1theta1_dot, theta2+.5*k1theta2_dot, omega1+.5*k1omega1_dot, omega2+.5*k1omega2_dot, m1, m2, L1, L2);
   k2theta2_dot = dt*calc_theta2_dot(g, t+.5*dt, theta1+.5*k1theta1_dot, theta2+.5*k1theta2_dot, omega1+.5*k1omega1_dot, omega2+.5*k1omega2_dot, m1, m2, L1, L2);
   k2omega1_dot = dt*calc_omega1_dot(g, t+.5*dt, theta1+.5*k1theta1_dot, theta2+.5*k1theta2_dot, omega1+.5*k1omega1_dot, omega2+.5*k1omega2_dot, m1, m2, L1, L2);
   k2omega2_dot = dt*calc_omega2_dot(g, t+.5*dt, theta1+.5*k1theta1_dot, theta2+.5*k1theta2_dot, omega1+.5*k1omega1_dot, omega2+.5*k1omega2_dot, m1, m2, L1, L2);
   
   k3theta1_dot = dt*calc_theta1_dot(g, t+.5*dt, theta1+.5*k2theta1_dot, theta2+.5*k2theta2_dot, omega1+.5*k2omega1_dot, omega2+.5*k2omega2_dot, m1, m2, L1, L2);
   k3theta2_dot = dt*calc_theta2_dot(g, t+.5*dt, theta1+.5*k2theta1_dot, theta2+.5*k2theta2_dot, omega1+.5*k2omega1_dot, omega2+.5*k2omega2_dot, m1, m2, L1, L2);
   k3omega1_dot = dt*calc_omega1_dot(g, t+.5*dt, theta1+.5*k2theta1_dot, theta2+.5*k2theta2_dot, omega1+.5*k2omega1_dot, omega2+.5*k2omega2_dot, m1, m2, L1, L2);
   k3omega2_dot = dt*calc_omega2_dot(g, t+.5*dt, theta1+.5*k2theta1_dot, theta2+.5*k2theta2_dot, omega1+.5*k2omega1_dot, omega2+.5*k2omega2_dot, m1, m2, L1, L2);
   
   k4theta1_dot = dt*calc_theta1_dot(g, t+dt, theta1+k3theta1_dot, theta2+k3theta2_dot, omega1+k3omega1_dot, omega2+k3omega2_dot, m1, m2, L1, L2);
   k4theta2_dot = dt*calc_theta2_dot(g, t+dt, theta1+k3theta1_dot, theta2+k3theta2_dot, omega1+k3omega1_dot, omega2+k3omega2_dot, m1, m2, L1, L2);
   k4omega1_dot = dt*calc_omega1_dot(g, t+dt, theta1+k3theta1_dot, theta2+k3theta2_dot, omega1+k3omega1_dot, omega2+k3omega2_dot, m1, m2, L1, L2);
   k4omega2_dot = dt*calc_omega2_dot(g, t+dt, theta1+k3theta1_dot, theta2+k3theta2_dot, omega1+k3omega1_dot, omega2+k3omega2_dot, m1, m2, L1, L2);

   t = t+dt;
   theta1 = theta1 + (k1theta1_dot + 2*k2theta1_dot + 2*k3theta1_dot + k4theta1_dot)/6;
   theta2 = theta2 + (k1theta2_dot + 2*k2theta2_dot + 2*k3theta2_dot + k4theta2_dot)/6;
   omega1 = omega1 + (k1omega1_dot + 2*k2omega1_dot + 2*k3omega1_dot + k4omega1_dot)/6;
   omega2 = omega2 + (k1omega2_dot + 2*k2omega2_dot + 2*k3omega2_dot + k4omega2_dot)/6;

endfunction
