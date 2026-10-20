// Progress the fade depending on the state
fade_alpha += fade_speed * fade_state;

// If fully faded to black, switch rooms and position player
if (fade_alpha >= 1 && fade_state == 1) {
    fade_alpha = 1;
    fade_state = -1; // Change state to fade back in

    if (room_exists(target_room)) {
        room_goto(target_room);

        // Move player to the new target position if player exists
        if (instance_exists(obj_player)) {
            obj_player.x = target_x;
            obj_player.y = target_y;
        }
    }
}

// If fully faded back in, destroy the transition object
if (fade_alpha <= 0 && fade_state == -1) {
    instance_destroy();
}