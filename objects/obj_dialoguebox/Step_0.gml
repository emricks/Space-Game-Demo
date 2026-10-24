if (cooldown > 0) {
    cooldown--;
}

if (is_active) {
    global.mobile = 0;
    if (keyboard_check_pressed(vk_enter)) {
        current_index++;
        
        if (current_index >= array_length(dialogue_ids)) {
            is_active = false;
            dialogue_ids = [];
            current_index = 0;
            cooldown = 10;
        }
    }
}