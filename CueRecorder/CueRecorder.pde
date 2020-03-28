
import ddf.minim.*;
String fileName = "2.mp3";
String dataFileName = "data/cue1.json";
Minim minim;
AudioPlayer player; 
CueHelper helper;

ArrayList<PVector> turns = new ArrayList<PVector> ();
PVector p;
void setup() {
  size(640, 360);
  helper = new CueHelper();
  minim = new Minim(this);
  p = new PVector(width/2, height/2);
  // loadFile will look in all the same places as loadImage does.
  // this means you can find files that are in the data folder and the 
  // sketch folder. you can also pass an absolute path, or a URL.
  player = minim.loadFile(fileName);
  helper.startTime = millis();
  player.play(); 
  helper.PlayData(dataFileName);

  turns.add(p);
}

void draw() {

  background(255);
  fill(0);
  text(player.position()+"/"+player.length(), 30, 30);

  if (helper.OnCue(player.position(), 30)) {
    turns.add(PVector.random2D().mult(random(10,20)));
  }

  float r = 50*(0.02+helper.GetTrigger(player.position(), 110));
  fill(#ff0000, 90);
  ellipse(width/2, height/2, r, r);

  stroke(0, 90);
  strokeWeight(3);
  PVector p0 = turns.get(0).copy();
  for (int i = 0; i < turns.size()-1; i++) { 
    PVector p1 = p0.copy();
    PVector p2 = p0.add(turns.get(i+1));
    line(p1.x, p1.y, p2.x, p2.y);
  }
} 

void keyPressed() {
  if (key==' ') {
    helper.AddCue(player.position());
  }
  if (key=='s') {
    helper.SaveData();
  }
}
