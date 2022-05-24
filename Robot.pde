class Robot extends Enemy{
	// Requirement #5: Complete Dinosaur Class

	final int PLAYER_DETECT_RANGE_ROW = 2;
	final int LASER_COOLDOWN = 180;
	final int HAND_OFFSET_Y = 37;
	final int HAND_OFFSET_X_FORWARD = 64;
	final int HAND_OFFSET_X_BACKWARD = 16;
  
  float speed = 2;
  int direction = 1;
  int timer = 0;
  
  Laser laser;

	// HINT: Player Detection in update()
	/*

	boolean checkX = ( Is facing forward AND player's center point is in front of my hand point )
					OR ( Is facing backward AND player's center point (x + w/2) is in front of my hand point )

	boolean checkY = player is less than (or equal to) 2 rows higher or lower than me

	if(checkX AND checkY){
		Is laser's cooldown ready?
			True  > Fire laser from my hand!
			False > Don't do anything
	}else{
		Keep moving!
	}

	*/
  Robot(float x,float y){
    super(x,y);
    laser = new Laser();
  }
  
  void checkCollision(Player player){
    super.checkCollision(player);
    laser.checkCollision(player);
  }
  
  void display(){
    if(direction==-1){
      pushMatrix();
      translate(x + w, y);
      scale(-1,1);
      image(robot, 0, 0);
      popMatrix();
    }else{
      image(robot, x, y);
    }
    laser.display();
  }
  
  void update(){
    timer = (timer>0)?timer-1:0;
    if(playerDetection()){
      if(timer == 0){
        float originX;
        float originY = this.y + HAND_OFFSET_Y;
        float targetX = player.x + player.w/2;
        float targetY = player.y + player.h/2;
        if(laserFoward()){
          originX = x + HAND_OFFSET_X_FORWARD;
        }else{
          originX = x + HAND_OFFSET_X_BACKWARD;
        }
        laser.fire(originX, originY, targetX, targetY);
        timer = LASER_COOLDOWN;
      }
      laser.update();
    }else{
      x = x + speed * direction;
    }
    
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
    if(abs(player.y - this.y) <= PLAYER_DETECT_RANGE_ROW * SOIL_SIZE){
      return true;
    }
    return false;
  }
  
  Boolean laserFoward(){
    if(direction == 1 && player.x>this.x){
      return true;
    }else if(direction == -1 && player.x<this.x){
      return true;
    }
    return false;
  }
}
