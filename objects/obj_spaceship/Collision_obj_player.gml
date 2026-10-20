if (global.previous_room == rm_right) {
    return;
}

if (!instance_exists(obj_transition)) {
    var inst = instance_create_depth(0, 0, -9999, obj_transition);
    inst.target_room = rm_right;
    inst.target_x = 79;
    inst.target_y = 32;
}