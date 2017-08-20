module round(d=27, tolerance=0.5) {
    difference() {
        cylinder(d=d+4, h= 5);
        translate([0,0,2]) cylinder(d=d + tolerance*2, h= 5);
        cylinder(d=d/1.5, h= 5);
    }
}

module grid(x=3,y=3,d=25, tolerance=0.5) {
// even row
for (j = [0:2:y-1])
    for (i = [0:x-1]) 
        translate([(d+3)*i,(d-1.5)*j,0])
            round(d);

// odd
for (j = [1:2:y-1])
translate([(d+3)/2,0,0])
    for (i = [0:x-2]) 
        translate([(d+3)*i,(d-1.5)*j,0])
            round(d);
}
module grid2(x=3,y=3,d=25, tolerance=0.5, h=5) {
    // even row
    for (j = [0:2:y-1])
        for (i = [0:x-1]) 
            translate([(d+3)*i,(d-1.5)*j,0])
                cylinder(d=d+4, h= h);
    // odd
    for (j = [1:2:y-1])
        translate([(d+3)/2,0,0])
            for (i = [0:x-2]) 
                translate([(d+3)*i,(d-1.5)*j,0])
                    cylinder(d=d+4, h= h);
}


module stack_grid(x=3,y=3, d=25, tolerance=0.5,wh=5, h=30, stack=false) {
    shift_y = ((y%2 == 1) ? (d+60)   : 1);
    grid(x=x,y=y, tolerance=tolerance);
    if (stack)
        difference() {
        translate([-(d+6)/2,(d-9)/2,0])
            union() {
            for (j = [0:1:y-3]) 
                for (i = [1:x-1]) 
                    translate([i*(d+4),(d*1.85)*j,2])cylinder(d=10,h=30) ;
            }
            grid2(x=x,y=y, tolerance=tolerance, h=h+10);
        }
}

stack_grid(x=3, y=4, d=25, tolerance=0.25, stack=true);
