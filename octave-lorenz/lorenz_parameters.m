function [ beta, rho, sigma, t0, y0 ] = lorenz_parameters ( )

%*****************************************************************************80
%
%% lorenz_parameters returns parameters for the lorenz ODE.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    13 November 2020
%
%  Author:
%
%    John Burkardt
%
%  Output:
%
%    real BETA, RHO, SIGMA: problem parameters.
%
%    real T0: the initial time.
%
%    real Y0(3): the initial condition at time T0.
%
  beta = 8.0 / 3.0;
  rho = 28.0;
  sigma = 10.0;

  t0 = 0.0;
  y0 = [ 8.0, 1.0, 1.0 ];

  return
end

