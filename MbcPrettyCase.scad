/*### Z80 MBC2 pretty case###
# designed 2021 by C.Pohl 
# Creative commons##
*/
include <BOSL/constants.scad>
use <BOSL/masks.scad>

//##definitions##
//divese
  mov=0;
  tolerance=0.2;
//mbc related
   mbc_size = 100;
   mbc_board_thick = 1.6;
   mbc_hole_dist = 4;
   mbc_hole_space = 92;
   mbc_hole_dia=3;

//case related
   oa_width = 120;
   oa_length = 120;
   oa_height =40;
   corner = 5;
   oa_wallthick = 2.5;
   front_angle =8;
   front_low_H = 12;
   cutline = 5;
   panel_t= 2;
   flange_b=2;
   flange_t = 2.5;
   lap_W=1;
   lap_H=2.5;
   so_h = 3;
   so_d = 5;
   so_id = 2.5;

//helper modules
   module split(side,delta){ //sel :  0 = upper half, 1 = lower half ; delta: moves cut towards -z

      if (side==0) {
         difference(){
            children();
            translate([0,0,-(oa_height/2)-delta]) cube([oa_width+5,oa_length+5,oa_height],center = true);

         }
      }
      else if (side==1) {
         difference(){
            children();
            translate([0,0,(oa_height/2)-delta-(tolerance*0.75)]) cube([oa_width+5,oa_length+5,oa_height],center = true);

         }
      }

   }
// part modules
   module mbc() {
      translate([-mbc_size/2,-mbc_size/2,0])
      difference(){
         cube([mbc_size,mbc_size,mbc_board_thick]);
         for(i=[mbc_hole_dist ,mbc_hole_space+mbc_hole_dist])
            for(j=[mbc_hole_dist ,mbc_hole_space+mbc_hole_dist])
               translate([i,j,0.2])cylinder(h=4,d=mbc_hole_dia,center=true);
      }
   }
   module body_shape(){
      difference(){
         cube([oa_width,oa_length,oa_height],center = true);
         for(i=[-oa_width/2,oa_width/2])
            for(j=[-oa_height/2, oa_height/2])
               translate([i,0,j])chamfer_mask_y(oa_length, corner);
      }
   }

  module panelflange(){
     translate([0,(-1*(panel_t+flange_b+tolerance)/2),0])
      for(i=[0,flange_b+panel_t+tolerance])
         translate([0,i,0])
         difference(){
                  resize([oa_width-(2*oa_wallthick),panel_t,oa_height-(2*(oa_wallthick-1)),flange_b])fwpanel();
                  resize([oa_width-(2*oa_wallthick)-flange_t,panel_t,oa_height-(2*(oa_wallthick-1))-flange_t,2.5*panel_t]) fwpanel();
         }

  }

   module fwpanel(){
      resize([oa_width-(2*oa_wallthick)-tolerance,panel_t,oa_height-(2*(oa_wallthick-1))-tolerance]) body_shape();
   }

   module overlap(way){
      if (way==0){
         for(i=[-(oa_width/2)+(lap_W/2),(oa_width/2)-(lap_W/2)])
            translate([i,0,0]) cube([lap_W,oa_length,lap_H],center=true);
         }
      else if (way ==1){
         for(i=[-(oa_width/2)+(lap_W/2),(oa_width/2)-(lap_W/2)])
            translate([i,0,0]) cube([lap_W+tolerance,oa_length,lap_H],center=true);
      }
   }

   module body_main(){
      union(){
         difference(){
            difference(){
               body_shape();
               resize([oa_width-(2*oa_wallthick),oa_length+0.1,oa_height-(2*(oa_wallthick-1))]) body_shape();
            }
            translate([-((oa_width/2)+0.05),(oa_length/2),-(oa_height/2)+front_low_H]) rotate([front_angle,0,0]) cube([oa_width+0.1,oa_height+20,50]);
         }
         for(i=[0,108])
            translate([0,i,0])
            translate([0,-(oa_length/2)+panel_t+((flange_b+tolerance)/2),0])panelflange();
      }
   }
   module standoff(){
      $fn=32;
      translate([-mbc_hole_space/2,-mbc_hole_space/2,0])
      for(i=[0,mbc_hole_space])
         for (j=[0,mbc_hole_space]) 
            translate([i,j,0])
               difference(){
                  cylinder(h=so_h,d=so_d,center=true);
                  cylinder( d=so_id, h=so_h, center=true);
               }
   }
// 0: upper
// 1: lower

// Parts
   module upperhalf(){
      difference(){
            union(){
               split(0,cutline) body_main();
               translate([0,0,-cutline-(lap_H/2)+tolerance]) overlap(0);
            }
         translate([-((oa_width/2)+0.05),(oa_length/2),-(oa_height/2)+front_low_H]) rotate([front_angle,0,0]) cube([oa_width+0.1,oa_height+20,50]);

      }
   }
   module lowerhalf(){
      union(){
         difference(){
            split(1,cutline) body_main();
            translate([0,0,-cutline-(lap_H/2)]) overlap(1);
         }
         translate([0,-3,-(oa_height/2)+(so_h/2)+(oa_wallthick/2)]) standoff();
     }
   }

//standoff();
lowerhalf();
//upperhalf();
translate([0,-3,-17])mbc();