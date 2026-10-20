if (global.previous_room == rm_right) {
    path_start(path_flying_to_planet, 2, path_action_stop, true);
} else if (global.previous_room == rm_planet) {
    path_start(path_flying_from_planet, 2, path_action_stop, true);
}