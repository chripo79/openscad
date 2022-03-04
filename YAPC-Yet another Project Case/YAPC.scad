/*### Z80 MBC2 pretty case###
# designed 2021 by C.PohlAAaaa     ∑
# Creative commons##
#uses the BOSL Library
*/
include <BOSL/constants.scad>
use <BOSL/masks.scad>
use <BOSL/shapes.scad>
use <mbc-sbc.scad>
use <partholders.scad>
$fn=20;
//##definitions##
/*[SEE What ]*/
//Show
assembly=true;
//enizelteile
part="nothing";//[nothing,lower,upper,frontpanel,backpanel]
//Detail
/*[Hidden]*/

//internals‚
tolerance=0.2;
lap_W=1;
lap_H=2.5;


//case related
/*[Gehäuse ]*/
// Case Width
   oa_width = 150;
//Case lenghth
   oa_length = 120;
//Case height
   oa_height =50;
//Cornerchamfer
   corner = 5;
// Front Angle
   front_angle =8;
//Distance angled part to lower edge
   front_low_H = 12;
//Wallthickness
   oa_wallthick = 2.5;
//trennlinie(Mittenabstand)
   cutline = 5;
/*[Panel]*/
// Panel thickness
   panel_t= 2;
//Thicknes pannel holding flange
   flange_b=2;
//height panelflange
   flange_t = 2.5;
/*[Mounting Standoffs]*/
// Standoff pattern(Mounts for stuffs)
   so_patterm = [[0,0,0],[0,92,0],[92,0,0],[92,92,0]];//
// Standoff X Offset
   so_xoff = 98+24;
// Standoff Y Offset
   so_yoff =98-6;
//Standoff height
   so_h = 3;
//outer Diameter standoff
   so_d = 5;
//inner Diameter standoff
   so_id = 2.5;
/*[Connecting teh halfs]*/
//Screw diameter
scr_DM=3;
//dept recess of screw
scr_recesT=10;
//Diameter screwhead
scr_recesDM=7;
//diameter threadinsert
scr_insDm=4.2;
//length threadinsert
scr_insT=6;



/*[Hidden]*/
screwdist=3+(scr_recesDM/2);
//helper modules
   module cyl(dia,hei,sides){
      cylinder(d=dia/cos(180/sides),h=hei,$fn=sides,center=true);
   }
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
                  translate([0.2,0,0]) resize([oa_width-(2*oa_wallthick)-flange_t,panel_t+0.4,oa_height-(2*(oa_wallthick-1))-flange_t,2.5*panel_t]) fwpanel();
         }

  }

   module fwpanel(){
      resize([oa_width-(2*oa_wallthick)-tolerance,panel_t,oa_height-(2*(oa_wallthick-1))-tolerance]) body_shape();
   }

   module overlap(way,dist){
      if (way==0){
         for(i=[-(oa_width/2)+(lap_W/2),(oa_width/2)-(lap_W/2)])
            translate([i,0,0]) cube([lap_W,oa_length-(2*dist),lap_H],center=true);
         }
      else if (way ==1){
         for(i=[-(oa_width/2)+(lap_W/2),(oa_width/2)-(lap_W/2)])
            translate([i,0,0]) cube([lap_W+tolerance,oa_length+tolerance-(dist*2),lap_H],center=true);
      }
   }

   module screwhole(){
      union(){
            translate([0,0,0]) cyl(scr_DM+00.6,oa_height-oa_wallthick-corner,32);
            translate([0,0,-(oa_height/2)+(scr_recesT/2)]) cyl(scr_recesDM,scr_recesT,32);
            translate([0,0,-cutline+(scr_insT/2)]) cyl(scr_insDm,scr_insT,32);
      }
   }

   module body_main(){
      difference(){
         union(){
            difference(){
               difference(){
                  body_shape();
                  resize([oa_width-(2*oa_wallthick),oa_length+0.1,oa_height-(2*(oa_wallthick-1))]) body_shape();
               }
               translate([-((oa_width/2)+0.05),(oa_length/2),-(oa_height/2)+front_low_H]) rotate([front_angle,0,0]) cube([oa_width+0.1,oa_height+20,50]);
            }
            for(i=[0,108]){
               translate([0,i,0])
               translate([0,-(oa_length/2)+panel_t+((flange_b+tolerance)/2),0])panelflange();
            }
            translate([(oa_width/2)-screwdist,0,-oa_height/2]) screwpart();
            mirror([1, 0, 0]) {
               translate([(oa_width/2)-screwdist,0,-oa_height/2]) screwpart();
            }

         }
         translate([(oa_width/2)-screwdist,0,0])screwhole();

         mirror([1, 0, 0]) {
           translate([(oa_width/2)-screwdist,0,])screwhole();
         }
      }

   }

   module screwpart(){
      scrpD=scr_recesDM+3;
      difference(){
         union(){
            cylinder(d=scrpD,h=oa_height);
            translate([0,-scrpD/2,0]) cube([scrpD/2,scrpD,oa_height]);
         }
            for(i=[0,oa_height])
            translate([scrpD/2,0,i])chamfer_mask_y(scrpD,corner);

         }
   }
   module standoff(){
      $fn=32;
      translate([-so_xoff/2,-so_yoff/2,0])
      for(i=[0:len(so_patterm)-1])
         //for (j=[0,mbc_hole_space])
            translate(so_patterm[i])
               difference(){
                  cyl(so_d,so_h,16);
                  cylinder(so_id, so_h, 32);
               }
   }
   module senkloch(th,l,sd,ed){ //th: durchgangsbohrung, bohngstiefe ,sd: senkdurchmesser, ed:extratiefe
      $fn=64;
      union(){
         cylinder(d=th,h=l);
         cylinder(d1=sd,d2=0,h=sd/2);
         translate([0,0,-ed])cylinder(d=sd,h=ed);
      }

   }


  module bore(){
      translate([-so_xoff/2,-so_yoff/2,0])
      for(i=[0:len(so_patterm)-1])
         //for (j=[0,mbc_hole_space])
            translate(so_patterm[i]) cyl(so_id, so_h+6, 32);
   }

// 0: upper
// 1: lower

// Parts
   module upperhalf(){
      difference(){
         union(){
            split(0,cutline) body_main();
            translate([0,0,-cutline-(lap_H/2)+tolerance]) overlap(0,5);
         }
         translate([-((oa_width/2)+0.05),(oa_length/2),-(oa_height/2)+front_low_H])
            rotate([front_angle,0,0])
               cube([oa_width+0.1,oa_height+20,50]);

      }
   }

 
   module lowerhalf(){
      difference(){
         union(){
            difference(){
               split(1,cutline) body_main();
               translate([0,0,-cutline-(lap_H/2)]) overlap(1,5);
            }
            translate([0,-3,-(oa_height/2)+(so_h/2)+(oa_wallthick/2)]) standoff();
         }
         translate([0,-3,-(oa_height/2)+(so_h/2)+(oa_wallthick/2)]) bore();
      }
   }





   module frontpanel(){

   fwpanel();

   }

   module backpanel(){

      fwpanel();

   }





if (assembly == true) {

  lowerhalf();
   upperhalf();
   //translate([0,50.9,0]) color("darkblue") frontpanel();
   //translate([0,-56.9,0]) rotate([-180,0,0]) color("darkblue") backpanel();

}

if(part=="lower") lowerhalf();
if(part=="upper") upperhalf();
if(part=="frontpanel") frontpanel();
if(part=="backpanel") backpanel();

