// require("Transport.ck")
// require("Sound.ck")
// require("Pattern.ck")

Transport transport;
Sound sounds[0];

transport.setBpm(160);
transport.play();

add("dkick:5");
Pattern kick;
kick.connect(transport, sounds[0].trigger);
"[[f00f00f0]]" => kick.pattern;
kick.start();

add("daccapella:1");
Pattern vox;
vox.connect(transport, sounds[1].trigger);
"o" => vox.pattern;
vox.start();
0.2 => sounds[1].s.gain;
2.0 => sounds[1].s.rate;

add("bass2:0");
Pattern bass;
bass.connect(transport, sounds[2].trigger);
"f" => bass.pattern;
bass.start();
0.00 => sounds[2].s.gain;

add("bleep:9");
Pattern bleep;
bleep.connect(transport, sounds[3].trigger);
"[[a23a33a3]]" => bleep.pattern;
bleep.start();
0.1 => sounds[3].s.gain;
0.8 => sounds[3].s.rate;

fun void bar() {
  while(1) {
    transport.bar => now;
    if ( transport.bar.count % 8 == 0 ) {
      0 => sounds[1].s.pos;
      if ( transport.bar.count > 0 && transport.bar.count % 16 == 0) {
        0.1 => sounds[2].s.gain;
        0.00 => sounds[0].s.gain;
      }
      if ( transport.bar.count > 0 && (transport.bar.count + 8) % 16 == 0) {
        0.00 => sounds[2].s.gain;
        0.5 => sounds[0].s.gain;
      }
    }
  }
}


fun void add(string s) {
  Sound t; 
  t.load(s);
  sounds << t;
}

spork ~ bar();

while(true) {
  1::second => now;
}
