
module schale(){
  
    
        difference(){
            linear_extrude(height=130){
            offset(delta=2){
                polygon(points=[[6,0],[64,0],[70,6],[70,64],[64,70],[6,70],[0,64],[0,6]], paths=[[0,1,2,3,4,5,6,7]]);
            }}
            translate([0,0,-0.5]) linear_extrude(height=131){
           polygon(points=[[6,0],[64,0],[70,6],[70,64],[64,70],[6,70],[0,64],[0,6]], paths=[[0,1,2,3,4,5,6,7]]);
        }
    }
}
rotate([90,0,0])
difference(){
    schale();
    rotate([5,0,0])translate([-2.1,20,-22]) cube([75,71,20]);
}