Boom[]booms;
PImage air;
PImage mon;
PImage kill;
PImage win;
PImage lose;
PImage trap;
PImage boo;
PImage kit;
PImage menu;
PImage back;


int numB=50;
int curB=0;
int count=0;
float speed=0;
int revCount=450;

/** monster */
int monX []=new int [50];
float monY[]=new float [50];
int isLife[]=new int [50];

/** recover */
int recX[]=new int [10];
int recY[]=new int [10];
boolean recLife[]=new boolean [10];

/** air */
int airX=200;
int airY=350;
int incX=5;


boolean up;
boolean down;
boolean left;
boolean right;

int state=0;

boolean move;
int X=1;

void setup(){
size(1270,700);
booms=new Boom[numB];
air=loadImage("mikasa.png");
mon=loadImage("pin.png");
kill=loadImage("boom.png");
win=loadImage("backWin.jpg");
lose=loadImage("backL.jpg");
trap=loadImage("123.png");
boo=loadImage("ban.png");
kit=loadImage("kit.png");
menu=loadImage("menu.jpg");
back=loadImage("back2.jpg");

for(int i=0;i<50;i++){
  booms[i]=new Boom();
}
for(int i=0;i<50;i++){
  monX [i]=(int)random(1270,4000);
  monY[i]=(int)random(600);
  isLife[i]=2;
}

for(int i=0;i<10;i++){
  recX[i]=(int)random(2000,6000);
  recY[i]=(int)random(600);
  recLife[i]=true;
}
}

void draw() {
if(state==0){
  image(menu,0,0,1270,700);
  if(mouseX>475&&mouseX<815&&mouseY>305&&mouseY<420){
      cursor(HAND);
      if(mousePressed == true && mouseButton == LEFT) {
        state = 1;
      }
    } 
    else {
      cursor(ARROW);
    }
}

if(state==1){
  cursor(ARROW);
  image(back,0,0,1270,700);
  image(trap,0,0,30,700);
  fill(0,255,255);
  textSize(30);
  text("Kill:"+count/2,25,30);        //print number of killing
  if(revCount<150)
    fill(255,0,0,90);
  else if(revCount>150&&revCount<250)
    fill(255,255,0,90);
  else
    fill(0,255,0,90);
    
  text("blood:",670,670);
  rect(770,650,revCount,20);  //print your blood
  
  /** mikasa */
  if(keyPressed==true&&(keyCode==UP||up)&&airY>0){
    airY-=5;
    up=true;
  }
  if(keyPressed==true&&(keyCode==DOWN||down)&&airY<600){
    airY+=5;
    down=true;
  }  
  if(keyPressed==true&&(keyCode==LEFT||left)&&(airX-incX)>0){
    airX-=5;
    left=true;
  }  
  if(keyPressed==true&&(keyCode==RIGHT||right)&&(airX-incX)<1270){
    airX+=5;
    right=true;
  } 
 
 else{
   if(up&&airY>0){
     airY-=5;
   }
   if(down&&airY<600){
     airY+=5;
   }
   if(left&&(airX-incX)>0){
     airX-=5;
   }
   if(right&&(airX-incX)<1270){
     airX+=5;
   }
 } 
  
  image(air,airX-incX,airY,100,100); //mikasa
  
 if(airX-incX>0)
    incX++;
 else if(airX-incX<=0)
    revCount--;
  
  
  /** display monster */
  for(int i=0;i<monX.length;i++){
    if(isLife[i]>0){
      image(mon,monX[i],monY[i],100,100);
      monX[i]-=(i+15)/50.0+count/15.0+speed;        //more kill,more fast
      if(monX[i]<0){
        monX[i]=1270;
        speed+=0.01;                            //if not kill,then speed on 
        monY[i]=(int)random(600);
        revCount-=5;                            //your blood
      } 
    }
  }
  
  
  for(int i=0;i<numB;i++){
    booms[i].grow();
    booms[i].display();
  }
  
  /** display recover */
  for(int i=0;i<10;i++){
    if(!recLife[i]){
      recX[i]=(int)random(1800,6000);
      recY[i]=(int)random(650);
      recLife[i]=true;
    }
    if(recLife[i]){
      image(kit,recX[i],recY [i],100,100);
      recX[i]-=(i+15)/20.0;
      if(recX[i]<0){
        recX[i]=(int)random(2000,6000);
        recY[i]=(int)random(600);
      }
    }
  }
  
  /**Judgement whether kill giant or not*/
  for(int i=0;i<50;i++)
    for(int j=0;j<50;j++){
      if(isLife[j]>0&&booms[i].on&&booms[i].boomX<monX[j]+50&&booms[i].boomX>monX[j]-50&&booms[i].boomY<monY[j]+50&&booms[i].boomY>monY[j]-50)
      {
        if((int)random(800)%2==1){
           monY[j]=(int)random(600);
           break;
        }
        else{
          image(kill,monX[j],monY[j],100,100);
          count++;
          isLife[j]--;          //the giant is die
          booms[i].on=false;
        }
      }
    }
   
   /** weather recover*/
   for(int i=0;i<10;i++)
     if(revCount<400&&recLife[i]&&(airX-incX)>recX[i]-50&&(airX-incX)<recX[i]+50&&airY>recY[i]-50&&airY<recY[i]+50){
       revCount+=30;
       recLife[i]=false;
     }
     
   /** touch the giant */
   for(int i=0;i<50;i++){
     if(isLife[i]>0&&(airX-incX)>monX[i]-50&&(airX-incX)<monX[i]+50&&airY>monY[i]-50&&airY<monY[i]+50){
       revCount--;
       airX-=10;
     }
   }
   
   if(count==100&&revCount>0)
     state=2;
   else if(count<100&&revCount<=0)
     state=3;
}

/**winner zone*/
else if(state==2){
  background(255,255,255);
  image(win,0,0,1270,700);
  fill(255,255,0,90);
  textSize(100);
  text("You are winner!",450,300);
  textSize(50);
  text("More harder..?",920,690);
  
  if(mousePressed==true){
    count=0;
    speed+=0.5;
    revCount=450;
    airX=200;
    airY=350;
    incX=5;
    move=true;
    
    for(int i=0;i<50;i++){
      isLife[i]=2;
      monX [i]=(int)random(1270,3000);
      monY[i]=(int)random(600);
      booms[i].on=false;
    }
    for(int i=0;i<10;i++)
      recX[i]=(int)random(1800,6000);
      
    //state=1;
  }
  if(move){
    image(back,0,0,1270,700);
    image(win,0+X,0,1270,700);
    X+=20;
    if(X>1270){
      state=1;
      move=false;
      X=1;
    }
  }
}

/**loser zone*/
else if(state==3){
  background(255,255,255);
  image(lose,0,0,1270,700);
  fill(0,0,205,150);
  textSize(150);
  text("You lose..",300,450);
  textSize(50);
  fill(255,255,0,180);
  text("again....?",1020,690);
  
  if(mousePressed==true){
    count=0;
    revCount=450;
    speed=0;
    airX=200;
    airY=350;
    incX=5;
    move=true;
    
    for(int i=0;i<50;i++){
      isLife[i]=2;
      monX [i]=(int)random(1500,3000);
      monY[i]=(int)random(600);
      booms[i].on=false;
    }  
    for(int i=0;i<10;i++)
      recX[i]=(int)random(1800,6000);
      
    //state=0;
  }
  
  if(move){
    image(menu,0,0,1270,700);
    image(lose,0+X,0,1270,700);
    X+=20;
    if(X>1270){
      state=0;
      move=false;
      X=1;
    }  
  }
}
}

/**your booms*/
void keyPressed(){
  if(key==' '){
    booms[curB].start(airX-incX,airY);
    curB++;
    if(curB==numB)
      curB=0;
  }
}

void keyReleased(){
  if(keyCode==UP)
    up=false;
  if(keyCode==DOWN)
    down=false;
  if(keyCode==LEFT)
    left=false;
  if(keyCode==RIGHT)
    right=false;
}


class Boom{
float boomX;
float boomY;
float boomR=5;
boolean on=false;
int r=(int)random(255);
int g=(int)random(150);
int b=(int)random(70);


void start(float x,float y){
boomX=x;
boomY=y;
on=true;
}

void grow(){
  if(on==true){
    boomX+=2;
    boomR+=0.25;
    if(boomX>1500)
      on=false;
    if(boomR>15)
      boomR=5;
  }
}

void display(){
  if(on==true){
    fill(r,g,90);
    noStroke();
    image( boo,boomX+100,boomY+50,50+boomR,50+boomR);
  }
  }
}
