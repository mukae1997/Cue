
import ddf.minim.*;
String fileName = "2.mp3";
String dataFileName = "data/cue1.json";
Minim minim;
AudioPlayer player;

CueHelper helper;

ArrayList<PVector> turns = new ArrayList<PVector> ();
void setup() {
  size(640, 360);
  helper = new CueHelper();
  minim = new Minim(this);

  // loadFile will look in all the same places as loadImage does.
  // this means you can find files that are in the data folder and the 
  // sketch folder. you can also pass an absolute path, or a URL.
  player = minim.loadFile(fileName);
  helper.startTime = millis();
  player.play(); 
  helper.PlayData(dataFileName);
}

void draw() {

  background(255);
  fill(0);
  text(player.position()+"/"+player.length(), 30, 30);
 
  float r = 50 *(0.02+helper.GetTrigger(player.position(), 100));
  fill(#ff0000, 150);
  ellipse(width/2, height/2, r, r);
} 

void keyPressed() {
  if (key==' ') {
    helper.AddCue(player.position());
  }
  if (key=='s') {
    helper.SaveData();
  }
}
