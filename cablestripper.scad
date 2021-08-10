
//blade (olfa)
//color("grey")cube([0.6,6.5,39],center = true);
difference(){
union(){
difference(){
  translate([24,0,0]) rotate([0,90,0])cylinder(d=16,h=60,center=true,$fn=64);
  translate([24,0,0]) rotate([45,0,0]) cube([65,4,4],center=true);

}
translate([-3,0,3])cube([6,5,5],center=true);
}
cube([0.7,6.6,39],center = true);
translate([-7.5,0,5]) rotate([0,90,0])cylinder(d=4.2,h=15,center=true);
}