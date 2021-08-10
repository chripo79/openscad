/*### Z80 MBC2 pretty case###
# designed 2021 by C.PohlAAaaa     ∑
# Creative commons##
#uses the BOSL Library
*/
include <BOSL/constants.scad>
use <BOSL/masks.scad>
use <BOSL/shapes.scad>
use <mbc-sbc.scad>
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
            translate([0,0,0]) cylinder(d=scr_DM+00.6,h=oa_height-oa_wallthick-corner,center=true);
            translate([0,0,-(oa_height/2)+(scr_recesT/2)]) cylinder(d=scr_recesDM,h=scr_recesT,center=true);
            translate([0,0,-cutline+(scr_insT/2)]) cylinder(d=scr_insDm,h=scr_insT,center=true);
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
            translate([0,0,-cutline-(lap_H/2)+tolerance]) overlap(0,5);
         }
         translate([-((oa_width/2)+0.05),(oa_length/2),-(oa_height/2)+front_low_H])
            rotate([front_angle,0,0])
               cube([oa_width+0.1,oa_height+20,50]);

      }
   }
   module bore(){
      translate([-mbc_hole_space/2,-mbc_hole_space/2,0])
      for(i=[0,mbc_hole_space])
         for (j=[0,mbc_hole_space])
            translate([i,j,0]) cylinder( d=so_id, h=so_h+6, center=true);
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
module legend(){
   linear_extrude(height=0.15){
         //logo
         translate([-53,8,0])  text("Z80 MBC2",font="Rockwell:style=Bold",size=4);
         //switchwe
         translate([-18.2,-10,0]) rotate(90) text("RESET",font="Cousine:style=Bold",size=3);
         translate([-18.2-18,-10,0]) rotate(90) text("USER",font="Cousine:style=Bold",size=3);
         //lights
         translate([-2.5,-1,0]) rotate(45) text("USER",font="Cousine:style=Bold",size=3);
         translate([-2.5+9,-1,0]) rotate(45) text("IOS",font="Cousine:style=Bold",size=3);
         translate([-2.5+18,-1,0]) rotate(45) text("HALT",font="Cousine:style=Bold",size=3);
         translate([-2.5+27,-1,0]) rotate(45) text("DMA",font="Cousine:style=Bold",size=3);
         translate([-2.5+36,-1,0]) rotate(45) text("IO OP",font="Cousine:style=Bold",size=3);

   //translate([105,0,8]) text("Z80 MBC2",font="Cousine:style=Bold",size=4);
   }
   }

   module frontpanel(){

      lit_w = 5.5;
      lit_h = 8;
      sw_w=4.6;
      sw_h=8;
      init_led = (mbc_size/2)-led_dist-(lit_w/2);
      init_sw = (mbc_size/2)-btn_dist;

      difference(){
         fwpanel();
         // indicator lights
         for(i=[0:1:4])
            translate([init_led-(led_space*i),-(panel_t/2)-0.1,-15]) cube([lit_w,panel_t+0.2,lit_h]);
         // switches
         for(i=[0:1:1])
            translate([init_sw-(btn_space*i),0,-9.5]) cuboid([sw_w,panel_t+8,sw_h],chamfer=2);
         //#translate([0,0.8,0]) rotate([90,0,180]) legend();
      }
   }
 module backpanel(){
    fwpanel();
 }

   module swlever(){
      difference(){
         hull(){
            translate([0,0,0.5])rotate([0,90,0])cylinder(d=15,h=4,center=true);
            translate([0,2,0.5])rotate([0,90,0])cylinder(d=10,h=4,center=true);
         }
         translate([0,-3,0]) rotate([-90,0,0])cylinder(d=3.4,h=30,$fn=8);
         translate([5,-4,3]) rotate([-90,0,90])cylinder(d=3.4,h=30,$fn=64);
      }
   }
//translate([80,0,0])screwhole();


if (assy == true) {

   lowerhalf();
   upperhalf();
   rotate([0,0,180])translate([-50,-47,-19.5]) color("lightblue") mbc();
   translate([0,50.9,0]) color("darkblue") frontpanel();
   translate([0,-56.9,0]) color("darkblue") backpanel();
   translate ([33,41,-8]) {
      swlever();
      translate([0,-3,0]) rotate([-90,0,0])cylinder(d=3,h=20,$fn=64);
   }
   translate ([33-18,41,-8]) {
      swlever();
      translate([0,-3,0]) rotate([-90,0,0])cylinder(d=3,h=20,$fn=64);
   }
}

if(part=="unten") lowerhalf();
if(part=="oben") upperhalf();
if(part=="frontpanel") frontpanel();
if(part=="backpanel") backpanel();
if(part=="schalter") swlever();

