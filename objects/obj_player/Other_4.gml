

if (!array_contains(no_movement_rooms, room)) {
    alarm[0] = 20;
}
if (array_contains(rocket_rooms, room)) {
    sprite_index = spr_player_rocket;
    mask_index = sprite_index;
    global.platforming = 0;
} else {
    if (array_contains(rocket_rooms, global.previous_room)) sprite_index = spr_player_idle_down;
    if (array_contains(platforming_rooms, room)) {
        global.platforming = 1;
        mask_index = spr_playercollision_plat;
    } else {
        mask_index = spr_playercollision_rpg;
    }
}


tilemap = layer_tilemap_get_id("Tiles_Col");
tilemap_oneway = layer_tilemap_get_id("Tiles_TopCol");

if (room == rm_space) {
    image_angle = rocket_start_angles[$ room_get_name(global.previous_room)]
    alarm[1] = 40;
}