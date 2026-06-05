function run_lorenz ( )

%*****************************************************************************80
%
%% lorenz_ode_test tests lorenz_ode.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    12 November 2020
%    5 June 2026 (Moreno Marzolla)
%
%  Author:
%
%    John Burkardt

%
%  Data
%
  [ beta, rho, sigma, t0, y0 ] = lorenz_parameters ( );

  f = @ lorenz_deriv;
  tspan = [ t0, t0+40.0 ];
%
%  Compute the approximate solution at equally spaced times.
%
  [ t1, y1 ] = ode23 ( f, tspan, y0 );
  y0(1) += 1e-4;
  [ t2, y2 ] = ode23 ( f, tspan, y0 );

%
%  Plot the data.
%
  clf ( );
  set(0, "defaultlinelinewidth", 1);
  subplot(3, 1, 1);
  plot( t1, y1(:,1), "b" );
  ylabel("x(t)");
  subplot(3, 1, 2);
  plot( t1, y1(:,2), "b" );
  ylabel("y(t)");
  subplot(3, 1, 3);
  plot( t1, y1(:,3), "b" );
  ylabel("z(t)");
  print ( '-dpng', "-r300", "lorenz_system.png" );

  clf ( );
  set(0, "defaultlinelinewidth", 1);
  subplot(3, 1, 1);
  plot( t2, y2(:,1), "r", t1, y1(:,1), "b" );
  ylabel("x(t)");
  subplot(3, 1, 2);
  plot( t2, y2(:,2), "r", t1, y1(:,2), "b" );
  ylabel("y(t)");
  subplot(3, 1, 3);
  plot( t2, y2(:,3), "r", t1, y1(:,3), "b" );
  ylabel("z(t)");
  print ( '-dpng', "-r300", "lorenz_system_chaos.png" );

  clf();
  set(0, "defaultlinelinewidth", 1);
  plot3(y1(:,1), y1(:,2), y1(:,3), "b");
  xlabel("x(t)");
  ylabel("y(t)");
  zlabel("z(t)");
  grid on;
  %pause();
  print("-dpng" , "-r300", "lorenz_system_3D.png");

  return
end
