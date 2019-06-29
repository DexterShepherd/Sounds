// require('samples/index.ck')
// require('SoundEvent.ck')
// require('PatternEvent.ck')

public class Sound {
  SndBuf s => dac;

  SampleMap samples;
  SoundEvent control;
  PatternEvent trigger;
  PatternEvent note;

  1.0 => float root;

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

  spork ~ controlPoll();

  fun void controlPoll() {
    while(1) {
      note => now;
      rateForNote(note.data) => s.rate;
    }
  }

  fun float rateForNote(float n) {
    n - root => float diff;
    diff / 12 => float semi;
    return ( Math.pow(2, semi) );
  }
}
