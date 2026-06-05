# d omega1
# -------- Function is defined here
#    dt

function [omega_dot] = calc_omega_dot(g, t, theta, omega, m, L)
	  omega_dot = -g/L * sin(theta);
endfunction