if (keyboard_check_pressed(vk_space) && rolling == false) {
    rolling = true;
    rolling_time = 40;
    if (instance_find(objDice, 9) == id) {
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
        image_index = irandom(5); 
        face = image_index + 1;
    }
}