/*### Z80 MBC2 pretty case###
# designed 2021 by C.PohlAAaaa     ∑
# Creative commons##
#uses the BOSL Library & NopSCADlib
*/
include <BOSL/constants.scad>
include <NopSCADlib/lib.scad>
use <USB-HUB.scad>
use <BOSL/masks.scad>
use <BOSL/shapes.scad>
$fn=20;
//##definitions##
/*[Anzeigen ]*/
//Assembly anzeigen
assy=true;
//enizelteile
part="kein";//[kein,unten,oben,frontpanel,backpanel,buttonholder]
//Detail
/*[Hidden]*/

//internals‚
tolerance=0.2;
lap_W=1;
lap_H=2.5;


   


//case related
/*[Gehäuse ]*/
// Gehäuse Breite
   oa_width = 160;
//Gehäuse länge
   oa_length = 140;
//Gehäuse Höhe
   oa_height =70;
//eckenschräge
   corner = 5;
// Front Winkel
   front_angle =5;
//abstanf WInkel Unterkante
   front_low_H = 20;
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
   so_patterm = [[0,0,0],[0,49,0],[58,0,0],[58,49,0]];//
// Steher X Offset
   so_xoff = 70;
// Steher Y Offset
   so_yoff = 115;
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
               translate([-((oa_width/2)+0.05),(oa_length/2),-(oa_height/2)+front_low_H]) rotate([front_angle,0,0]) cube([oa_width+0.1,oa_height+30,70]);
            }
            for(i=[0,128]){
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

module fangrid(){
  union(){
   for(i=[0,60,120]){
      rotate([0,0,i]) cube([66,2,1.5],center=true);
   }
   cylinder(d=24,h=1.5,center=true);
   difference(){
      cylinder(d=43,h=1.5,center=true);
      translate([0,0,-0.25]) cylinder(d=39,h=3,center=true);
   }
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

module sq_cut(){
   difference(){
      cube([45,5,12]);
      for(i=[0,45],j=[0,12]){
         translate([i,0,j])
         fillet_mask(l=11,r=5,orient=ORIENT_Y);
      }
   }
}





   module frontpanel(){

      pos_btn=[50,0,0];
union(){
      difference(){
         fwpanel();
            translate([-69.4,9.2,-15]) rotate([0,0,0]) hub();
            translate([-61.5,8,-19.9]) screwholes_hub(3.5);
            translate(pos_btn)  cube([16.5,10,16.5],center=true);
            translate([-40,0,14]) rotate([180,-90,90]) for(i=[-16.5,16.5]){
               translate([0,i,0]) cylinder(d=3.8,h=6,center=true,$fn=64);
            }
            translate([-40,0,14]) cube([24,20,3],center=true);
      }
      translate(pos_btn+[0,-1.5,0])
      difference(){
         cube([22,3,22],center=true);
         cube([20,3,20],center=true);
         
      }
      color("white") translate([20,0.9,2]) rotate([90,0,180]) legend();
}


   }
   module backpanel(){

      difference(){
            fwpanel();
            translate([15.5,0,10.1]) rotate([90,0,0]) cylinder(d=8,h=10,center=true);
            translate([-34.5,-2.5,6]) sq_cut();
            for(i=[0:5:30]){
            translate([-70+i,0,23]) cube([2,5,15],center=true);}
            for(i=[0:5:45]){
            translate([70-i,0,23]) cube([3,5,15],center=true);}
            
   }
   }
   module buttonholder(){
      difference(){
      cube([20,10,20],center=true);
      translate([0,2,0]) cube([18,8,18],center=true);
      cube([14.2,11,14.2],center=true);
   }
   }
module upperhalf_ed(){
   union(){
      difference(){
         union(){
            upperhalf();
            //translate([0,-25,33.25])
            //difference(){
               //cube(size=[66, 66, 1], center=true);
              // translate([0,0,-0.1]) cylinder(d1=58,d2=58,h=1,center=true,$fn=64);
            //}
            
         }
         translate([-25,-50,34]) for(i=[0,50]){
            for(j=[0,50]){
               translate([i,j,-1]) cylinder(d=3.5,h=5,center=true);
               translate([i,j,-0.5]) cylinder(d1=3.4,d2=6.5,h=1.6);
            }
         }
         translate([0,-25,34.6]) cylinder(d1=58,d2=64,h=2.5,center=true,$fn=64);
      }
      translate([0,-25,34.25]) fangrid();}
}
 module legend(){
   linear_extrude(height=0.4){
         //logo
         translate([-35,16,0])  text("Raspi 4",font="Rockwell:style=Bold",size=6);
   }}

if (assy == true) {

   lowerhalf();
   upperhalf_ed();


  translate([0,60.9,0]) color("darkblue") frontpanel();
  translate([0,-66.9,0]) rotate([-180,0,0]) color("darkblue") backpanel();

   translate([4,-36,-14.5]) pcb(RPI4);
   translate([0,-25,20]) rotate([0,0,0]) fan(fan60x25);
   translate([25,50.5,-15]) rotate([0,0,180]) hub();
   translate([25,50.56,-19.9]) rotate([0,0,180]) HUB_CONSOLE();
   translate([-40,65,14]) rotate([180,-90,90]) sdcardslot();
}
if(part=="unten") lowerhalf();
if(part=="oben") upperhalf_ed();
if(part=="frontpanel") frontpanel();
if(part=="backpanel") backpanel();
//frontpanel();

