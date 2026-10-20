if (sprite_index == spr_player_rocket && !array_contains(rocket_rooms, room)) {
    sprite_index = spr_player_idle_down;

}
if (sprite_index == spr_player_rocket && path_index != -1) {
    pathframe++;
    if (pathframe > 1) {
        image_angle = direction-90;
    }
}
if (sprite_index != spr_player_rocket) {
    image_angle = 0;
}

show_debug_message(string(sprite_index));

if (global.platforming == 0) {
    normal_step();
} else {
    platformer_step();
}

if (pathframe != 0 && path_index == -1) {
    pathframe = 0;
}