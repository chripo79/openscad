        /*-------------------------------------------
         |                                          |
         |     Fuss zm Verstauen carromm Brett       |
         |     Design : C. Pohl                     |
         |                                          |
         -------------------------------------------- */
 
// Model
difference(){
difference(){
    //grundkörper
    difference(){
        cube([40+3,31.5+6,40+3],center = true);
        translate([1.6,0,3])cube([40.1,31.5,40],center = true);
        };
    //ausnehmung f. filzgleiter
    translate([0,0,-((43/2)-0.3)]) cylinder(1,32.5/2,32.5/2,center=true,$fn=6);
    };
// verrundung
    difference(){
     translate([(23/2),-(45/2),23/2]) cube([30,45,30]);
    translate([(23/2),0,23/2])rotate([90,0,0]) cylinder(45,10,10,center=true);
    };
};
