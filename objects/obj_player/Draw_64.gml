draw_set_font(fnt_tiny);
draw_set_color(c_white);

offset = 8;
draw_text(1+view_xport[0], view_yport[0]+offset*0, "h_move: " + string(h_move));
draw_text(1+view_xport[0], view_yport[0]+offset*1, "v_move: " + string(v_move));
draw_text(1+view_xport[0], view_yport[0]+offset*2, "jump: " + string(jump));
draw_text(1+view_xport[0], view_yport[0]+offset*3, "hspd: " + string(hspd));
draw_text(1+view_xport[0], view_yport[0]+offset*4, "vspd: " + string(vspd));
draw_text(1+view_xport[0]+48, view_yport[0]+offset*0, "state: " + string(state));
draw_text(1+view_xport[0]+48, view_yport[0]+offset*1, "dir: " + string(dir));
draw_text(1+view_xport[0], view_yport[0]+offset*8, "fireball_count: " + string(fireball_count));
draw_text(1+view_xport[0]+48, view_yport[0]+offset*2, "on_gr: " + string(on_ground()));
draw_text(1+view_xport[0]+48, view_yport[0]+offset*3, "on_cb: " + string(on_ladder()));
draw_text(1+view_xport[0]+48, view_yport[0]+offset*4, "on_jt: " + string(on_jumpthrough()));