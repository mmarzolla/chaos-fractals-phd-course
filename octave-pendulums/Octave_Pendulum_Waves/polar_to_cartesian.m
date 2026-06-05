# This converts the polar coordinates in terms Lengths and Thetas
# into cartesian coordinates in with x and y

function [x, y] = polar_to_cartesian (L, theta)
  
  x =  L*sin(theta);
  
  y = -L*cos(theta); 

endfunction
