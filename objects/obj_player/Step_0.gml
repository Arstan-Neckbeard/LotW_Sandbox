switch state{
	
	case IDLE:
		state_idle();
		break;
		
	case WALKING:
		state_walking();
		break;
	
	case JUMPING:
		state_jumping();
		break;
	
	case FALLING:
		state_falling();
		break;
		
	case CLIMBING:
		state_climbing();
		break;
		
}
