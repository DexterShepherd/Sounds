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
"{[f[0f]0f]}7{[[fa0f0af0]]}1" => kick.pattern;
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
" {(u0){(+1)[f]}4}4{(u0){(+2)[f]}4}4 " => wordPitch.pattern;
wordPitch.start();

fun void add(string s) {
  Sound t; 
  t.load(s);
  sounds << t;
}

while(true) {
  1::second => now;
}
