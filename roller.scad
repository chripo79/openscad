$fn=32;

// definitionen
dm_rolle = 25;
t_rolle = 10;
spiel = 0.2;
dm_nut = 4;
d1_seite = 30;
d2_seite = 20;
h_seite = 40;
t_seite = 3;
//hilfsmodule


//hauptmodule
module rolle(){
  difference(){
    difference(){
      union(){
        cylinder(d=dm_rolle,h=t_rolle,center=true);
      }
      cylinder(d=3.5,h=10.1,center=true);
    }
    rotate_extrude(convexity=10)
    translate([dm_rolle/2,0,0])circle(d=dm_nut);
  }
}

module seitenteil(){
  hull(){
    cylinder(d=d1_seite,h=t_seite,center=true);
    translate([h_seite,0,0]) cylinder(d=d2_seite, h=t_seite, center=true);
  }
}




rolle();
translate([0,0,(-t_rolle/2-t_seite/2)-spiel]) seitenteil();