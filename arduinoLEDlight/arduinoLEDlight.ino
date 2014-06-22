#include <SoftwareSerial.h>

// ---------------
// 1. DECLARATIONS
// ---------------

//   a. Const
//   --------
//     Timing
const int DELAY = 8;
//     Channels
const int BLUE  = 6;                  
const int GREEN = 5;
const int RED   = 3;
//     Channels correspondances in ASCII
const int BED   = BLUE  + 48;
const int DESK  = GREEN + 48;
const int SHELF = RED   + 48;
const int ALL   = 65;


//   b. Variables
//   ------------
int brightness = -1;
int currentBrightness = 0;
int currentBLUEBrightness = 0;
int currentGREENBrightness = 0;
int currentREDBrightness = 0;
int selector = 0;
int argument = 0;


// --------
// 2. SETUP
// --------

void setup()
{
  Serial.begin(9600);
}

// -------
// 3. LOOP
// -------

void loop()
{
  //   a. Initialisation/Test: set all lights to 100%
  //   ----------------------------------------------
  if (brightness == -1)
  {
    for (brightness = 0 ; brightness < 256 ; brightness ++)
    {
      analogWrite(RED,   brightness);
      analogWrite(GREEN, brightness);
      analogWrite(BLUE,  brightness);
      delay(DELAY);
    }
    currentREDBrightness = brightness;
    currentGREENBrightness = brightness;
    currentBLUEBrightness = brightness;
    currentBrightness = brightness;
    Serial.print("Brightness on all channels: ");
    Serial.print(brightness);
    Serial.print("\n");
  }
  
  //   b. Receive data from computer
  //   -----------------------------
  if (Serial.available())
  {
    selector = Serial.read();
    Serial.flush();
  }
  
  if (selector == ALL
   || selector == BED
   || selector == DESK
   || selector == SHELF)
  {
     argument = Serial.read();
     Serial.flush();
     
     //   c. Command
     //   -----------
     Serial.print("transition(");
     Serial.print(selector);
     Serial.print(", ");
     Serial.print(argument);
     Serial.print(");\n");
     transition(selector, argument);
  }
  selector = 0;
  argument = 0;
  delay(DELAY);
}
  
// 4. TRANSITIONS
// --------------
void transition(int channel_s, int command)
{
  if (command == 43)
  {
    Serial.print("Interpreted as: ");
    Serial.print("+ [plus]");
    Serial.print("\n");
    
    if (channel_s == ALL) // Find the lighter light.
    {
      currentBrightness = currentREDBrightness;
      if (currentBrightness < currentGREENBrightness) currentBrightness = currentGREENBrightness;
      if (currentBrightness < currentBLUEBrightness)  currentBrightness = currentBLUEBrightness ;
    }
    else if (channel_s == BED)   currentBrightness = currentBLUEBrightness  ;
    else if (channel_s == DESK)  currentBrightness = currentGREENBrightness ;
    else if (channel_s == SHELF) currentBrightness = currentREDBrightness   ;
    
    for (brightness = currentBrightness ; brightness < currentBrightness+32 ; brightness ++)
    {
      if (channel_s == ALL)
      {
        analogWrite(RED,   brightness);
        analogWrite(GREEN, brightness);
        analogWrite(BLUE,  brightness);
        currentREDBrightness = brightness;
        currentGREENBrightness = brightness;
        currentBLUEBrightness = brightness;
      }
      else if (channel_s == BED)
      {
        analogWrite(BLUE, brightness);
        currentBLUEBrightness = brightness;
      }
      else if (channel_s == DESK)
      {
        analogWrite(GREEN, brightness);
        currentGREENBrightness = brightness;
      }
      else if (channel_s == SHELF)
      {
        analogWrite(RED, brightness);
        currentREDBrightness = brightness;
      }
      delay(DELAY);
    }
    Serial.print("Brightness: ");
    Serial.print(brightness);
    Serial.print("\n");
  }
  else if (command == 45)
  {
    Serial.print("Interpreted as: ");
    Serial.print("- [minus]");
    Serial.print("\n");
    
    if (channel_s == ALL) // Find the darkest light.
    {
      currentBrightness = currentREDBrightness;
      if (currentBrightness > currentGREENBrightness) currentBrightness = currentGREENBrightness;
      if (currentBrightness > currentBLUEBrightness)  currentBrightness = currentBLUEBrightness ;
    }
    else if (channel_s == BED)   currentBrightness = currentBLUEBrightness  ;
    else if (channel_s == DESK)  currentBrightness = currentGREENBrightness ;
    else if (channel_s == SHELF) currentBrightness = currentREDBrightness   ;
    
    for (brightness = currentBrightness ; brightness > currentBrightness-32 ; brightness --)
    {
      if (channel_s == ALL)
      {
        analogWrite(RED,   brightness);
        analogWrite(GREEN, brightness);
        analogWrite(BLUE,  brightness);
        currentREDBrightness = brightness;
        currentGREENBrightness = brightness;
        currentBLUEBrightness = brightness;
      }
      else if (channel_s == BED)
      {
        analogWrite(BLUE, brightness);
        currentBLUEBrightness = brightness;
      }
      else if (channel_s == DESK)
      {
        analogWrite(GREEN, brightness);
        currentGREENBrightness = brightness;
      }
      else if (channel_s == SHELF)
      {
        analogWrite(RED, brightness);
        currentREDBrightness = brightness;
      }
      delay(DELAY);
    }
    Serial.print("Brightness: ");
    Serial.print(brightness);
    Serial.print("\n");
  } 
  else if (command == 111)
  {
    Serial.print("Interpreted as: ");
    Serial.print("o [off]");
    Serial.print("\n");
    
    if (channel_s == ALL) // Find the darker light.
    {
      currentBrightness = currentREDBrightness;
      if (currentBrightness > currentGREENBrightness) currentBrightness = currentGREENBrightness;
      if (currentBrightness > currentBLUEBrightness)  currentBrightness = currentBLUEBrightness ;
    }
    else if (channel_s == BED)   currentBrightness = currentBLUEBrightness  ;
    else if (channel_s == DESK)  currentBrightness = currentGREENBrightness ;
    else if (channel_s == SHELF) currentBrightness = currentREDBrightness   ;
    
    for (brightness = currentBrightness ; brightness > 0 ; brightness --)
    {
      if (channel_s == ALL)
      {
        analogWrite(RED,   brightness);
        analogWrite(GREEN, brightness);
        analogWrite(BLUE,  brightness);
        currentREDBrightness = brightness;
        currentGREENBrightness = brightness;
        currentBLUEBrightness = brightness;
      }
      else if (channel_s == BED)
      {
        analogWrite(BLUE, brightness);
        currentBLUEBrightness = brightness;
      }
      else if (channel_s == DESK)
      {
        analogWrite(GREEN, brightness);
        currentGREENBrightness = brightness;
      }
      else if (channel_s == SHELF)
      {
        analogWrite(RED, brightness);
        currentREDBrightness = brightness;
      }
      delay(DELAY);
    }
    Serial.print("Brightness: ");
    Serial.print(brightness);
    Serial.print("\n");
  }
  else if (command == 109)
  {
    Serial.print("Interpreted as: ");
    Serial.print("m [max]");
    Serial.print("\n");
    
    if (channel_s == ALL) // Find the lighter light.
    {
      currentBrightness = currentREDBrightness;
      if (currentBrightness < currentGREENBrightness) currentBrightness = currentGREENBrightness;
      if (currentBrightness < currentBLUEBrightness)  currentBrightness = currentBLUEBrightness ;
    }
    else if (channel_s == BED)   currentBrightness = currentBLUEBrightness  ;
    else if (channel_s == DESK)  currentBrightness = currentGREENBrightness ;
    else if (channel_s == SHELF) currentBrightness = currentREDBrightness   ;
    
    for (brightness = currentBrightness ; brightness < 256 ; brightness ++)
    {
      if (channel_s == ALL)
      {
        analogWrite(RED,   brightness);
        analogWrite(GREEN, brightness);
        analogWrite(BLUE,  brightness);
        currentREDBrightness = brightness;
        currentGREENBrightness = brightness;
        currentBLUEBrightness = brightness;
      }
      else if (channel_s == BED)
      {
        analogWrite(BLUE, brightness);
        currentBLUEBrightness = brightness;
      }
      else if (channel_s == DESK)
      {
        analogWrite(GREEN, brightness);
        currentGREENBrightness = brightness;
      }
      else if (channel_s == SHELF)
      {
        analogWrite(RED, brightness);
        currentREDBrightness = brightness;
      }
      delay(DELAY);
    }
    Serial.print("Brightness: ");
    Serial.print(brightness);
    Serial.print("\n");
  }
}
