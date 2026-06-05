# This converts the polar coordinates in terms Lengths and Thetas
# into cartesian coordinates in with x s and y s

function [x1, x2, y1, y2] = polar_to_cartesian (L1, L2, theta1, theta2)
  
  x1 =  L1*sin(theta1);
  x2 =  x1 + L2*sin(theta2);
  
  y1 = -L1*cos(theta1);
  y2 = y1 - L2*cos(theta2); 

endfunction
