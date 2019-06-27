public class Pattern {
  Event trigger;
  Transport transport;
  fun void connect(Transport @ t, Event @ e) {
    t @=> transport;
    e @=> trigger;
  }

  0 => int index;
  3 => int speed;
  0 => int startedOneShot;
  string pattern;

  fun void start() {
    if ( pattern.length() ) {
      spork ~ run();
    }
  }

  fun void run() {
    transport.bar => now;
    while(true) {
      updateSpeed(currentChar());
      probTrigger(currentChar());
      oneShot(currentChar());
    }
  }

  fun string currentChar() {
    return pattern.substring(index, 1);
  }

  fun void incrementIndex() {
    1 +=> index;
    if ( index >= pattern.length() ) {
      0 => index;
    }
  }

  fun void updateSpeed(string s) {
    if (  s == "[" && speed > 0 ) {
      1 -=> speed;
      incrementIndex();
    } else if ( s == "]" && speed < transport.events.size() - 1 ) {
      1 +=> speed;
      incrementIndex();
    }
  }
  fun void wait() {
    transport.events[speed] => now;
  }

  fun void oneShot(string s) {
    if ( s == "o") {
      if ( !startedOneShot ) {
        trigger.broadcast();
        1 => startedOneShot;
      }
      wait();
    }
  }

  fun void probTrigger(string s) {
    "0123456789abcdef" => string map;
    map.find(s) => int prob;
    Math.random2(0, 14) => int choice;
    if (choice < prob ) {
      trigger.broadcast();
    }
    if ( prob != -1 ) {
      incrementIndex();
      wait();
    }
  }
}
