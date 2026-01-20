if (global.flower_level > 0) {
    var _frame = global.flower_level - 1;
    if (_frame > 2) _frame = 2;
    
    draw_sprite(sprFlower1, _frame, flower_x, flower_y);
}

if (global.bee_level > 0) {
    var _frame = global.bee_level - 1;
    if (_frame > 2) _frame = 2;
    
    draw_sprite(sprBee1, _frame, bee_x, bee_y);
}

if (global.hive == true) {
    if (global.hive_active == true) {
        draw_sprite(sprHive, 0, hive_x, hive_y);
    } else {
        draw_sprite(sprHive, 1, hive_x, hive_y);
    }
    
}