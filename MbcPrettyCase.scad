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
/*[Anzeigen ]*/
//Assembly anzeigen
assy=true;
//enizelteile
part="kein";//[kein,unten,oben,frontpanel,schalter,backpanel]
//Detail
/*[Hidden]*/

//internals‚
tolerance=0.2;
lap_W=1;
lap_H=2.5;


   mbc_size = 100;
   //mbc_board_thick = 1.6;
   mbc_hole_dist = 4;
   mbc_hole_space = 92;
   mbc_hole_dia=3;
   led_dist =47.7;
   led_space=9;
   btn_dist =17;
   btn_space=18;


//case related
/*[Gehäuse ]*/
// Gehäuse Breite
   oa_width = 150;
//Gehäuse länge
   oa_length = 120;
//Gehäuse Höhe
   oa_height =50;
//eckenschräge
   corner = 5;
// Front Winkel
   front_angle =8;
//abstanf WInkel Unterkante
   front_low_H = 12;
//Wandstärke
   oa_wallthick = 2.5;
//trennlinie(Mittenabstand)
   cutline = 5;
/*[Panel]*/
// Panel Dicke
   panel_t= 2;
//Flanschdicke
   flange_b=2;
//flanschweite(Höhe)
   flange_t = 2.5;
/*[Einbausteher]*/
// Steher Muster
   so_patterm = [[0,0,0],[0,92,0],[92,0,0],[92,92,0]];//
// Steher X Offset
   so_xoff = 98+24;
// Steher Y Offset
   so_yoff =98-6;
//Steher Höhe
   so_h = 3;
//Steher D Außen
   so_d = 5;
//Steher D Innen
   so_id = 2.5;
/*[Verbindungsschraube]*/
//Schraubendurchmesser
scr_DM=3;
//Senktiefe
scr_recesT=10;
//Durchmesser Schraubenkopf
scr_recesDM=7;
//Gewindeeinsatz Durchmesser
scr_insDm=4.2;
//Länge Gewindeeinsatz
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
   module senkloch(th,l,sd,ed){ //th: durchgangsbohrung, bohngstiefe ,sd: enkdurchmesser, ed:extratiefe
      $fn=64;
      union(){
         cylinder(d=th,h=l);
         cylinder(d1=sd,d2=0,h=sd/2);
         translate([0,0,-ed])cylinder(d=sd,h=ed);
      }

   }
   module subDcutout(){
      translate([-25/2,0,0]) 
      for(i=[0,25]) translate([i,0,0]) senkloch(3.4,5,6.3,0.3);
      translate([0,0,4])cube([18,9,10],center=true);
   }

module subDcutout(){
  translate([-25/2,0,0]) 
   for(i=[0,25]) translate([i,0,0]) senkloch(3.4,5,6.3,0.3);
   translate([0,0,4])cube([18,9,10],center=true);
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

   module bore(){
      translate([-so_xoff/2,-so_yoff/2,0])
      for(i=[0:len(so_patterm)-1])
         //for (j=[0,mbc_hole_space])
            translate(so_patterm[i]) cyl(so_id, so_h+6, 32);
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

// beschrifungen, extras
   module legend(){
   linear_extrude(height=0.4){
         //logo
         translate([-35,16,0])  text("Z80 MBC2",font="Rockwell:style=Bold",size=6);
         //switchwe
         translate([-18.2-18,-14,0]) rotate(90) text("RESET",font="Cousine:style=Bold",size=3);
         translate([-18.2,-14,0]) rotate(90) text("USER",font="Cousine:style=Bold",size=3);
         //lights
         translate([-2.5,-1,0]) rotate(45) text("USER",font="Cousine:style=Bold",size=3);
         translate([-2.5+9,-1,0]) rotate(45) text("IOS",font="Cousine:style=Bold",size=3);
         translate([-2.5+18,-1,0]) rotate(45) text("HALT",font="Cousine:style=Bold",size=3);
         translate([-2.5+27,-1,0]) rotate(45) text("DMA",font="Cousine:style=Bold",size=3);
         translate([-2.5+36,-1,0]) rotate(45) text("IO OP",font="Cousine:style=Bold",size=3);

   //translate([105,0,8]) text("Z80 MBC2",font="Cousine:style=Bold",size=4);
   }
   }

   module schalterhalter(){
      difference(){
            for(i=[0,btn_space]){
               translate([i,0,0]){
                  union(){
                     translate([4.5,-12.9/2,-5])cube([4,12.9,10],center=true);
                     translate([4.5,-12.9,-5]) rotate([0,90,0]) cyl(10,4,32);
                  }

                  union(){
                     translate([-4.5,-12.9/2,-5])cube([4,12.9,10],center=true);
                     translate([-4.5,-12.9,-5]) rotate([0,90,0]) cyl(10,4,32); 
                  }
               }
            }
            translate([10,-12.9,-5]) rotate([0,90,0]) cyl(3.2,35,32);
         }
   }

   module frontpanel(){

      lit_w = 5.5;
      lit_h = 8;
      sw_w=4.6;
      sw_h=8;
      init_led = (mbc_size/2)-led_dist-(lit_w/2);
      init_sw = (mbc_size/2)-btn_dist;

      union(){
         difference(){
            fwpanel();
            // indicator lights
            for(i=[0:1:4])
               translate([init_led-15-(led_space*i),-(panel_t/2)-0.1,-15]) cube([lit_w,panel_t+0.2,lit_h]);
            // switches
            for(i=[0:1:1]){
               translate([20-(btn_space*i),0,-0]) rotate([90,0,0]) cyl(6.6,6,10);
               translate([20-(btn_space*i),-1,-6.4]) rotate([90,0,0]) cyl(2.6,6,1);}
            #
            translate([54,-1.1,-14])rotate([90,0,-90])resize([2.2,0,0],auto=[true,false,false])sdcard_diff();
         }
         translate([-15,0.9,-3]) rotate([90,0,180]) legend();
         //schalterhalter();
      }

   }
   module backpanel(){
  
      difference(){
         union(){
            fwpanel();
            translate([50,-1.5,0])cube([12,1,30],center=true);
         }
         
         translate([50,0.8,0])rotate([90,90,0]) subDcutout();
         for(i=[0:18])
            translate([25-(4*i),-2,-12]) cube([2,4,25]);
      }
 }

   module swlever(){
      difference(){
         hull(){
            translate([0,0,0.5])rotate([0,90,0])cyl(15,4,16);
            translate([0,2,0.5])rotate([0,90,0])cyl(10,4,16);
         }
         translate([0,-3,0]) rotate([-90,0,0])cyl(3.2,30,8);
         translate([5,-3,3]) rotate([-90,0,90])cyl(3.4,30,64);
      }
   }
//translate([80,0,0])screwhole();
//frontpanel();



if (assy == true) {

  lowerhalf();
   //upperhalf();
   rotate([0,0,180])translate([-35,-47,-19.5]) color("lightblue") mbc();
   translate([0,50.9,0]) color("darkblue") frontpanel();
   translate([0,-56.9,0]) rotate([-180,0,0]) color("darkblue") backpanel();
   //translate([1.7+50, 35, -15]) rotate([90,0,-90])  sdcard();
   translate ([33-15,41,-8]) {
      swlever();
      translate([0,-3,0]) rotate([-90,0,0])cylinder(d=3,h=20,$fn=64);
   }
  
   translate ([33-15-18,41,-8]) {
      swlever();
      translate([0,-3,0]) rotate([-90,0,0])cylinder(d=3,h=20,$fn=64);
   }}


if(part=="unten") lowerhalf();
if(part=="oben") upperhalf();
if(part=="frontpanel") frontpanel();
if(part=="backpanel") backpanel();
if(part=="schalter") swlever();

