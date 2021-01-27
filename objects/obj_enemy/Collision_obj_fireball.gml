for (i=0; i < 360; i += 10){
	with instance_create_layer(x, y, "Enemies", obj_fireball){
		life = 3;
		direction = other.i;
		parent = other;
	}
}

instance_destroy();