
module base(size,num){
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






module crystal(size,height,sides,distort,ltip,wtip)
hull(){
   for(i=[0:1:height]){
      crr=rands(0,0.5,1)[0];
      translate([0,0,i]) rotate([crr*i,crr*i,distort*crr*i]) cylinder(d=size,h=0.1,$fn=sides);
   }
   translate([0,0,height+1]) cylinder(d1=size,d2=wtip,h=ltip,$fn=sides);
}
/* 
translate([0,0,8])crystal(12,15,5,43,4,0.5);
translate([-10,-10,0])base(20,3);
 */
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
   cube([10,10,100],center=true);