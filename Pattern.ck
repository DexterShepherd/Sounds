// require('./PatternEvent.ck')
public class Pattern {
  PatternEvent trigger;
  Transport transport;
  fun void connect(Transport @ t, PatternEvent @ e) {
    t @=> transport;
    e @=> trigger;
  }

  0 => int index;
  3 => int speed;
  0 => int startedOneShot;
  string _pattern;

  fun void pattern(string p) {
    p => string temp;
    if ( temp.find("{") != -1 ) {
      while(temp.find("{") != -1) {
        temp.find("{") => int start; 
        temp.find("}") => int end;
        charToNumber(temp.substring(end + 1, 1)) => int times;
        temp.erase(end, 2);
        temp.erase(start, 1);
        temp.substring(start, end - start - 1) => string sub;
        for ( int i; i < times - 1; i++ ) {
          temp.insert(start, sub);
        }
      }
      temp => _pattern;
    } else {
      p => _pattern;
    }
    <<<"Processed Pattern", _pattern>>>;
  }

  fun void start() {
    if ( _pattern.length() ) {
      spork ~ run();
    }
  }

  fun void run() {
    transport.bar => now;
    while(true) {
      parseFunction(currentChar());
      updateSpeed(currentChar());
      probTrigger(currentChar());
      oneShot(currentChar());
    }
  }

  fun string currentChar() {
    return _pattern.substring(index, 1);
  }

  fun void incrementIndex() {
    1 +=> index;
    if ( index >= _pattern.length() ) {
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
    charToNumber(s) => int prob;
    Math.random2(0, 14) => int choice;
    if (choice < prob ) {
      trigger.broadcast();
    }
    if ( prob != -1 ) {
      incrementIndex();
      wait();
    }
  }

  fun void parseFunction(string s) {
    if ( s == "(" ) {
      incrementIndex();
      runFunction(currentChar());
      if ( currentChar() == ")" ) {
        incrementIndex();
      } else {
        <<<"Malformed function">>>;
      }
    }
  }

  fun void runFunction(string s) {
    if ( s == "+" ) {
      incrementIndex();
      getFunctionArgument(currentChar()) +=> trigger.data;
    }
    if ( s == "u" ) {
      incrementIndex();
      getFunctionArgument(currentChar()) => trigger.data;
    }
  }

  fun float getFunctionArgument(string s) {
    incrementIndex();
    return charToNumber(s) * 1.0;
  }

  fun int charToNumber(string s) {
    "0123456789abcdef" => string map;
    return map.find(s);
  }
}
