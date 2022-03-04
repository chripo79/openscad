
/*dimensions*/
// bohrbild befestigung

lax = 62;
lay = 24;
dmh = 2;
dlx = 16.6;
dly = 7.3;
PCB = [87.2,34.4,0.9];
USBPLUG = [13,13.1,5.5];
USBrim = [14,0.5,6.5];
USBtrough =[14,13.1,6.5];
console_body = [(PCB[0]+3),(PCB[1]+13.2),(PCB[2]+3)];

module rippe(Dicke){
  linear_extrude(Dicke){
    polygon([[0,0],[40,0],[40,8],[30,8],[0,4]]);
  }
}

module usbconn(){
color("silver")
union(){
      cube(USBPLUG);
      translate([-0.5,0,-0.5]) cube(USBrim);
    }
}
module hub(){

  difference(){
    color("green") cube(PCB);
    for(i=[dlx,(dlx+lax)]){
      for(j=[dly,(dly+lay)]){
        translate([i,j,0.2]) cylinder(d=dmh,h=2,center=true);
      }}
  }
    for (i= [0,20.3,(20.3+20.6),(20.3+20.6+20.3)]){
      translate([(10.1+(i)),-10.2,-1.1])  usbconn();
    }


  translate([87.2+10,7.8,-1.1]) rotate([0,0,90]) usbconn();
  translate([57.4,11,13.1]) rotate([-90,0,0]) usbconn();
  translate([23.2,11,13.1]) rotate([-90,0,0]) usbconn();
}

module screwholes_hub(diameter){
  translate([-4.5,-8,-1]) rotate([90,0,0]) cylinder(d=diameter,h=5,center=true,$fn=256);
  translate([91,-8,-1]) rotate([90,0,0]) cylinder(d=diameter,h=5,center=true,$fn=256);
}

module HUB_CONSOLE(){
  
  difference(){
    union(){
      difference(){
        translate([-1.5,-9.6,-1])cube(console_body);
       
      }
          for(i=[dlx,(dlx+lax)]){
          for(j=[dly,(dly+lay)]){
            translate([i,j,1]) cylinder(d=3,h=2,center=true);
          }
        }

        translate([-1.5-7,-9.6,-5]) cube([console_body[0]+14,3,8]);
      translate([-1.5,31,-1]) rotate([-90,0,-90]) rippe(1.5);
      translate([console_body[0]-3,31,-1]) rotate([-90,0,-90]) rippe(1.5);
    }

  
  for(i=[dlx,(dlx+lax)]){
      for(j=[dly,(dly+lay)]){
        translate([i,j,1]) cylinder(d=1.5 ,h=4,center=true);
      }
    }
  
  screwholes_hub(4.1);
  }
}
module distance(){
 difference(){
   cylinder(d=4, h=2, center=true);
   cylinder(d=2.3, h=2, center=true);
 }

}


hub();
HUB_CONSOLE();
distance();

