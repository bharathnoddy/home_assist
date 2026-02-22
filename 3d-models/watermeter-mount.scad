// ESP32-CAM Water Meter Mount
// Adjustable camera distance and angle for DIY water meter reader
// Part of Home Assistant Phase 3 project
//
// Usage:
// 1. Measure distance from wall to water meter (typical: 100-150mm)
// 2. Adjust camera_distance parameter below
// 3. Render (F6) → Export as STL (F7)
// 4. Slice and print (PLA, 20% infill, supports enabled)
//
// Print time: ~3 hours
// Material: ~30g PLA
// Supports: Yes (for camera holder overhang)

// ===== PARAMETERS - ADJUST THESE =====
camera_distance = 120;  // Distance from mounting surface to meter (mm)
                        // Measure your setup and adjust: typically 100-150mm
mounting_width = 60;    // Width of mounting base (mm)
mounting_depth = 40;    // Depth of mounting base (mm)
wall_thickness = 3;     // Wall thickness (mm) - don't change unless needed

// ESP32-CAM board dimensions (standard - don't change)
board_width = 27;       // Width of ESP32-CAM board
board_length = 40;      // Length of ESP32-CAM board
board_height = 1.6;     // PCB thickness

// LED ring parameters (optional - for low-light conditions)
led_ring_diameter = 44;     // For 12-LED ring (standard size)
led_ring_thickness = 2;     // Thickness of LED ring holder

// ===== MODULES =====

// Main mounting bracket
// This is the base that attaches to wall or meter box
module mounting_base() {
    difference() {
        // Base plate
        cube([mounting_width, mounting_depth, wall_thickness]);

        // Mounting holes (for screws - M4 size)
        // Left hole
        translate([10, mounting_depth/2, -1])
            cylinder(h=wall_thickness+2, r=2, $fn=30);
        // Right hole
        translate([mounting_width-10, mounting_depth/2, -1])
            cylinder(h=wall_thickness+2, r=2, $fn=30);
    }
}

// Camera arm (extends toward meter)
// This connects the base to the camera holder
module camera_arm() {
    translate([mounting_width/2 - 15, 0, wall_thickness]) {
        cube([30, camera_distance, wall_thickness]);
    }
}

// ESP32-CAM holder
// Holds the ESP32-CAM board securely
module camera_holder() {
    translate([mounting_width/2 - board_width/2 - 2, camera_distance - 5, wall_thickness]) {
        difference() {
            // Outer box
            cube([board_width + 4, board_length + 10, 25]);

            // Inner cavity for board
            translate([2, 2, 2])
                cube([board_width, board_length + 6, 23]);

            // Camera lens opening (centered on board)
            translate([board_width/2 + 2, board_length/2, -1])
                cylinder(h=4, r=6, $fn=40);

            // USB-C cable slot at bottom
            translate([board_width/2 - 3, -1, 2])
                cube([6, 3, 10]);
        }

        // Side grips to hold board in place
        // Left grip
        translate([1, 2, 2])
            cube([1, board_length, 8]);
        // Right grip
        translate([board_width + 2, 2, 2])
            cube([1, board_length, 8]);
    }
}

// LED ring holder (optional - uncomment in assembly if needed)
// Provides illumination for low-light conditions
module led_ring_holder() {
    translate([mounting_width/2, camera_distance, wall_thickness + 12]) {
        difference() {
            // Outer ring
            cylinder(h=led_ring_thickness, r=led_ring_diameter/2 + 2, $fn=60);
            // Inner cutout for LEDs
            translate([0, 0, -1])
                cylinder(h=led_ring_thickness + 2, r=led_ring_diameter/2, $fn=60);

            // Wire slot for LED power cable
            translate([-2, led_ring_diameter/2 - 5, -1])
                cube([4, 10, led_ring_thickness + 2]);
        }
    }
}

// Cable management clip
// Keeps USB-C power cable organized
module cable_clip() {
    translate([mounting_width/2 - 5, camera_distance/2, wall_thickness]) {
        difference() {
            cube([10, 8, 5]);
            // Cable channel (for USB-C cable)
            translate([5, 4, 2])
                rotate([0, 0, 0])
                    cylinder(h=4, r=2.5, $fn=30);
        }
    }
}

// ===== ASSEMBLY =====
// Main components (always included)
mounting_base();
camera_arm();
camera_holder();
cable_clip();

// Optional components (uncomment if needed)
// Uncomment the line below if using LED ring for illumination:
// led_ring_holder();

// ===== NOTES =====
//
// Mounting options:
// 1. Wall mount: Use M4 screws through mounting holes
// 2. Double-sided tape: For rental properties or non-permanent install
// 3. Custom clips: Modify mounting_base() to add clips for your meter box
//
// Print settings:
// - Layer height: 0.2mm
// - Infill: 20%
// - Supports: Yes (needed for camera holder overhang)
// - Material: PLA (sufficient for indoor use)
// - Print time: ~3 hours
// - Weight: ~30g
//
// Assembly:
// 1. Print this mount
// 2. Insert ESP32-CAM into camera holder (slides in from top)
// 3. Route USB-C cable through cable clip
// 4. Position mount so camera is 10-15cm from meter face
// 5. Ensure meter dials are centered in camera view
// 6. Secure mount to wall or meter box
// 7. Connect USB-C power
//
// Troubleshooting:
// - If board doesn't fit: Check board_width and board_length measurements
// - If mount is wobbly: Increase wall_thickness or add more mounting holes
// - If camera angle is wrong: Adjust camera_distance parameter
//
// Part of: Home Automation Phase 3 - DIY Water Meter Reader
// See: /docs/water-meter-setup.md for full setup instructions
