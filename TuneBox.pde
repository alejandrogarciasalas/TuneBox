/*
TuneBox
 by Alejandro García Salas
 
beats visualization in a box (or boxes) 
*/

import peasy.*;           
import ddf.minim.*;  

Minim minim;                  
AudioPlayer s;                
PeasyCam cam;                 

int sample=2000,                  
numberOfModules = int(sqrt(sample)),              
moduleSize = 50,                          
amplyfingFactor = 50,         
intialLengthOfTheSideOfTheContainer =numberOfModules*moduleSize;                     
float[] sizeOfModules;                    
float[] analysisOfCurrentSounds;      
color moduleColor = color(255, 255, 255);

void stop (){s.close();minim.stop();super.stop();}

void setup(){
  size(1000, 1000, P3D);
  //noStroke();
  noCursor();
  //fill(moduleColor);
  frameRate(24); 
  
  minim = new Minim(this);
  s = minim.loadFile("so-obvious.mp3", sample);
  s.play(); //Minim settings                            
  cam = new PeasyCam(this, intialLengthOfTheSideOfTheContainer * .5, intialLengthOfTheSideOfTheContainer * .6, 0, sample * 2.5);
  cam.rotateX(-PI / 5);
  cam.rotateY(-PI / 3); 
  
  
  sizeOfModules = new float[sample];
  analysisOfCurrentSounds = new float[sample];
  for (int i = 0; ++i < sample;) {
      sizeOfModules[i] = 0;
  }
  
}

void draw() {
    background(0, 0, 0);
    analysisOfCurrentSounds = s.mix.toArray();
    
    for (int i = 0; i < sample; i++) {
        pushMatrix();
        translate(i % numberOfModules * moduleSize, floor(i / numberOfModules * moduleSize), i);
        box(sizeOfModules[i] += (analysisOfCurrentSounds[i] * amplyfingFactor));
        box(40, 20, 50);
        popMatrix();
    }
}
