# d omega1
# -------- Function is defined here
#    dt

function [omega1_dot] = calc_omega1_dot(g, t, theta1, theta2, omega1, omega2, m1, m2, L1, L2)
	  omega1_dot = (-m2*L1*omega1^2*sin(theta1-theta2)*cos(theta1-theta2)+g*m2*sin(theta2)*cos(theta1-theta2)-m2*L2*omega2^2*sin(theta1-theta2)-(m1+m2)*g*sin(theta1)) ...
                  /(L1*(m1+m2)-m2*L1*(cos(theta1-theta2))^2);
endfunction