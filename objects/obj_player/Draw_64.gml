draw_set_font(fnt_tiny);
draw_set_color(c_white);

offset = 8;
draw_text(1+view_xport[0], view_yport[0]+offset*0, "h_move: " + string(h_move));
draw_text(1+view_xport[0], view_yport[0]+offset*1, "v_move: " + string(v_move));
draw_text(1+view_xport[0], view_yport[0]+offset*2, "jump: " + string(jump));
draw_text(1+view_xport[0], view_yport[0]+offset*3, "hspd: " + string(hspd));
draw_text(1+view_xport[0], view_yport[0]+offset*4, "vspd: " + string(vspd));
draw_text(1+view_xport[0], view_yport[0]+offset*6, "state: " + string(state));
draw_text(1+view_xport[0], view_yport[0]+offset*7, "dir: " + string(dir));
draw_text(1+view_xport[0], view_yport[0]+offset*8, "fireball_count: " + string(fireball_count));