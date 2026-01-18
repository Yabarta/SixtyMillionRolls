draw_set_font(fntGame); 
draw_set_color(c_yellow);  
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_sprite(sprHoneycomb, 0, 40, 40);

draw_text(60, 20, "Honeycombs: " + string(global.honeycombs));