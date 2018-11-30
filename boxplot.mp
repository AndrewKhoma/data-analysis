u := 2cm; _min := 0; lq := u/4; med := u/2; uq := u; _max := 3u/2; anom := 2u;

draw (_min, -u/8)--(_min, u/8) withpen pencircle scaled 5/4;

draw (_min, 0)--(lq, 0) withpen pencircle scaled 5/4;

draw (lq, -u/4)--(lq, u/4)--(uq, u/4)--(uq, -u/4)--cycle withpen pencircle scaled 5/4;

draw (med, -u/4)--(med, u/4) withpen pencircle scaled 5/4;

draw (uq, 0)--(_max, 0) withpen pencircle scaled 5/4;

draw (_max, -u/8)--(_max, u/8) withpen pencircle scaled 5/4;

draw fullcircle scaled 4bp shifted (anom, 0) withpen pencircle scaled 5/4;

draw (_min - u/4, -u/2)--(_min - u/4, u/2)--(anom + u/4, u/2)--(anom + u/4, -u/2)--cycle;