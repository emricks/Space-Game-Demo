if (fade_alpha > 0) {
    draw_set_color(c_black);
    draw_set_alpha(fade_alpha);

    // Draw over the entire GUI layer view
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);

    draw_set_alpha(1); // Always reset alpha so it doesn't break other drawings
}