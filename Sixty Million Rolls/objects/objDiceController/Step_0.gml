if (global.win == false) {
    
    var stopped_dices = 0;
    var dices_with_six = 0;
    var total_dices = instance_number(objDice);

    with (objDice) {
        if (rolling == false) {
            stopped_dices += 1;
            if (face == 6) {
                dices_with_six += 1;
            }
        }
    }
    
    if (stopped_dices == total_dices) {
        if (roll_processed == false) {
        
            var money = dices_with_six * global.multiplyer;
            global.honeycombs += money;
            global.rolls += 1;
            
            if (dices_with_six == total_dices) {
                global.rolls += 1;
                global.win = true;
                if (audio_is_playing(sndGameMusic)) {
                   audio_stop_sound(sndGameMusic);
                }
                audio_play_sound(sndVictory, 100, false);
                alarm[0] = 180; 
                global.hive_active = false;
            } else {
                if (global.hive == true && global.hive_active == false) {
                    global.hive_active = true;
                } else {
                    global.hive_active = false;
                }
            }

            roll_processed = true;
        }

    } else {
        roll_processed = false;
    }
}