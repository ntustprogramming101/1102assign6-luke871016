class Dinosaur extends Enemy{
	// Requirement #4: Complete Dinosaur Class

	final float TRIGGERED_SPEED_MULTIPLIER = 5;
  final float ORIGIN_SPEED = 1;
  float speed = ORIGIN_SPEED;
  int direction = 1; // 1:face right -1:face left

	// HINT: Player Detection in update()
	/*
	float currentSpeed = speed
	If player is on the same row with me AND (it's on my right side when I'm going right OR on my left side when I'm going left){
		currentSpeed *= TRIGGERED_SPEED_MULTIPLIER
	}
	*/
  
  Dinosaur(float x, float y){
    super(x,y);
  }
  
  void display(){
    if(direction==-1){
      pushMatrix();
      translate(x + w, y);
      scale(-1,1);
      image(dinosaur, 0, 0);
      popMatrix();
    }else{
      image(dinosaur, x, y);
    }
  }

  void update(){
    if(playerDetection()){
      speed = ORIGIN_SPEED * TRIGGERED_SPEED_MULTIPLIER;
    }else{
      speed = ORIGIN_SPEED;
    }
    x = x + speed * direction;
    if(x+w > width){
      x = width-w;
      direction=-1;
    }
    if(x<0){
      x=0;
      direction=1;
    }
    
  }
  
  Boolean playerDetection(){
    if(player.y == this.y){
      if(direction==1 && player.x>this.x){
        return true;
      }else if(direction==-1 && player.x<this.x){
        return true;
      }
    }
    return false;
  }
}
