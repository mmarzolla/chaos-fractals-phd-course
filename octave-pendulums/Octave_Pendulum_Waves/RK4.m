#----------------------- RK4 Function ------------------------------------
function [t, theta, omega] = RK4(t, dt, g, m, L, theta, omega)
     
   k1theta_dot = dt*calc_theta_dot(g, t, theta, omega, m, L);
   k1omega_dot = dt*calc_omega_dot(g, t, theta, omega, m, L);
   
   k2theta_dot = dt*calc_theta_dot(g, t+.5*dt, theta+.5*k1theta_dot, omega+.5*k1omega_dot, m, L);
   k2omega_dot = dt*calc_omega_dot(g, t+.5*dt, theta+.5*k1theta_dot, omega+.5*k1omega_dot, m, L);
   
   k3theta_dot = dt*calc_theta_dot(g, t+.5*dt, theta+.5*k2theta_dot, omega+.5*k2omega_dot, m, L);   
   k3omega_dot = dt*calc_omega_dot(g, t+.5*dt, theta+.5*k2theta_dot, omega+.5*k2omega_dot, m, L);
   
   k4theta_dot = dt*calc_theta_dot(g, t+dt, theta+k3theta_dot, omega+k3omega_dot, m, L);   
   k4omega_dot = dt*calc_omega_dot(g, t+dt, theta+k3theta_dot, omega+k3omega_dot, m, L);

   t = t+dt;
   theta = theta + (k1theta_dot + 2*k2theta_dot + 2*k3theta_dot + k4theta_dot)/6;
   omega = omega + (k1omega_dot + 2*k2omega_dot + 2*k3omega_dot + k4omega_dot)/6;
   
endfunction
