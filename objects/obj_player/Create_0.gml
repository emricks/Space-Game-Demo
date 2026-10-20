total_minutes = 882;
total_hours = 14.7;
move_speed = 1; 
global.mobile = 1;
global.platforming = 0;
global.testroom = rm_left;
vel_y = 0;
coyote_max_frames = 5;
coyote_timer = 5;
pathframe = 0;

// Git testing arbitrary file change
jump_speed = -5.3; 
max_fall_speed = 6; 
grav_power = 0.25;


running = 0;
tilemap = layer_tilemap_get_id("Tiles_Col");
tilemap_oneway = layer_tilemap_get_id("Tiles_TopCol");

no_movement_rooms = [rm_space];
rocket_rooms = [rm_space];
platforming_rooms = [rm_planet];

rocket_start_angles = {
    "rm_right": -90,
    "rm_planet": 90
}

move_player_debug_room = function(startx, starty) {if (global.previous_room == rm_origin) {
    obj_player.x = startx;
    obj_player.y = starty;
}}

normal_step = function() { 
    var _vert = keyboard_check(vk_down)-keyboard_check(vk_up);
    var _horiz = keyboard_check(vk_right)-keyboard_check(vk_left);
    var running = keyboard_check(ord("S"));
       
       if (running) {move_speed = 1.5;}
           else move_speed = 1
               
       image_speed = 1+running/2;
               
       if (global.mobile != 1) {
           move_speed = 0;
       }
       
       move_and_collide(move_speed*_horiz, move_speed*_vert, tilemap, undefined, undefined, undefined, move_speed, move_speed) ;
       
       if (array_contains(rocket_rooms, room)) {
           sprite_index = spr_player_rocket;
       } else if (_vert != 0 or _horiz != 0 or global.mobile = 0) {
           if (_vert > 0) sprite_index = spr_player_walk_down;
               else if (_vert < 0) sprite_index = spr_player_walk_up;
                   else if (_horiz > 0) sprite_index = spr_player_walk_right;
                       else if (_horiz < 0) sprite_index = spr_player_walk_left;
       } else {
           if (sprite_index == spr_player_rocket) sprite_index = spr_player_idle_down;
           if (sprite_index == spr_player_walk_down) sprite_index = spr_player_idle_down;
               else if (sprite_index == spr_player_walk_up) sprite_index = spr_player_idle_up
                   else if (sprite_index == spr_player_walk_right) sprite_index = spr_player_idle_right;
                       else if (sprite_index == spr_player_walk_left) sprite_index = spr_player_idle_left;
       }
}

platformer_step = function() {
    move_speed = 2;
    
    // 1. Get Inputs
    var _move = (keyboard_check(vk_right) - keyboard_check(vk_left)) * global.mobile;
    var _jumped = keyboard_check_pressed(vk_up) * global.mobile;
    
    // 2. Horizontal Movement & Collision (Only checks solid terrain)
    vel_x = _move * move_speed;
    
    var _h_dir = sign(vel_x);
    if (_h_dir != 0) {
        repeat (abs(vel_x)) {
            if (!place_meeting(x + _h_dir, y, tilemap)) {
                x += _h_dir;
            } else {
                vel_x = 0;
                break;
            }
        }
    }
    
    // 3. Vertical Movement, Gravity & Coyote Time
    var _on_solid = place_meeting(x, y + 1, tilemap);
    var _on_oneway = false;
    
    // Check if we are already touching or resting on a one-way platform (bbox_bottom)
    if (vel_y >= 0 && bbox_bottom <= room_height) {
        var _tile_size = 16;
        var _cx1 = bbox_left;
        var _cx2 = bbox_right;
        var _cy = bbox_bottom; // Changed from bbox_bottom + 1 to exact bottom
        
        var _t1 = tilemap_get_at_pixel(tilemap_oneway, _cx1, _cy);
        var _t2 = tilemap_get_at_pixel(tilemap_oneway, _cx2, _cy);
        
        if (_t1 != 0 || _t2 != 0) {
            var _tile_top = (_cy div _tile_size) * _tile_size;
            if (bbox_bottom == _tile_top) {
                _on_oneway = true;
            }
        }
    }
    
    var _onground = _on_solid || _on_oneway;
    
    if (_onground) {
        coyote_timer = coyote_max_frames;
        if (_on_solid) vel_y = 0; // Only zero out immediately for solids; let Step 5 handle one-way snaps
    } else {
        if (coyote_timer > 0) {
            coyote_timer--;
        }
        
        vel_y += grav_power;
        if (vel_y > max_fall_speed) {
            vel_y = max_fall_speed;
        }
    }
    
    // 4. Jumping
    if (coyote_timer > 0 && _jumped) {
        vel_y = jump_speed;
        coyote_timer = 0; 
    }
    
    // 5. Vertical Collision Loop (With Snapping)
    var _v_dir = sign(vel_y);
    if (_v_dir != 0) {
        repeat (abs(vel_y)) {
            var _hit_solid = place_meeting(x, y + _v_dir, tilemap);
            var _hit_oneway = false;
            var _tile_top = 0;
            
            // ONLY check one-way collision if moving down AND still inside the room
            if (_v_dir > 0 && (bbox_bottom + _v_dir) < room_height) {
                var _cx1 = bbox_left;
                var _cx2 = bbox_right;
                var _cy_check = bbox_bottom + _v_dir;
                
                var _t1 = tilemap_get_at_pixel(tilemap_oneway, _cx1, _cy_check);
                var _t2 = tilemap_get_at_pixel(tilemap_oneway, _cx2, _cy_check);
                
                if (_t1 != 0 || _t2 != 0) {
                    _tile_top = (_cy_check div 16) * 16;
                    if (bbox_bottom <= _tile_top) {
                        _hit_oneway = true;
                    }
                }
            }
            
            if (!_hit_solid && !_hit_oneway) {
                y += _v_dir;
            } else {
                // If we hit a one-way platform, snap flush to the top edge
                if (_hit_oneway) {
                    y = _tile_top - (bbox_bottom - y);
                }
                vel_y = 0;
                break;
            }
        }
    }
    
    // 6. Room Bounds / Fall-Out Reset
    // If the player falls past the bottom of the room + a 32-pixel buffer
    if (y > room_height + 64) {
        x = 32;
        y = 124;
        vel_x = 0;
        vel_y = 0; // Reset velocity so they don't keep falling upon respawn
    }
    
    // 7. Sprite Animation Handling
    if (_move < 0) {
        sprite_index = spr_player_walk_left;
    } else if (_move > 0) {
        sprite_index = spr_player_walk_right;
    } else {
        if (sprite_index == spr_player_walk_left) {
            sprite_index = spr_player_idle_left;
        } else if (sprite_index == spr_player_walk_right) {
            sprite_index = spr_player_idle_right;
        }
    }
}
