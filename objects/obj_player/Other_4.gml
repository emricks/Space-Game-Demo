

if (array_contains(no_movement_rooms, room)) {
    global.mobile = 0;
} else {
    tilemap = layer_tilemap_get_id("Tiles_Col");
    alarm[0] = 20;
}
if (array_contains(platforming_rooms, room)) {
    global.platforming = 1;
    tilemap_oneway = layer_tilemap_get_id("Tiles_TopCol");
    mask_index = spr_playercollision_plat;
} else {
    global.platforming = 0;
    mask_index = spr_playercollision_rpg;
}
if (array_contains(rocket_rooms, room)) {
    sprite_index = spr_player_rocket;
    mask_index = spr_player_rocket;
} else {
    if (array_contains(rocket_rooms, global.previous_room)) sprite_index = spr_player_idle_down
}

if (room == rm_space) {
    image_angle = rocket_start_angles(rocket_to, rocket_from);
    alarm[1] = 40;
}

