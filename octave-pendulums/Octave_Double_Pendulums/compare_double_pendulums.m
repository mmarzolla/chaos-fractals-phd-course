clear variables
clear all
close all

#----------------------- Set-up options ------------------------------------
# Set number of pendulums
  n_pendulums = 10;

# Set times to analyze
       t_start = 0.00; # time inital conditions set to
         t_end = 20.00; # highest time calculated

  t_start_plot = t_start; # time to start the plots
    t_end_plot = t_end; # time to end the plots
       dt_plot = 0.01; # time-point differences for plots

  nt_plot = (t_end_plot-t_start_plot)/dt_plot; # number of timepoints to plot

# Set conditions for 1st pendulum
# -------------------------------
  dt(1) = .01;
  nt(1) = (t_end-t_start)/dt(1);

  m1(1) = 1;
  m2(1) = 1;

  L1(1) = 1.0;
  L2(1) = 1.0;

  g(1) = 9.80665;

  theta1_0(1) = pi/2;
  theta2_0(1) = 3*pi/4;

  omega1_0(1) = 0.0;
  omega2_0(1) = 0.0;

# Set conditions for subsequent pendulums
# ---------------------------------------
for j = 2:n_pendulums

  dt(j) = dt(1); # same dt as control
  nt(j) = (t_end-t_start)/dt(j); # calculate number of timepoints for this pendulum

  m1(j) = m1(1); # same m1 as control
  m2(j) = m2(1); # same m2 as control


  g(j) = g(1); # same g as conttol

  L1(j) = L1(1); # same L1 as control
  L2(j) = L2(1); # same L2 as control

  theta1_0(j) = theta1_0(j-1)+.0001; # increase theta1_0 by .0001 for each pendulum
  theta2_0(j) = theta2_0(j-1)+.0001; # increase theta2_0 by .0001 for each pendulum

  omega1_0(j) = omega1_0(1); # same as control
  omega2_0(j) = omega2_0(1); # same as control

endfor

# Set pendulum colors on a RGB scale
# ----------------------------------
for j = 1:n_pendulums # loop for each pendulum
  red(j) = rand(1); # random number between 0 & 1
  green(j) = rand(1);
  blue(j) = rand(1);
endfor
red(n_pendulums) = green(n_pendulums) = blue(n_pendulums) = 0;

#{
red(1:n_pendulums) = 0;
green(1:n_pendulums) = 0;
blue(1:n_pendulums) = linspace(1, 0.5,n_pendulums);
#}

# Plotting options
# ----------------
# Set plot directory
  plotdir = 'plots/';

  make_animation = "yes"
  plotheight = 1.1*2*(max(L1)+max(L2));
  plotwidth = 1.1*2*(max(L1)+max(L2));

#----------------------- Calculations ------------------------------------
# Using RK4 to find thetas and omegas, then calculate x and y coordinates
  # Set initial conditions as 1st place in each array
for j = 1:n_pendulums # Loop (for each) Pendulum (with presumably different conditions)

  i = 1;
  t(j,i) = t_start;
  theta1(j,i) = theta1_0(j);
  theta2(j,i) = theta2_0(j);
  omega1(j,i) = omega1_0(j);
  omega2(j,i) = omega2_0(j);
  [x1(j, i), x2(j, i), y1(j, i), y2(j, i)] = polar_to_cartesian(L1(j), L2(j), theta1(j, i), theta2(j, i));

  for i = 1:nt(j) # Inner Loop for each timepoint
    [t(j,i+1), theta1(j,i+1), theta2(j,i+1), omega1(j,i+1), omega2(j,i+1)] = RK4(t(j,i), dt(j), g(j), m1(j), m2(j), L1(j), L2(j), theta1(j,i), theta2(j,i), omega1(j,i), omega2(j,i));

    [x1(j, i+1), x2(j, i+1), y1(j, i+1), y2(j, i+1)] = polar_to_cartesian(L1(j), L2(j), theta1(j, i), theta2(j, i));
  endfor # End timeloop

  calculated_data_for_pendulum = j # print completed pundulum number
%  i = nt(j)
%  t_end = t(j, i+1)
%  theta1_end = theta1(j, i+1)
%  teta2_end = theta2(j, i+1)
%  omega1_end = omega1(j, i+1)
%  omega2_end = omega2(j, i+1)
endfor # End (for each) Pendulum Loop

#----------------------- Plots ------------------------------------
# Animation Plots
if (strncmp(make_animation, "yes", 3)) # only make snapshots if make_snapshots says "yes"
  figure(1);
  set(0, "defaultlinelinewidth", 4);

  for i = (t_start_plot/dt_plot+1):(t_end_plot/dt_plot+1) # loop for each time point read at plot_dt intervals
      current_t = dt_plot*(i-1)
      clf # clear the previous time point plot
      for j = 1:n_pendulums
        k = dt_plot/dt(j) * (i-1) + 1; # k customizes place in time array based on dt for that pendulum
        plot_points = [ 0,0; x1(j, k), y1(j, k)]; # plot L1 on the chart
        plot(plot_points(:,1),plot_points(:,2), "-", 'color', [red(j) green(j) blue(j)])
        hold on
        plot_points = [ x1(j, k), y1(j, k); x2(j, k), y2(j, k) ]; # plot L2 with dotted ends for m1 and m2
#plot(plot_points(:,1),plot_points(:,2),"o-", 'color', [red(j) green(j) blue(j)])
        plot(plot_points(:,1),plot_points(:,2), ".-", 'color', [red(j) green(j) blue(j)], "markersize", 36)
       endfor
       # decorate the plot
      title(sprintf("%d Double Pendulums -- t = %06.2f", n_pendulums, current_t));
            xlabel("x")
            ylabel("y")
       axis([-plotwidth/2 plotwidth/2 -plotheight/2 plotheight/2])
       #text(plotwidth/2, plotheight/2, sprintf(" t = %4.2f ", current_t))
       # save the plot with a custom name
       figfile = strcat(plotdir,sprintf("double_pendulum_time_%04d", i-1));
       #set(gca, "color", "black");
       #set(gcf,'InvertHardCopy','off')
       print (figfile, "-dpng", "-r300")
  endfor
endif
