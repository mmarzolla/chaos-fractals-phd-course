function dydt = lorenz_deriv ( t, y )

%*****************************************************************************80
%
%% lorenz_deriv evaluates the right hand side of the Lorenz ODE.
%
%  Discussion:
%
%    The values of parameters sigma, rho and beta correspond to those used by
%    Lorenz in his original report.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    12 November 2020
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    real T: the value of the independent variable.
%
%    real Y(M): the values of the dependent variables at time T.
%
%  Output:
%
%    real DYDT(M): the right hand side of the ODE.
%
  [ beta, rho, sigma, t0, y0 ] = lorenz_parameters ( );

  dy1dt = sigma * ( y(2) - y(1) );
  dy2dt = y(1) * ( rho - y(3) ) - y(2);
  dy3dt = y(1) * y(2) - beta * y(3);

  dydt = [ dy1dt; dy2dt; dy3dt ];

  return
end

