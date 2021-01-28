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


function falling_v_collision(){
	if CLIMBING_ENABLED and JUMPTHROUGH_ENABLED{
		repeat(abs(vspd)){
			if !place_meeting(x, y + sign(vspd), obj_climbable) and !place_meeting(x, y + sign(vspd), obj_jumpthrough) and !place_meeting(x, y + sign(vspd), obj_solid){
				y += sign(vspd);
			}else{
				vspd = 0;
				break;
			}
		}
	}else if CLIMBING_ENABLED{
		repeat(abs(vspd)){
			if !place_meeting(x, y + sign(vspd), obj_climbable) and !place_meeting(x, y + sign(vspd), obj_solid){
				y += sign(vspd);
			}else{
				vspd = 0;
				break;
			}
		}
	}else if JUMPTHROUGH_ENABLED{
		repeat(abs(vspd)){
			if !place_meeting(x, y + sign(vspd), obj_jumpthrough) and !place_meeting(x, y + sign(vspd), obj_solid){
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
		hspd = max(0, hspd - fric);
	}else if hspd < 0{
		hspd = min(0, hspd + fric);
	}
}


function apply_grav(){
	vspd += grav;
}


function apply_hspd(){
	hspd += h_move * walk_spd;
}


function cap_hspd(){
	hspd = sign(hspd) * min(abs(hspd), max_hspd);
}


function cap_vspd(){
	if CAP_JUMP and sign(vspd) == -1{
		vspd = max(vspd, (max_jump_spd));
	}
	
	if CAP_FALL and sign(vspd) == 1{
		vspd = min(vspd, max_fall_spd);
	}
}


function apply_jump(){
	vspd = -jump_height;	
}
	

function jump_decrease(){
	vspd *= jump_dec;
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


function apply_vspd(){
	if PLATFORMER_ENABLED{
		vspd = v_move * -climb_spd;
	}else{
		vspd = v_move * -walk_spd;
	}
}
