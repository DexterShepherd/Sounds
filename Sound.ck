// require('samples/index.ck')

public class Sound {
  SndBuf s => dac;

  SampleMap samples;

  Event trigger;

  fun void load(string sound) {
    s.read(samples.map[sound]);
    s.pos(s.samples());
    spork ~ poll();
  }

  fun void play() {
    0 => s.pos;
  }

  fun void poll() {
    while(true) {
      trigger => now;
      play();
    }
  }
}
