int switchDown = 5;
int switchUp = 4;
int switchLeft = 3;
int switchRight = 2;
int switchAtack = 6;
void setup() {
pinMode(switchDown, INPUT);
pinMode(switchUp, INPUT);
pinMode(switchLeft, INPUT);
pinMode(switchRight, INPUT);
pinMode(switchAtack, INPUT);

// Set pin 0 as an input
Serial.begin(9600); // Start serial communication at 9600 bps
}

void loop() {
  int down,up,left,right,atack,action;
  
  if (digitalRead(switchDown) == HIGH) { // If switch is ON,
    down=1;
  } 
  else { // If the switch is not ON,
    down=0;
  }

  
  if (digitalRead(switchUp) == HIGH) { // If switch is ON,
    up=1;
  }
  else { // If the switch is not ON,
    up=0;
  }

  
  if (digitalRead(switchLeft) == HIGH) { // If switch is ON,
    left=1;
  }
  else { // If the switch is not ON,
    left=0;
  }

  
  if (digitalRead(switchRight) == HIGH) { // If switch is ON,
    right=1;
  }
  else { // If the switch is not ON,
    right=0;
  }

  
  if (digitalRead(switchAtack) == HIGH) { // If switch is ON,
    atack=1;
  }
  else { // If the switch is not ON,
    atack=0;
  }

  
  if(atack==0){
    if (up==0 && down==0&&left==0 && right==0)
      action =0;
    if (up==0 && down==0&&left==0 && right==1)
      action =1;
    if (up==0 && down==0&&left==1 && right==0)
      action =2;
    if (up==0 && down==0&&left==1 && right==1)
      action =3;
    if (up==0 && down==1&&left==0 && right==0)
      action =4;
    if (up==0 && down==1&&left==0 && right==1)
      action =5;
    if (up==0 && down==1&&left==1 && right==0)
      action =6;
    if (up==0 && down==1&&left==1 && right==1)
      action =7;
    if (up==1 && down==0&&left==0 && right==0)
      action =8;
    if (up==1 && down==0&&left==0 && right==1)
      action =9;
    if (up==1 && down==0&&left==1&& right==0)
      action =10;
    if ( up == 1 && down == 0 && left==1 && right==1)
      action =11;
    if (up==1&&down==1&&left==0&&right==0)
      action =12;
    if (up==1 && down==1&&left==0 && right==1)
      action =13;
    if (up==1 && down==1&&left==1 && right==0)
      action =14;
    if (up==1 && down==1&&left==1 && right==1)
      action =15;
  }
  if(atack==1){
    if (up==0 && down==0&&left==0 && right==0)
      action =16;
    if (up==0 && down==0&&left==0 && right==1)
      action =17;
    if (up==0 && down==0&&left==1 && right==0)
      action =18;
    if (up==0 && down==0&&left==1 && right==1)
      action =19;
    if (up==0 && down==1&&left==0 && right==0)
      action =20;
    if (up==0 && down==1&&left==0 && right==1)
      action =21;
    if (up==0 && down==1&&left==1 && right==0)
      action =22;
    if (up==0 && down==1&&left==1 && right==1)
      action =23;
    if (up==1 && down==0&&left==0 && right==0)
      action =24;
    if (up==1 && down==0&&left==0 && right==1)
      action =25;
    if (up==1 && down==0&&left==1&& right==0)
      action =26;
    if ( up == 1 && down == 0 && left==1 && right==1)
      action =27;
    if (up==1&&down==1&&left==0&&right==0)
      action =28;
    if (up==1 && down==1&&left==0 && right==1)
      action =29;
    if (up==1 && down==1&&left==1 && right==0)
      action =30;
    if (up==1 && down==1&&left==1 && right==1)
      action =31;
  }
  
  Serial.write(action);
  //Serial.println(action);
  delay(100); // Wait 100 milliseconds
}