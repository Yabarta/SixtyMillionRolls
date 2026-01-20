if (global.shop_opened == true) {
    // --- 1. FONDO GENERAL Y BOTÓN DE CIERRE ---
    draw_set_alpha(0.8);
    draw_set_color(c_black);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    draw_set_alpha(1);
    
    // Botón de tienda (para cerrar)
    var _btn_x = 598; 
    var _btn_y = 16;
    draw_sprite(sprShop, 0, _btn_x, _btn_y);

    // --- 2. CONFIGURACIÓN DEL GRID ---
    var _gui_w = display_get_gui_width();
    var _gui_h = display_get_gui_height();
    
    var _panel_w = 256;
    var _panel_h = 96;
    
    // Variables temporales que se reutilizarán en cada vuelta del bucle
    var _curr_panel_x, _curr_panel_y;
    var price, product, description, button_text;
    var current_level, icon_sprite;
    
    // --- 3. BUCLE PARA DIBUJAR LOS 4 PANELES ---
    for (var i = 0; i < 4; i++) {
        
        var _col = (i % 2); 
        var _row = floor(i / 2); 
        
        _curr_panel_x = ((_gui_w / 2) * _col) + ((_gui_w / 4) - (_panel_w / 2));
        _curr_panel_y = ((_gui_h / 2) * _row) + ((_gui_h / 4) - (_panel_h / 2));
        
        // --- B. DEFINIR DATOS SEGÚN EL PRODUCTO (i) ---
        price = 0;
        product = "";
        description = "";
        current_level = 0;
        icon_sprite = sprHoneyShop; 
        
        switch (i) {
            case 0: // --- MIEL ---
                product = "Honey";
                current_level = global.honey_level;
                icon_sprite = sprHoneyShop; 
                switch (current_level) {
                    case 0: price = 60; description = "Permanent 6 on 1st dice."; break;
                    case 1: price = 330; description = "Permanent 6 on 2nd dice."; break;
                    case 2: price = 850; description = "Permanent 6 on 3rd dice."; break;
                    default: price = -1; description = "Full of honey!"; break;
                }
                break;
                
            case 1: // --- FLORES ---
                product = "Flower";
                current_level = global.flower_level; 
                icon_sprite = sprFlowerShop; 
                switch (current_level) {
                    case 0: price = 120; description = "Remove all 1s."; break;
                    case 1: price = 700; description = "Remove all 2s."; break;
                    case 2: price = 1500; description = "Remove all 3s."; break;
                    default: price = -1; description = "Garden complete!"; break;
                }
                break;
                
            case 2: // --- PRODUCTO 3 (FUTURO) ---
                product = "Bee";
                current_level = global.bee_level;
                icon_sprite = sprBeeShop;
                switch (current_level) {
                    case 0: price = 100; description = "Earn x2 Honeycombs."; break;
                    case 1: price = 600; description = "Earn x3 Honeycombs."; break;
                    case 2: price = 1060; description = "Earn x4 Honeycombs."; break;
                    default: price = -1; description = "All bees are busy!"; break;
                }
                break;
                
            case 3: // --- PRODUCTO 4 (FUTURO) ---
                product = "Hive";
                icon_sprite = sprHiveShop;
                if (global.hive == true) {
                    price = -1; description = "Hive is already on your table!"; 
                } else {
                    price = 2000; description = "Second roll keeping your 6s."; 
                }
                break;
        }

        // --- C. DIBUJAR PANEL ---
        draw_set_color(c_maroon);
        draw_rectangle(_curr_panel_x, _curr_panel_y, _curr_panel_x + _panel_w, _curr_panel_y + _panel_h, false);
        draw_set_color(c_white);
        draw_rectangle(_curr_panel_x, _curr_panel_y, _curr_panel_x + _panel_w, _curr_panel_y + _panel_h, true);
        
        // Icono
        var _icon_x = _curr_panel_x + 40;
        var _icon_y = _curr_panel_y + 32;
        draw_sprite_ext(icon_sprite, 0, _icon_x, _icon_y, 2, 2, 0, c_white, 1);
        
        // Textos
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        draw_set_font(fntGameSmall); 
        draw_text_ext(_curr_panel_x + 76, _curr_panel_y + 10, product, 25, _panel_w - 80);
        
        draw_set_font(fntGameSmall); 
        draw_text_ext(_curr_panel_x + 12, _curr_panel_y + 60, description, 14, _panel_w - 24);

        // --- D. BOTÓN DE COMPRA ---
        var _bx = _curr_panel_x + 180;
        var _by = _curr_panel_y + 16;
        var _ancho_b = 68;
        var _alto_b = 32;
        var button_color = c_white;

        if (price == -1) {
            button_color = c_gray;
            button_text = "Max level";
        } else if (global.honeycombs >= price) {
            button_color = c_yellow;
            button_text = "Buy: " + string(price);
        } else {
            button_color = c_olive; 
            button_text = "Buy: " +string(price);
        }
        
        draw_set_color(button_color);
        draw_rectangle(_bx, _by, _bx + _ancho_b, _by + _alto_b, false);
        
        draw_set_color(c_black);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_set_font(fntGameSmall); 
        draw_text(_bx + _ancho_b/2, _by + _alto_b/2, button_text);
        
        // --- E. DETECTAR CLIC ---
        var _mx = device_mouse_x_to_gui(0);
        var _my = device_mouse_y_to_gui(0);
        
        if (mouse_check_button_pressed(mb_left)) {
            if (_mx > _bx && _mx < _bx + _ancho_b && _my > _by && _my < _by + _alto_b) {
                
                if (price != -1 && global.honeycombs >= price) {
                    global.honeycombs -= price;
                    if (i == 0) { 
                        audio_play_sound(sndPurchase, 0, false);
                        var dice_to_stick = instance_find(objDice, global.honey_level);
                        if (dice_to_stick != noone) dice_to_stick.gooey = true;
                        global.honey_level += 1;
                    }
                    else if (i == 1) { 
                        audio_play_sound(sndPurchase, 0, false);
                        global.flower_level += 1;
                    }
                    else if (i == 2) {
                        audio_play_sound(sndPurchase, 0, false);
                        global.bee_level += 1;
                        global.multiplyer += 1;
                    }
                    else if (i == 3) {
                        global.hive = true;
                    }
                }
            }
        }
    } 
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}