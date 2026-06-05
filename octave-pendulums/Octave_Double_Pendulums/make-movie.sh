#!/bin/bash

# This script can be used to produce a movie showing multiple double
# pendulums starting from slightly different initial configurations.
# This script calls `octave` to produce the individual frames into the
# `plots/` subdirectory, and then `ffmpeg` to assemble the frames into
# a movie.

# Last updated by Moreno Marzolla on 2026-06-05

if [ ! -d plots ]; then
    mkdir plots
fi

octave compare_double_pendulums.m

ffmpeg -f image2 -framerate 60 -i plots/double_pendulum_time_%04d.png -vcodec libx264 -crf 22 compare_double_pendulums.mp4
