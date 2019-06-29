// require("Transport.ck")
// require("Sound.ck")
// require("Pattern.ck")
// require("DataPattern.ck")

Transport transport;
Sound sounds[0];

transport.setBpm(160);
transport.play();

add("chops:8");
Pattern you;
you.connect(transport, sounds[0].trigger);
"{]]f[[}3{[f]}8" => you.pattern;
/* you.start(); */

Pattern youPitch;
youPitch.connect(transport, sounds[0].note);
"{(+1)[f]}4(u0)" => youPitch.pattern;
youPitch.start();

add("dkick:0");
Pattern kick;
kick.connect(transport, sounds[1].trigger);
"{[f[0f]0f]}7[[f80f08f8]]" => kick.pattern;
kick.start();

add("808:1");
Pattern hat;
hat.connect(transport, sounds[2].trigger);
"{[[[f4]]]}8{[[a]]}4" => hat.pattern;
hat.start();

Pattern hatPitch;
hatPitch.connect(transport, sounds[2].note);
"{(+1)[f]}4(u0)" => hatPitch.pattern;
hatPitch.start();

add("words:0");
Pattern word;
word.connect(transport, sounds[3].trigger);
"[f]" => word.pattern;
word.start();

Pattern wordPitch;
wordPitch.connect(transport, sounds[3].note);
"{(u0){(+1)[f]}4}4{(u0){(+2)[f]}4}4" => wordPitch.pattern;
wordPitch.start();


add("808:3");
Pattern clap;
clap.connect(transport, sounds[4].trigger);
"{[00f[04]]}7[[04][0f]f[[0048]]]" => clap.pattern;
clap.start();

add("bass1:17");
Pattern bass;
bass.connect(transport, sounds[5].trigger);
"[f]" => bass.pattern;
bass.start();

Pattern bassPitch;
bassPitch.connect(transport, sounds[5].note);
"{(u1){(+1)[f]}4}4{(u1){(+2)[f]}4}4" => bassPitch.pattern;
bassPitch.start();
0.5 => sounds[5].s.gain;

fun void add(string s) {
  Sound t; 
  t.load(s);
  sounds << t;
}

while(true) {
  1::second => now;
}
