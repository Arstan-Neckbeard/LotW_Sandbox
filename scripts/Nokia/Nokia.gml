function NOKIA_README() {
	/*

	Example project made by @Trixelized

	The macros n_white and n_black hold the color codes!
	They work just like the built in color codes (eg. c_red or make_color_rgb();)

	If you are going to change the resolution (for some reason)
	make sure to change them inside the init and room views as well!
	But the resolution should be good ;)

	nokia_play_sound makes all other sounds stop (because nokia sounds overlap)
	
	*/
}


function nokia_macros() {
#macro GAMEWIDTH		84
#macro GAMEHEIGHT		48
	

#macro log show_debug_message

#macro n_white 14217415
	// the white hex code is # c7f0d8
#macro n_black 4018755
	// the black hex code is # 43523d
}


function nokia_init(){
	// This will be ran in the 'rmInit' room's creation code,
	// Then it will immediately go to the next one.

	// This is just to initialize stuff (like setting the window scale etc)

	// Create the 'game' controller object
	instance_create_depth(0, 0, 0, obj_game_nokia);

	var _upscale = 8; // How much bigger should the window be
	window_set_size(GAMEWIDTH * _upscale, GAMEHEIGHT * _upscale);



	room_goto_next(); // leave init room
}


function nokia_play_sound(sound) {

	/*

	Nokia sounds all override eachother
	So uh this basically plays the sound and stops all others

	*/

	audio_stop_all();
	audio_play_sound(sound, 100, false);
}


function sleep(ms) {
	var t = current_time + ms;

	// This simulates lag!

	while (current_time < t) { }
}
