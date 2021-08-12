$fn=128;
difference(){
union(){
  cylinder(d=14.8,h=5);
  cylinder(d=17,h=1);

}
translate([0,0,1]) cylinder(d=13,h=4);
}
