 mbc_size = 100;
   mbc_board_thick = 1.6;
   mbc_hole_dist = 4;
   mbc_hole_space = 92;
   mbc_hole_dia=3;

module pcb(){
   translate([0,0,-mbc_board_thick])
      difference(){
         cube([mbc_size,mbc_size,mbc_board_thick]);
         for(i=[mbc_hole_dist ,mbc_hole_space+mbc_hole_dist])
            for(j=[mbc_hole_dist ,mbc_hole_space+mbc_hole_dist])
               translate([i,j,0.2])cylinder(h=4,d=mbc_hole_dia,center=true);
      }
}

module led(){
   union(){
      cylinder(d=3,h=6.5);
      translate([0,0,6.5])sphere(d=3);
   }
}
module button(){
   union(){
      translate([0,0,2]) cube([6,6,4],center=true);
      cylinder(d=3.5,h=4.5);
   }
}
module mbc() {
   union(){
      pcb();
      for (i=[0:1:4])
         translate([47.7+(i*9),5,0]) led();
      for (j=[0:1])
         translate([17+(j*18),6.5,0]) button();
   }
}

   module sdcard() {

   difference(){
      cube([42,23.55,1.7]);
      linear_extrude(height=2){translate([0,7.3+10.5,0]) rotate([0,0,270]) polygon(points=[[0,0],[10.5,0],[8,1.4],[2,1.4]]);}
   }
   translate([-0.3,7,1.7]) cube([16.2,11,2.2]);
   translate([37.3,4,1.7]) cube([9,15,4]);
}


//sdcard();
//mbc();
//button();
