// require('Playhead.ck')

public class Transport {
  Playhead tick;
  Playhead sixteenth;
  Playhead eighth;
  Playhead quarter;
  Playhead half;
  Playhead bar;
  Playhead twoBar;
  Playhead fourBar;

  Playhead events[0];

  events << tick;
  events << sixteenth;
  events << eighth;
  events << quarter;
  events << half;
  events << bar;
  events << twoBar;
  events << fourBar;

  float tps;
  setBpm(120);

  fun void setBpm(float bpm) {
    60.0/bpm/4.0/2.0  => tps;
  }

  fun void play() {
    spork ~ run();
  }

  fun void run() {
    while(true) {
      tick.broadcast();
      1 +=> tick.count;
      if ( tick.count % 2 == 0)  {
        sixteenth.broadcast();
        1 +=> sixteenth.count;
      }
      if ( tick.count % 4 == 0)  {
        eighth.broadcast();
        1 +=> eighth.count;
      }
      if ( tick.count % 8 == 0)  {
        quarter.broadcast();
        1 +=> quarter.count;
      }
      if ( tick.count % 16 == 0)  {
        half.broadcast();
        1 +=> half.count;
      }
      if ( tick.count % 32 == 0)  {
        bar.broadcast();
        1 +=> bar.count;
      }
      if ( tick.count % 64 == 0)  {
        twoBar.broadcast();
        1 +=> twoBar.count;
      }
      if ( tick.count % 128 == 0)  {
        fourBar.broadcast();
        1 +=> fourBar.count;
      }
      tps::second => now;
    }
  }
}
