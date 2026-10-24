
interacting = keyboard_check_pressed(vk_enter);

if (distance_to_object(obj_player)<4 and interacting and !obj_dialoguebox.is_active and obj_dialoguebox.cooldown <= 0) {
    obj_dialoguebox.start_sequence([0, 1, 2]);
}