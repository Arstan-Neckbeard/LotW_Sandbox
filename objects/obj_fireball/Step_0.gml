function kill_fireball(){
	parent.fireball_count = max(0, parent.fireball_count - 1);
	instance_destroy();
}

if die kill_fireball();
if place_meeting(x + hspeed, y + vspeed, obj_solid){
	hspd = hspeed;
	vspd = vspeed;
	h_collision();
	v_collision();
	die = true;
}
	
if life == 0{
	kill_fireball();
}else{
	life = max(0, life - 1);
}
