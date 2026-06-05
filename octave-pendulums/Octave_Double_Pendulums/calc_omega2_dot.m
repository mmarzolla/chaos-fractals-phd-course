# d omega2
# -------- Function is defined here
#    dt

function [omega2_dot] = calc_omega2_dot(g, t, theta1, theta2, omega1, omega2, m1, m2, L1, L2)
	  omega2_dot = (m2*L2*omega2^2*sin(theta1-theta2)*cos(theta1-theta2)+g*sin(theta1)*cos(theta1-theta2)*(m1+m2)+L1*omega1^2*sin(theta1-theta2)*(m1+m2)-g*sin(theta2)*(m1+m2)) ...
             /(L2*(m1+m2)-m2*L2*(cos(theta1-theta2))^2);
endfunction