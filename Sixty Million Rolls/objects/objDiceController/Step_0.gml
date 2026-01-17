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

    if (stopped_dices == total_dices && dices_with_six == total_dices) {
        global.win = true;
        /*
        if (audio_is_playing(snd_musica_fondo)) {
            audio_stop_sound(snd_musica_fondo);
        }
        audio_play_sound(sndVictory, 100, false);
        */
        alarm[0] = 180; 
    }
}