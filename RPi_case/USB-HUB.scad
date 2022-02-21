
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

console_body = [(PCB[0]+3),(PCB[1]+3),(PCB[2]+3)];

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

module HUB_CONSOLE(){
  difference(){
    translate([-1.5,-1.5,-1])cube(console_body);
    resize([(PCB[0]+0.5),(PCB[1]+0.5),3])cube(console_body);
    hub();
  }
}

//hub();
HUB_CONSOLE();