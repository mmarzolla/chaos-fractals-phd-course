# octave-pendulums README
Included are 2 programs for simulating pendulum motion in Octave. (https://www.gnu.org/software/octave/)

The double pendulum model simulates the chaotic motion off double pendulums using RK4. Their motion is chaotic, meaning small changes in intial conditons will lead to very different resulting in later iterations. Multiple variables in "compare_double_pendululms.m" allow the user to modify the initial conditons of the main pendulum. All other files are functions. A loop is used to set up conditions of more pendulums to demonstrate and experiment with the chaotic effects. 
More information on double pendulums can be found here: https://scienceworld.wolfram.com/physics/DoublePendulum.html

The pendulum wave model simulates multiple single pendulums with calculated lengths resulting in each pendulum doing one more oscilation than the next one within the longer period of the system. The effect is an illusion that the system is spiraling as the pendulums move in and out of sync. Variables can be modified in "make_pendulum_wave.m" All other files are functions. 
More information of pendulum waves can be found here: https://www.education.com/science-fair/article/pendulum-waves/

Included in each folder are example outputs from the default code.
Each plot is saved as a .png and can be spliced together to create an animated .gif with a tool such as https://ezgif.com/maker
