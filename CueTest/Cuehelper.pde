
class Cue {
  float time;
  Cue(float _t) {
    time = _t;
  }
  String toString() {
    return "Cue at:" + time;
  }
}
class CueHelper {
  float startTime = 0;
  ArrayList<Cue> cues;
  
  float trigger = 0;
  float triggerAddSpeed = 1;
  float triggerDecaySpeed = 0.7;
  
  
  CueHelper() {
    cues = new ArrayList<Cue>();
  }
  void AddCue(float t) {
    cues.add(new Cue(t));
    println("add cue", t);
  }

  Cue GetCueOnTime(float t, int interval) {
    for (int i = 0; i <cues.size()-1; i++) {
      Cue c = cues.get(i);
      Cue nextc = cues.get(i+1);
      if (c.time < t && c.time + interval > t) {
        return c;
      }
    }
    if (cues.size()>0) {
      Cue lastCue = cues.get(cues.size()-1);
      if (lastCue.time <= t && lastCue.time +1 > t) {
        return lastCue;
      }
    }
    return null;
  }

  void PlayData(String fileName) {
    this.cues.clear();
    JSONObject json; 
    json = loadJSONObject(fileName);
    JSONArray cuedata = json.getJSONArray("data");
    for (int i = 0; i < cuedata.size(); i++) {
      JSONObject o = cuedata.getJSONObject(i);
      float t = o.getFloat("time");
      Cue c = new Cue(t);
      this.cues.add(c);
    }
  }

  void SaveData() {

    JSONObject data;

    data = new JSONObject();
    JSONArray cuedata = new JSONArray();
    int i = 0;
    for (Cue c : helper.cues) {
      JSONObject o = new JSONObject();
      o.setFloat("time", c.time);
      cuedata.setJSONObject(i++, o);
    }
    data.setJSONArray("data", cuedata);
    saveJSONObject(data, dataFileName);
    println("save", cuedata.size() );
  }

  float GetTrigger(float t, int interval) {
    Cue c = this.GetCueOnTime(t, interval);
    if (c != null) {  
      text(c.toString(), 30, 50);
      trigger += triggerAddSpeed;
    }
    trigger *= triggerDecaySpeed;
    return trigger;
  }
}
