{// Variable Variables
default_max_walk_spd = 2;
//default_max_run_spd = 4;
//default_max_jump_spd = 5;
default_max_fall_spd = 5;
default_climb_spd = 2;

default_walk_accel = 1;
//default_run_accel = 1;
default_jump_accel = 5;

default_grav_decel = .2;
default_jump_decel = .75;
default_fric_decel = .4;

def_fireball_max = 3;
}

{// Keyboard Variables

UP = ord("W");
DOWN = ord("S");
LEFT = ord("A");
RIGHT = ord("D");
JUMP = vk_numpad2;
FIRE = vk_numpad1;

RESTART_ROOM = ord("R");
RESTART_GAME = vk_escape;
}

{// System Variables
PLATFORMER_ENABLED = true;
CLIMBING_ENABLED = true;
JUMPTHROUGH_ENABLED = true;
CAP_JUMP = false;
CAP_FALL = true;
VARIABLE_JUMP = true;

IDLE = 0;
WALKING = 1;
JUMPING = 2;
FALLING = 3;
CLIMBING = 4;

h_move = 0;
jump = false;
vspd = 0;
hspd = 0;

fireball_count = 0;
dir = 0;

max_walk_spd = default_max_walk_spd;
//max_run_spd = default_max_run_spd;
//max_jump_spd = default_max_jump_spd;
max_fall_spd = default_max_fall_spd;
climb_spd = default_climb_spd;

walk_accel = default_walk_accel;
//run_accel = default_run_accel;
jump_accel = default_jump_accel;

fric_decel = default_fric_decel;
grav_decel = default_grav_decel;
jump_decel = default_jump_decel;

fireball_max = def_fireball_max;

state = IDLE;
image_speed = 0;
max_hspd = max_walk_spd;
max_vspd = max_fall_spd;
}
	
{// Functions
function change_state(new_state){
	state_prep(new_state);
	state = new_state;
}

function state_prep(new_state){
	switch new_state{
		
		case IDLE:
			image_speed = 0;
			vspd = 0;
			break;
			
		case WALKING:
			image_speed = 1;
			vspd = 0;
			break;
			
		case JUMPING:
			apply_jump();
		
		case FALLING:
			image_speed = 0;
			break;
		
		case CLIMBING:
			image_speed = 0;
			hspd = 0;
			vspd = 0;
			break;
			
	}
}

function get_input(){
	dir = get_direction()
	h_move = keyboard_check(RIGHT) - keyboard_check(LEFT);
	v_move = keyboard_check(UP) - keyboard_check(DOWN);
	jump = keyboard_check_pressed(JUMP);
	is_jumping = keyboard_check(JUMP);
	fire = keyboard_check_pressed(FIRE);
	is_firing = keyboard_check(FIRE);
	
	if fire != 0 shoot_fireball();
	
	if keyboard_check_pressed(RESTART_ROOM) room_restart();
	if keyboard_check_pressed(RESTART_GAME) game_restart();
}

function change_sprite(new_state){
	switch new_state{
		
		case WALKING:
			sprite_index = spr_player_walk_side;
			image_xscale = h_move;
			break;
		
		case CLIMBING:
			if v_move == 1 or near_climbable() sprite_index = spr_player_walk_up;
			else if not near_climbable() sprite_index = spr_player_walk_down;
			image_xscale = 1;
			break;
			
	}
}

function flip_sprite(){
	if h_move != 0 change_sprite(WALKING);
	if v_move != 0 change_sprite(CLIMBING);
}

function land(){
	if hspd == 0 and state != IDLE change_state(IDLE);
	else if  hspd != 0 and state != WALKING change_state(WALKING);
}
	
function near_climbable(){
	if collision_rectangle(bbox_left+8, bbox_top, bbox_right-8, bbox_bottom+1, obj_climbable, true, true){
		ladder = collision_rectangle(bbox_left+8, bbox_top, bbox_right-8, bbox_bottom+1, obj_climbable, true, true);
		if abs(ladder.x - x) <= 8 return true;
	}
	return false;
}
	
function get_direction(){
	if keyboard_check(RIGHT){
		if keyboard_check(DOWN) return 315;
		else if keyboard_check(UP) return 45;
		else return 0;
	}else if keyboard_check(LEFT){
		if keyboard_check(DOWN) return 225;
		else if keyboard_check(UP) return 135;
		else return 180;
	}else if keyboard_check(UP) return 90;
	else if keyboard_check(DOWN) return 270;
	else return dir;
}
	
function shoot_fireball(){
	if fireball_count < fireball_max{
		fireball_count += 1;
		with instance_create_layer(x, y, "Projectiles", obj_fireball){
			parent = other;
			direction = parent.dir;
			life = 45;
			if direction == 315 or direction == 0 or direction == 45 and sign(other.hspd) == 1 hspeed += other.hspd*.5;
			else if direction == 135 or direction == 180 or direction == 225 and sign(other.hspd) == -1 hspeed += other.hspd*.5;
			if direction == 45 or direction == 90 or direction == 135 and sign(other.vspd) == 1 vspeed += other.vspd*.5;
			else if direction == 225 or direction == 270 or direction == 315 and sign(other.vspd) == -1 vspeed += other.vspd*.5;
		}
	}
}

function state_idle(){
	get_input();
	flip_sprite();
	apply_hspd();
	apply_fric();
	cap_hspd();
	h_collision();
	if hspd != 0 change_state(WALKING);
	if not on_ground() and not on_ladder() and not on_jumpthrough() change_state(FALLING);
	if v_move == -1 and near_climbable() change_state(CLIMBING);
	if v_move == 1 and near_climbable() and place_meeting(x, y, obj_climbable) change_state(CLIMBING);
	if v_move == 0 and near_climbable() land();
	if jump == true change_state(JUMPING);
}

function state_walking(){
	get_input();
	flip_sprite();
	apply_hspd();
	apply_fric();
	cap_hspd();
	h_collision();
	if hspd == 0 change_state(IDLE);
	if not on_ground() and not on_ladder() and not on_jumpthrough() change_state(FALLING);
	if v_move == -1 and near_climbable() and !place_meeting(x, y+1, obj_solid) change_state(CLIMBING);
	if v_move == 1 and near_climbable() and place_meeting(x, y, obj_climbable) change_state(CLIMBING);
	if v_move == 0 and near_climbable() land();
	if jump == true change_state(JUMPING);
}

function state_jumping(){
	get_input();
	flip_sprite();
	apply_hspd();
	apply_fric();
	cap_hspd();
	h_collision();
	apply_grav();
	cap_vspd();
	v_collision();
	if on_ground() land();
	if v_move != 0 and near_climbable() change_state(CLIMBING);
	if vspd > 0 change_state(FALLING);
	else if !is_jumping jump_decrease();
}

function state_falling(){
	get_input();
	flip_sprite();
	apply_hspd();
	apply_fric();
	cap_hspd();
	h_collision();
	apply_grav();
	cap_vspd();
	falling_v_collision();
	if on_ground() or on_ladder() or on_jumpthrough() land();
	flip_sprite();
	if v_move != 0 and near_climbable() change_state(CLIMBING);
	if v_move == 0 and near_climbable() land();
}

function state_climbing(){
	get_input();
	image_speed = abs(v_move);
	flip_sprite();
	apply_hspd();
	apply_fric();
	cap_hspd();
	h_collision();
	apply_vspd();
	v_collision();
	if not place_meeting(x, y, obj_climbable) land();
	if jump == true change_state(JUMPING);
}

}