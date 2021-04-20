PImage bg, soil, life, groundhogIdle, soldier, cabbage;
PImage title,gameover,restartNormal,startNormal, startHovered, restartHovered;

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_OVER = 2;
int gameState = GAME_START;

int x,y;
int r,g,b;
int block=80;

int lifeX = -60;
int life_block = 70;

int groundhogIdle_W = block, groundhogIdle_H = block;
int groundhogIdleX = block*4;
int groundhogIdleY = block ;

int soldier_W = block, soldier_H = block;
int soldierX;
int soldierY = block*floor(random(2,6)) ;
int soldierXSpeed = 3;

int cabbageX =  block*floor(random(0,9));
int cabbageY =  block*floor(random(2,6));

int button_L = 248, button_R = 248+144;
int button_T = 360, button_D = 360+60;


void setup() {
	size(640, 480, P2D);
	// Enter Your Setup Code Here
  bg = loadImage("img/bg.jpg");
  soil = loadImage("img/soil.png");
  life = loadImage("img/life.png");
  groundhogIdle = loadImage("img/groundhogIdle.png");
  soldier = loadImage("img/soldier.png");
  gameover = loadImage("img/gameover.jpg");
  cabbage = loadImage("img/cabbage.png");
  title = loadImage("img/title.jpg");
  restartNormal = loadImage("img/restartNormal.png");
  startNormal = loadImage("img/startNormal.png");
  startHovered = loadImage("img/startHovered.png");
  restartHovered = loadImage("img/restartHovered.png");
}

void draw() {
  // Switch Game State
  switch(gameState) {
    // Game Start
    case GAME_START:
      image(title, 0, 0);
      image(startNormal, 248, 360);
      if( mouseX > button_L && mouseX < button_R && 
           mouseY > button_T && mouseY < button_D){
           image( startHovered, 248, 360); 
           if(mousePressed){
             gameState = GAME_RUN;
           }}
    break;
    
    // Game Run
    case GAME_RUN:
  background(bg);
  image(soil, 0, block*2);
  
  //life
  image(life, lifeX,10);
  image(life, lifeX+life_block,10);
  image(life, lifeX+life_block*2,10);

  //grass
  noStroke();
  colorMode(RGB);
  fill(124,204,25);
  rect(0,block*2-15, width, 15); 
  //sun
  fill(255, 255, 0);
  ellipse(width-50, y+50,130,130);
  fill(253, 184, 19);
  ellipse(width-50, y+50,120,120);
  
  //groundhog
  image(groundhogIdle, groundhogIdleX, groundhogIdleY);
  //soldier
  image(soldier, soldierX, soldierY);
  soldierX += soldierXSpeed ;
  if (soldierX>=640){
    soldierX = -block;
  }
  
   //cabbage hit groundhog
  image(cabbage, cabbageX, cabbageY);
  if(cabbageX + block > groundhogIdleX && 
           cabbageX < groundhogIdleX + groundhogIdle_W && 
           cabbageY + block > groundhogIdleY && 
           cabbageY < groundhogIdleY + groundhogIdle_H){
             cabbageX = -80;
             lifeX = lifeX+life_block;           
           }
  
  // groundhog&soldier hit detection
        if(soldierX + soldier_W > groundhogIdleX && 
           soldierX < groundhogIdleX + groundhogIdle_W && 
           soldierY + soldier_H > groundhogIdleY && 
           soldierY < groundhogIdleY + groundhogIdle_H){
            lifeX = lifeX-life_block;
            groundhogIdleX = block*4;
            groundhogIdleY = block;
           }
           
    //if life 
    if(lifeX+life_block*2 < 0){
     gameState = GAME_OVER;
    }
       break;
  
		// Game Lose
      case GAME_OVER:
      image(gameover, 0, 0);
      image(restartNormal, 248, 360);
      if( mouseX > button_L && mouseX < button_R && 
           mouseY > button_T && mouseY < button_D){
           image( restartHovered, 248, 360); 
           if(mousePressed){
             gameState = GAME_RUN;
           }}
       //initial life and groundhog
      lifeX = -60;
      groundhogIdleX = block*4;
      groundhogIdleY = block;
      cabbageX =  block*floor(random(0,8));
      cabbageY =  block*floor(random(2,6));
      soldierX = -block;
      soldierY = block*floor(random(2,6)) ;

      break;
}}


void keyPressed(){
  //groundhog move
  if( key == CODED ){
   switch (keyCode){  
     case DOWN:
       groundhogIdleY += block;
       if(groundhogIdleY+block > height) {
         groundhogIdleY = height-block;
      }
       break;
     case RIGHT:
       groundhogIdleX += block;
       if(groundhogIdleX+block > width) {
         groundhogIdleX = width-block;
      }
       break;
     case LEFT:
       groundhogIdleX -= block;
       if(groundhogIdleX < 0){ 
       groundhogIdleX = 0;
      }
       break;
}}}

void keyReleased(){
}
