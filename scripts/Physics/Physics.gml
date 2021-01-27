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
	
function apply_move(){
	hspd += h_move * walk_spd;
}

function cap_hspd(){
	hspd = sign(hspd) * min(abs(hspd), max_hspd);
}

function cap_vspd(){
	vspd = sign(vspd) * min(abs(vspd), max_vspd);
}

function apply_jump(){
	vspd = -jump_height;	
}

function on_ground(){
	if instance_exists(obj_climbable) and place_meeting(x, y + 1, obj_climbable) and v_move != 0 return true;
	if instance_exists(obj_climbable) and !place_meeting(x, y, obj_climbable) and place_meeting(x, y+1, obj_climbable) return true;
	if place_meeting(x, y + 1, obj_solid) return true;
	else return false;
}
	
function apply_climb(){
	vspd = v_move * -climb_spd;
}