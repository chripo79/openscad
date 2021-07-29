 mbc_size = 100;
   mbc_board_thick = 1.6;
   mbc_hole_dist = 4;
   mbc_hole_space = 92;
   mbc_hole_dia=3;

module mbc() {
      translate([-mbc_size/2,-mbc_size/2,0])
      difference(){
         cube([mbc_size,mbc_size,mbc_board_thick]);
         for(i=[mbc_hole_dist ,mbc_hole_space+mbc_hole_dist])
            for(j=[mbc_hole_dist ,mbc_hole_space+mbc_hole_dist])
               translate([i,j,0.2])cylinder(h=4,d=mbc_hole_dia,center=true);
      }
   }
   mbc();