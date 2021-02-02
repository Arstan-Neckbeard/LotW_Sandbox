function h_collision(){
	repeat(abs(hspd)){
		if !place_meeting(x + sign(hspd), y, obj_solid){
			x += sign(hspd);
		}else{
			hspd = 0;
			break;
		}
	}
}


function v_collision(){
	repeat(abs(vspd)){
		if !place_meeting(x, y + sign(vspd), obj_solid){
			y += sign(vspd);
		}else{
			vspd = 0;
			break;
		}
	}
}

/*
function falling_v_collision(){
	if CLIMBING_ENABLED and JUMPTHROUGH_ENABLED{
		repeat(abs(vspd)){
			if !collision_line(x-(sprite_width*.375), bbox_bottom+sign(vspd), x+(sprite_width*.375), bbox_bottom+sign(vspd), obj_climbable, true, true) and !collision_line(x-6, bbox_bottom+sign(vspd), x+6, bbox_bottom+sign(vspd), obj_jumpthrough, true, true) and !place_meeting(x, y + sign(vspd), obj_solid){
				y += sign(vspd);
			}else{
				vspd = 0;
				break;
			}
		}
	}else if CLIMBING_ENABLED{
		repeat(abs(vspd)){
			if !collision_line(x-(sprite_width*.375), bbox_bottom+sign(vspd), x+(sprite_width*.375), bbox_bottom+sign(vspd), obj_climbable, true, true) and !place_meeting(x, y + sign(vspd), obj_solid){
				y += sign(vspd);
			}else{
				vspd = 0;
				break;
			}
		}
	}else if JUMPTHROUGH_ENABLED{
		repeat(abs(vspd)){
			if !collision_line(x-(sprite_width*.375), bbox_bottom+sign(vspd), x+(sprite_width*.375), bbox_bottom+sign(vspd), obj_jumpthrough, true, true) and !place_meeting(x, y + sign(vspd), obj_solid){
				y += sign(vspd);
			}else{
				vspd = 0;
				break;
			}
		}
	}else{
		v_collision();
	}
}
*/

function falling_v_collision(){
	if CLIMBING_ENABLED and JUMPTHROUGH_ENABLED{
		repeat(abs(vspd)){
			if !collision_line(bbox_left, bbox_bottom+sign(vspd), bbox_right, bbox_bottom+sign(vspd), obj_climbable, true, true) and !collision_line(bbox_left, bbox_bottom+sign(vspd), bbox_right, bbox_bottom+sign(vspd), obj_jumpthrough, true, true) and !place_meeting(x, y + sign(vspd), obj_solid){
				y += sign(vspd);
			}else{
				vspd = 0;
				break;
			}
		}
	}else if CLIMBING_ENABLED{
		repeat(abs(vspd)){
			if !collision_line(bbox_left, bbox_bottom+sign(vspd), bbox_right, bbox_bottom+sign(vspd), obj_climbable, true, true) and !place_meeting(x, y + sign(vspd), obj_solid){
				y += sign(vspd);
			}else{
				vspd = 0;
				break;
			}
		}
	}else if JUMPTHROUGH_ENABLED{
		repeat(abs(vspd)){
			if !collision_line(bbox_left, bbox_bottom+sign(vspd), bbox_right, bbox_bottom+sign(vspd), obj_jumpthrough, true, true) and !place_meeting(x, y + sign(vspd), obj_solid){
				y += sign(vspd);
			}else{
				vspd = 0;
				break;
			}
		}
	}else{
		v_collision();
	}
}

function apply_fric(){
	if hspd > 0{
		hspd = max(0, hspd - fric_decel);
	}else if hspd < 0{
		hspd = min(0, hspd + fric_decel);
	}
}


function apply_grav(){
	vspd += grav_decel;
}


function apply_hspd(){
	hspd += h_move * walk_accel;
}


function cap_hspd(){
	hspd = sign(hspd) * min(abs(hspd), max_hspd);
}


function cap_vspd(){
	if CAP_JUMP and sign(vspd) == -1{
		vspd = max(vspd, (max_vspd));
	}
	
	if CAP_FALL and sign(vspd) == 1{
		vspd = min(vspd, max_vspd);
	}
}


function apply_jump(){
	vspd = -jump_accel;	
}
	

function jump_decrease(){
	vspd *= jump_decel;
}


function on_ground(){
	if place_meeting(x, y + 1, obj_solid){
		return true;
	}
	
	return false;
}


function on_ladder(){
	if CLIMBING_ENABLED{
		if place_meeting(x, y + 1, obj_climbable) and v_move != 0{
			return true;
		}
		
		if !place_meeting(x, y, obj_climbable) and place_meeting(x, y+1, obj_climbable){
			return true;
		}
		
		return false;
	}
}


function on_jumpthrough(){
	if JUMPTHROUGH_ENABLED{
		if place_meeting(x, y + 1, obj_jumpthrough) and v_move != 0{
			return true;
		}
		
		if !place_meeting(x, y, obj_jumpthrough) and place_meeting(x, y+1, obj_jumpthrough){
			return true;
		}
		
		if place_meeting(x, y, obj_jumpthrough) and place_meeting(x, y+1, obj_jumpthrough) and (collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, obj_jumpthrough, true, true) != collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom+1, obj_jumpthrough, true, true)){
			return true;
		}

		return false;
	}
}

/*
function apply_vspd(){
	if PLATFORMER_ENABLED{
		vspd = v_move * -climb_spd;
	}else{
		vspd = v_move * -walk_accel;
	}
}
*/

function apply_vspd(){
	if PLATFORMER_ENABLED and place_meeting(x, y, obj_climbable) and v_move = 1{
		vspd = v_move * -climb_spd;
	}else if PLATFORMER_ENABLED and place_meeting(x, y+1, obj_climbable) and v_move = -1{
		vspd = v_move * -climb_spd;
	}else{
		vspd = v_move * -walk_accel;
	}
}