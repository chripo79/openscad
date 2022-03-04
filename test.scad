use <MbcPrettyCase.scad>
use <partholders.scad>
/* module base(size,num){
   difference(){
      union(){
         for(i=[-num:1:num]){
            rdx=rands(0.2,10,1)[0];
            rdz=rands(0.2,10,1)[0];
            rdy=rands(0.2,10,1)[0];
            translate([rdx,rdy,(rdz)/2]) rotate([i*rdx,i*rdy,i*rdz])
            cube(size,center=true);
         }
      }
   translate([-50*size,-50*size,-100*size],center=true)cube(100*size);
   }
}
*/
mbc_size = 100;
   //mbc_board_thick = 1.6;
   mbc_hole_dist = 4;
   mbc_hole_space = 92;
   mbc_hole_dia=3;
   led_dist =47.7;
   led_space=9;
   btn_dist =17;
   btn_space=18;
 //Panel Dicke
   panel_t= 2;
//Flanschdicke
   flange_b=2;
//flanschweite(Höhe)
   flange_t = 2.5;

/*

module crystal(size,height,sides,distort,ltip,wtip)
hull(){
   for(i=[0:1:height]){
      crr=rands(0,0.5,1)[0];
      translate([0,0,i]) rotate([crr*i,crr*i,distort*crr*i]) cylinder(d=size,h=0.1,$fn=sides);
   }
   translate([0,0,height+1]) cylinder(d1=size,d2=wtip,h=ltip,$fn=sides);
}

translate([0,0,8])crystal(12,15,5,43,4,0.5);
translate([-10,-10,0])base(20,3);

module facets_faces(){
   r_corner =1; // =height/2
   sqare=10;//real width/lenght=square+rcorner
   hull(){
      for(i=[0:4]) rotate([0,90,90*i]) translate([0,(sqare/2)-(r_corner/1),0]) cylinder(h=sqare-(r_corner*2),d=r_corner*2,center=true,$fn=32);
      for(i=[0:4]) rotate([0,0,90*i]) translate([(sqare/2)-(r_corner/1),(sqare/2)-(r_corner/1),0]) sphere(r_corner,$fn=32);
   }
}
translate([5,5,0]) facets_faces();
rotate([0,45,0])
rotate([90,0,0])
   cube([10,10,100],center=true); */


//frontpanel();

/* module senkloch(th,l,sd,ed){ //th: durchgangsbohrung, bohngstiefe ,sd: enkdurchmesser, ed:extratiefe
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

difference(){
   union(){
      fwpanel();
      translate([50,-1.5,0])cube([12,1,30],center=true);
   }
   
   translate([50,0.8,0])rotate([90,90,0]) subDcutout();
   for(i=[0:18])
      translate([25-(4*i),-2,-12]) cube([2,4,25]);
}
 */   
/* difference(){

 union(){
    cube([42,26,16]);
   translate([42-5,-(45-26)/2,0])cube([5,45,16]);
 }
 translate([0,2,2])cube([40,22,12]);
} */

 /*module frontpanel(){

      

   }
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
      */
   Pt_pol =[]
   polygon(Pt_pol);
   