
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

translate([0,0,8])crystal(12,15,5,43,4,0.5);
translate([-10,-10,0])base(20,3);
