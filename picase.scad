
module schale(){
    difference(){
        linear_extrude(height=120){
            difference(){
                polygon(points=[[5,0],[110,0],[115,10],[115,35],[110,45],[5,45],[0,35],[0,10]], paths=[[0,1,2,3,4,5,6,7]]);
                offset(delta=-2){
                    polygon(points=[[5,0],[110,0],[115,10],[115,35],[110,45],[5,45],[0,35],[0,10]], paths=[[0,1,2,3,4,5,6,7]]);
                }
            }
        }


        rotate([0,-90,0]) translate([0,0,-122]) linear_extrude(height=123){
            polygon(points=[[-0.1,-0.01],[20.1,45.1],[-0.10,45.1]],paths=[[0,1,2]]);
        }
    }
}
difference(){
    schale();
   
   translate([-0.1,-0.10,0])cube([116,47/2,128]);

}

translate([-0,-20,2]){difference(){
    schale();
    translate([-0.1,45/2,0])cube([116,45.1/2,128]);

}}