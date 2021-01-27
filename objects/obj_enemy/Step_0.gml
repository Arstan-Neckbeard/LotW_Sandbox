switch state{
	
	case MOVING_LEFT:
		if x > left_dest{
			x-=1;
		}else{
			state = MOVING_RIGHT;
		}
		break;
		
	case MOVING_RIGHT:
		if x < right_dest{
			x+=1;
		}else{
			state = MOVING_LEFT;
		}
		break;
		
}