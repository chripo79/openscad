stem_h = 3.6;
union(){
translate([0,0,-stem_h/2])
   difference(){
      cylinder(h=stem_h,d=5.5,center=true,$fn=128);

      for(i=[0,90]){
         rotate([0,0,i])
            cube([4.2,1.3,stem_h],center=true);
      }
   }
difference(){
translate([0,0,1]) cube([16,16,2],center=true);
   for(i=[0:90:270]){
rotate([0,0,i])   
translate([0,8,2]) rotate([45,0,0]) cube([16,1*sqrt(2),1*sqrt(2)],center=true);}}

translate([0,0,-1.5])difference(){
   cube([16,16,3],center=true);
   cube([13,13,3],center=true);
   }
}