//MCMLXXIX

include <BOSL/constants.scad>
use <BOSL/masks.scad>

//translate([0,2,1.5]) color("darkred") sdcard();

module cyl(dia,hei,sides){
      cylinder(d=dia/cos(180/sides),h=hei,$fn=sides,center=true);
   }





module sdcard_holder(){
  difference(){
    union(){
      cube([46,28,9]);
      translate([0,-7,0]) cube([5,42,9]);
    }
    difference(){
      translate([-0.02,2,1.5])cube([42.3,23.7,5.2]);
      translate([0,14,5.7]){
        translate([21,-12,1])chamfer_mask_x(42,2.5);
        mirror([0,1,0]) translate([21,-12,1])chamfer_mask_x(42.3,2.5);
        translate([21,-12,-4.5])chamfer_mask_x(42,1);
        mirror([0,1,0]) translate([21,-12,-4.5])chamfer_mask_x(42.3,1);
      }
    }

    for(i=[-3.5,31.5]) translate([0,i,4]) rotate([0,90,0]) cyl(4.2,11,32);
    translate([0,14.5,-1]) resize([4,12,10]) cylinder(d=12,h=10,$fn=32);
    translate([-0.1,23.5-(19),3.2]) cube([47,19,6]);
    
    translate([5,14,0]){
        translate([21.1,-14,9])chamfer_mask_x(42,3);
        mirror([0,1,0]) translate([21.1,-14,9])chamfer_mask_x(42,3);
        translate([21.1,-14,0])chamfer_mask_x(42,3);
        mirror([0,1,0]) translate([21.1,-14,0])chamfer_mask_x(42,3);
    }
  }
}
module ftdi_holder(){
  cardy=15.5;
  cardx=25.6;
  wall=4;
  screwspace=7; 
  flangethick=5;

  difference(){
    union(){
      cube([cardx+3,cardy+(2*wall),9]);
      translate([0,-screwspace,0]) cube([flangethick,cardy+(2*wall)+(2*screwspace),9]);
      
    }

    translate([-0.02,wall,2])cube([cardx,cardy,9]);
    translate([0,wall,7.2]) cube([cardx+2*wall+0.1,cardy,3.4]);
    }
  translate([9.5,wall,2]) cube([cardx-9.5,cardy,2.5]);
    }
   
  


sdcard_holder();

module sdcard_diff(){
  intersection(){
    translate([-2,-7,0])cube([2,42,9]);
    union(){
      for(i=[-3.5,31.5]) translate([0,i,4]) rotate([0,90,0]) cyl(3.6,11,32);
      translate([-2,15.4,-1]) resize([10,14,10]) cylinder(d=12,h=10,$fn=32);
    }
  }
}

sdcard_diff();