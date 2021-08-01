difference(){

translate([-1,-2,0]) cube([17,3,1.8]);

for(i=[0:1:7])
translate([2*i,0,0])  
union(){
      cube([1,2.5,2]);
      translate([0.5,0,0])cylinder(d=1,h=2,$fn=8);
 }
 }