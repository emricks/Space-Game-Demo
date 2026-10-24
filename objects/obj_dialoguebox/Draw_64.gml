if (is_active) {
    var _current_id = dialogue_ids[current_index];
    var _text_to_draw = dialogues[$ string(_current_id)];
    
    draw_set_colour(c_white);
    draw_rectangle(50, 400, 910, 670, false);
    
    draw_set_colour(c_black);
    draw_rectangle(58, 408, 902, 662, false);
    
    draw_set_colour(c_white);
    draw_set_font(Font1)
    draw_sprite_ext(spr_npc_talk, 0, 90, 440, 4.3, 4.3, 0, c_white, 1);
    draw_text(300, 445, "*");
    
    var _array = string_split(_text_to_draw, "\n")
    
    for (var i = 0; i < array_length(_array); i++) {
        draw_text(360, 440+60*i, _array[i]);
    }
}