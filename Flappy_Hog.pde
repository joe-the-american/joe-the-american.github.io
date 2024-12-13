import processing.sound.*;

PImage A10;
PImage bg, bg2;
PImage missT, missB;

int bgx;
int y, Vy;
float px, py;

SoundFile back;
SoundFile eng;
boolean mousePressedFlag = false;
SoundFile down;

boolean gameState;
int score;
int Hscore;
int missed;

void setup(){
  size(600,600);
  A10 = loadImage("The_HOG.png");
  back = new SoundFile(this,"BG Rock.mp3");
  eng = new SoundFile(this,"engine.mp3");
  down = new SoundFile(this,"shot down.mp3");
  bg = loadImage("Hunting_Ground.png");
  bg2 = loadImage("Hunting_Ground2.png");
  y = 0;
  Vy = 0;
  px = width;
  py = int(random(200, height-200));
  missT = loadImage("Hog_Killer_Air.png");
  missB = loadImage("Hog_Killer.png");
  gameState = true;
  
}

void draw(){
  if(gameState){
    drawAfg();
    drawHog();
    drawMiss();
    checkDown();
    drawScore();
  } else {
    gameOver();
  }
}  


void drawAfg() {
  image(bg, bgx, 0);  
  image(bg2, bgx + bg.width, 0);  
  image(bg, bgx + 2 * bg.width, 0);  
  
  bgx -= 2;  

 
  if (bgx < -2 * bg.width) {
    bgx = 0;
  }
}

void drawHog(){
  image(A10, 50, y, 150, 110);  
  y += Vy;  
  Vy++; 

  if (y > height) {
    y = height;
    Vy = 0;
  }
}

void drawMiss(){
  px = px - 8;
  image(missT, px-25, py-missT.height-100);
  image(missB, px-25, py+100);
  
 
  if(px < 50 - missT.width && px > -50){
    if (y < py || y > py - 100) {
      score++; 
    }
  }

  if(px < -50){
    px = width + 20;
    py = int(random(100,height-100));
  }
}

void checkDown(){
  if(px > 50-missT.width && px < 50 && (y > py || y < py-100)){
    gameState = false;
    down.play();
  }
}

void drawScore() {
  fill(255); 
  textSize(32);
  textAlign(LEFT, TOP);
  text("Score: " + score, 10, 10); 
  text("High Score: " + Hscore, 10, 40); 
}

void gameOver() {
  if (score > Hscore) {
    Hscore = score;
  }
  
  fill(255, 0, 0); 
  textSize(50); 
  textAlign(CENTER, CENTER);
  text("GAME OVER", width / 2, height / 2 - 50);
  textSize(32);
  text("Final Score: " + score, width / 2, height / 2 + 20);
  
  textSize(20);
  text("Click to Restart", width / 2, height / 2 + 60);
  
  if (mousePressedFlag) {
    score = 0;
    missed = 0;
    px = width;
    py = int(random(200, height-200));
    gameState = true;
  }
}

void mousePressed() {
  if (!gameState) {
    mousePressedFlag = true;
  } else {
    Vy = -10;
    eng.play();
  }
}
