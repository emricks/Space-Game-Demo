global.mobile = 0;
if (!instance_exists(obj_transition)) {
    var inst = instance_create_depth(0, 0, -9999, obj_transition);
    inst.target_room = target_room
    inst.target_x = target_x;
    inst.target_y = target_y;
    obj_player.rocket_to = rocket_to;
    obj_player.rocket_from = rocket_from;
}