// Esto se ejecuta antes que nada
function reset_game() {
    randomize();

    global.win = false;
    global.rolls = -1;
    global.music_playing = noone;
    global.honeycombs = 0;
    global.multiplyer = 1;
    global.shop_opened = false;

    global.honey_level = 0
    global.max_honey_level = 3;

    global.flower_level = 0;
    global.max_flower_level = 0;

    global.bee_level = 0;
    global.max_bee_level = 3;

    global.hive = false;
    global.hive_active = false;
}