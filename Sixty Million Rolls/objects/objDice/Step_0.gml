if (keyboard_check_pressed(vk_space) && rolling == false && gooey == false && global.shop_opened == false && global.win == false) {
    
    var should_roll = true;
    
    if(global.hive_active == true && face == 6) {
        should_roll = false;
    }
    
    if(should_roll == true) {
        rolling = true;
        rolling_time = 40;
        audio_play_sound(sndRoll, 0, false);
        
    }
    
}

// Rolling animation
if (rolling == true) {
    image_index = irandom(5);
    image_angle += 15 + irandom(10); 
    rolling_time -= 1;
    
    if (rolling_time <= 0) {
        rolling = false;
        image_angle = 0; 
        image_index = irandom_range(global.flower_level, 5); 
        face = image_index + 1;
    }
}

// Sticky situations
if (gooey == true) {
    image_index = 5;
    face = 6;
    image_angle = 0;
    rolling = false;
}