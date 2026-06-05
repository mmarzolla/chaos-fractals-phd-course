clear variables
clear all
close all

#----------------------- Set-up options ------------------------------------
# Set number of pendulums
  n_pendulums = 20;
  
  Tmax = 40; # period of entire system in seconds
  k = 30; # number of oscilations for longest pendulum in Tmax
  k_diff = 1; # difference in amount of periods in a system period between each pendulum

# Set times to analyze
  t_start = 0.00; # time inital conditions set to
  t_end = 1/k_diff*Tmax; # highest time calculated

  t_start_plot = t_start; # time to start the plots
    t_end_plot = t_end; # time to end the plots
       dt_plot = 0.05; # time-point differences for plots
  
  nt_plot = (t_end_plot-t_start_plot)/dt_plot; # number of timepoints to plot
  
# Set conditions for 1st pendulum
# -------------------------------
  dt(1) = .01; 
  nt(1) = (t_end-t_start)/dt(1);

  m(1) = 1; `
   
  g(1) = 9.80665;

  theta_0(1) = 20*pi/180;

  omega_0(1) = 0.0; 

# Set conditions for subsequent pendulums
# ---------------------------------------
for j = 1:n_pendulums
  
  dt(j) = dt(1); # same dt as control
  nt(j) = (t_end-t_start)/dt(j); # calculate number of timepoints for this pendulum

  m(j) = m(1); # same m as control 

  g(j) = g(1); # same g as conttol

  L(j) = g(j)*(Tmax/(2*pi*(k+k_diff*j-1)))^2; # Change L specifically for wave pattern

  theta_0(j) = theta_0(1); # same theta_0 as control

  omega_0(j) = omega_0(1); # same as control
  
endfor

# Set pendulum colors on a RGB scale
# ----------------------------------
%for j = 1:n_pendulums # loop for each pendulum
%  red(j) = rand(1); # random number between 0 & 1
%  green(j) = rand(1);
%  blue(j) = rand(1);
%endfor
red(1) = 1;
green(1) = 0;
blue(1) = 0;

red(2) = 1;
green(2) = .5;
blue(2) = 0;

red(3) = .5;
green(3) = .5;
blue(3) = 0;

red(4) = .5;
green(4) = 1;
blue(4) = 0;

red(5) = 0;
green(5) = .5;
blue(5) = 0;

red(6) = 0;
green(6) = 1;
blue(6) = .5;

red(7) = 0;
green(7) = 1;
blue(7) = 1;

red(8) = 0;
green(8) = .5;
blue(8) = 1;

red(9) = 0;
green(9) = 0;
blue(9) = 1;

for i = 10:n_pendulums
  red(i) = red(i-9);
  green(i) = green(i-9);
  blue(i) = blue(i-9);
endfor


# Plotting ptions
# ----------------
# Set plot directory
  plotdir = 'plots/';
  
  make_animation = "yes"
      main_title = "Simple Pendulums" 
      plotheight = 1.1*2*max(L);
       plotwidth = 1.1*2*max(L);

#----------------------- Calculations ------------------------------------
# Using RK4 to find thetas and omegas, then calculate x and y coordinates
  # Set initial conditions as 1st place in each array
for j = 1:n_pendulums # Loop (for each) Pendulum (with presumably different conditions)
  
  i = 1;
  t(j,i) = t_start;
  theta(j,i) = theta_0(j);
  omega(j,i) = omega_0(j);  
  [x(j, i), y(j, i)] = polar_to_cartesian(L(j), theta(j, i));
  
  for i = 1:nt(j) # Inner Loop for each timepoint
    [t(j,i+1), theta(j,i+1), omega(j,i+1)] = RK4(t(j,i), dt(j), g(j), m(j), L(j), theta(j,i), omega(j,i));
    
    [x(j, i+1), y(j, i+1)] = polar_to_cartesian(L(j), theta(j, i));
  endfor # End timeloop

  calculated_data_for_pendulum = j # print completed pundulum number  
%  i = nt(j)
%  t_end = t(j, i+1)
%  theta_end = theta(j, i+1)
%  omega_end = omega(j, i+1)
endfor # End (for each) Pendulum Loop

#----------------------- Plots ------------------------------------
# Animation Plots
if (strncmp(make_animation, "yes", 3)) # only make snapshots if make_snapshots says "yes"
  figure(1);
  for i = (t_start_plot/dt_plot+1):(t_end_plot/dt_plot+1) # loop for each time point read at plot_dt intervals
      current_t = dt_plot*(i-1)
      clf # clear the previous time point plot
      for j = 1:n_pendulums 
        k = dt_plot/dt(j) * (i-1) + 1; # k customizes place in time array based on dt for that pendulum     
        plot_points = [ 0,0; x(j, k), y(j, k)]; # plot L1 on the chart
        plot(plot_points(:,1),plot_points(:,2),"-", 'color', [red(j) green(j) blue(j)])
        hold on
        plot_points = [ x(j, k), y(j, k); x(j, k), y(j, k) ]; # plot L2 with dotted ends for m1 and m2
        plot(plot_points(:,1),plot_points(:,2),"o-", 'color', [red(j) green(j) blue(j)])
       endfor
       # decorate the plot
       title(main_title) 
            xlabel("x")
            ylabel("y")
       axis([-plotwidth/2 plotwidth/2 -plotheight/2 plotheight/2])
       text(plotwidth/2, plotheight/2, sprintf(" t = %4.2f ", current_t)) 
       # save the plot with a custom name
       figfile = strcat(plotdir,sprintf("double_pendulum_time_%4d", i-1));
       print (figfile, "-dpng")       
  endfor
endif
