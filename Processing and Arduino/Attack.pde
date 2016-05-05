import processing.serial.*;
Serial port; // Create object from Serial class
int val; // Data received from the serial port

import ddf.minim.*;
Minim minim;
AudioPlayer open;
AudioPlayer player;
AudioPlayer player2;
AudioPlayer endW;
AudioPlayer endL;


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

/**winner or loser*/
int count=0;
float speed=0;
int revCount=450;

/** monster */
int monX []=new int [20];
float monY[]=new float [20];
int isLife[]=new int [20];

/** recover */
int recX[]=new int [10];
int recY[]=new int [10];
boolean recLife[]=new boolean [10];

/** air */
int airX=200;
int airY=350;
int incX=5;

/**whether pressed UP DOWN LEFT RIGHT*/
boolean up;
boolean down;
boolean left;
boolean right;
boolean atack; 
int state=0;
int level=1;

//Change menu
boolean move;
int X=1;

//if you apporiate die,your attack wuold be the powerful
int range=0;

void setup(){
size(1270,700);

//music
minim=new Minim(this);
open=minim.loadFile("music/EMA(open).mp3",2048);
player=minim.loadFile("music/bodymotion(player).mp3",2048);
player2=minim.loadFile("music/DOA(player2).mp3",2048);
endW=minim.loadFile("music/Starting line(endW).mp3",2048);
endL=minim.loadFile("music/omake-pfadlib(endL).mp3",2048);


open.loop();

booms=new Boom[numB];
air=loadImage("pic/mikasa.png");
mon=loadImage("pic/pin.png");
kill=loadImage("pic/boom.png");
win=loadImage("pic/backWin.jpg");
lose=loadImage("pic/backL.jpg");
trap=loadImage("pic/123.png");
boo=loadImage("pic/ban.png");
kit=loadImage("pic/kit.png");
menu=loadImage("pic/menu.jpg");
back=loadImage("pic/back2.jpg");

for(int i=0;i<50;i++){
  booms[i]=new Boom();
}
for(int i=0;i<20;i++){
  monX [i]=(int)random(1270,4000);
  monY[i]=(int)random(600);
  isLife[i]=2;
}

for(int i=0;i<10;i++){
  recX[i]=(int)random(2000,6000);
  recY[i]=(int)random(600);
  recLife[i]=true;
}

println(Serial.list()); 
String portName = Serial.list()[2]; 
port = new Serial(this, portName, 9600);

}

void draw() {
if (0 < port.available()) { // If data is available,
      val = port.read();
    }
    println(val);
/**menu*/
if(state==0){
  image(menu,0,0,1270,700);
      if(mousePressed == true && mouseButton == LEFT || val>15) {
        open.pause();
        player.loop();
        state = 1;
      }
}

/**Game start*/
if(state==1){
  cursor(ARROW);
  image(back,0,0,1270,700);
  image(trap,0,0,30,700);
  
  /**using keyboard control mikasa */
 
  if(((7<val&&val<16)||(23<val&&val<32)||up)&&airY>0){
    airY-=5;
    up=true;
  }
  else if((val==4||val==5||val==6||val==7||val==12||val==13||val==14||val==15||val==20||val==21||val==22||val==23||val==28||val==29||val==30||val==31||down)&&airY<600){
    airY+=5;
    down=true;
  }  
  else if((val==2||val==3||val==6||val==7||val==10||val==11||val==14||val==15||val==18||val==19||val==22||val==23||val==26||val==27||val==30||val==31||left)&&(airX-incX)>0){
    airX-=5;
    left=true;
  }  
  else if(((val%2==1)||right)&&(airX-incX)<1270){
    airX+=5;
    right=true;
  } 
  /**your booms*/
  else if(val>15){
    booms[curB].start(airX-incX,airY,revCount);
    curB++;
    atack=true;
    if(curB==numB)
      curB=0;
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
   if(atack){
    booms[curB].start(airX-incX,airY,revCount);
    curB++;
    if(curB==numB)
       curB=0;
  }
 }
 
 if(val<8||(val>15&&val<24))
     up=false;
   if(val==0||val==1||val==2||val==3||val==8||val==9||val==10||val==11||val==16||val==17||val==18||val==19||val==24||val==25||val==26||val==27)
     down=false;
   if(val==0||val==1||val==4||val==5||val==8||val==9||val==12||val==13||val==16||val==17||val==20||val==21||val==22||val==25||val==28||val==29)
     left=false;
   if(val%2==0)
     right=false;
   if(val<16) 
     atack=false;
 


  
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
  
  /**display text*/
  fill(0,255,255);
  textSize(30);
  text("Kill:"+count,25,30);        //print number of killing
  text("Level:"+level,25,670);        //print level of stage
  
  /**color change with your blood decrease*/
  if(revCount<150)
    fill(255,0,0,90);
  else if(revCount>150&&revCount<250)
    fill(255,255,0,90);
  else
    fill(0,255,0,90);
    
  text("blood:",670,670);
  rect(770,650,revCount,20);  //print your blood
  
  /**Crisis and Strethen*/
  if(revCount<150)
    range=80;
  else
    range=0;
  
  /**Judgement whether kill giant or not*/
  for(int i=0;i<50;i++)
    for(int j=0;j<20;j++){
      if(isLife[j]>0&&booms[i].on&&booms[i].boomX<monX[j]+50+range&&booms[i].boomX>monX[j]-50-range&&booms[i].boomY<monY[j]+50+range&&booms[i].boomY>monY[j]-50-range)
      {
        if((int)random(800)%2==1){
           monY[j]=(int)random(600);
           break;
        }
        else{
          image(kill,monX[j],monY[j],100,100); 
          if(revCount<150){
            isLife[j]=0;
            booms[i].on=false;
          }
          else{
            isLife[j]--;
            booms[i].on=false;
          }
          //the giant is die
          if(isLife[j]==0)
            count++;
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
   for(int i=0;i<20;i++){
     if(isLife[i]>0&&(airX-incX)>monX[i]-50&&(airX-incX)<monX[i]+50&&airY>monY[i]-50&&airY<monY[i]+50){
       revCount--;
       airX-=10;
     }
   }
   
   //pause
  if(keyPressed=true&&key=='p'){
    fill(248,248,250,90);
    textSize(200);
    text("pause",350,350);
    state=4;
  }
  
   //winner or loser and level
   if(level<=5){
     if(count==20&&revCount>0){
       player.pause();
       endW.loop();
       state=2;
     }  
     else if(count<20&&revCount<=0){
       player.pause();
       endL.loop();
       state=3;
     }  
   }
   
   else{
     if(count==20&&revCount>0){
       player2.pause();
       endW.loop();
       state=2;
     }  
     else if(count<20&&revCount<=0){
       player2.pause();
       endL.loop();
       state=3;
     }  
   }
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
    
    for(int i=0;i<20;i++){
      isLife[i]=2;
      monX [i]=(int)random(1270,3000);
      monY[i]=(int)random(600);
      booms[i].on=false;
    }
    for(int i=0;i<10;i++)
      recX[i]=(int)random(1800,6000);
  }
  if(move){
    image(back,0,0,1270,700);
    image(win,0+X,0,1270,700);
    X+=20;
    if(X>1270){
      level++;
      if(level<=5){
        endW.pause();
        player.loop();
      }
      else{
        endW.pause();
        player2.loop();
      }
      state=1;
      X=1;
      move=false;
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
 
    for(int i=0;i<20;i++){
      isLife[i]=2;
      monX [i]=(int)random(1500,3000);
      monY[i]=(int)random(600);
      booms[i].on=false;
    }  
    for(int i=0;i<10;i++)
      recX[i]=(int)random(1800,6000);
  }
  
  if(move){
    image(menu,0,0,1270,700);
    image(lose,0+X,0,1270,700);
    X+=20;
    if(X>1270){
      endL.pause();
      open.loop();
      level=1;
      state=0;
      X=1;
      move=false;
    }  
  }
}
/**pause zone*/
else if(state==4){
  if(keyPressed=true&&key=='s'){
      state=1;
  }  
}
}

class Boom{
float boomX;
float boomY;
float boomR=5;
boolean on=false;
int r=(int)random(255);
int g=(int)random(150);
int b=(int)random(70);
int rev=0;

void start(float x,float y,int r){
boomX=x;
boomY=y;
rev=r;
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
    if(rev<150)
    image( boo,boomX+100,boomY+50,100+boomR,100+boomR);
    else
    image( boo,boomX+100,boomY+50,50+boomR,50+boomR);
  }
  }
}

void stop(){
  open.close();
  player.close();
  player2.close();
  endW.close();
  endL.close();
  minim.stop();
  super.stop();
}
