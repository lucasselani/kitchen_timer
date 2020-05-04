import 'dart:async';
import 'dart:isolate';

Isolate _isolate;
ReceivePort _port;

Future<void> startIsolate() async {
  if (_isolate == null) {
    print('start isolate');
    _port ??= ReceivePort();
    _isolate ??= await Isolate.spawn(_runTimer, _port.sendPort);
  }
}

void _runTimer(SendPort sendPort) async {
  print('start timer');
  var counter = 0;
  Timer.periodic(
    Duration(seconds: 1),
    (Timer timer) {
      counter++;
      sendPort.send(counter);
      print('timer $counter');
    },
  );
}

void listenIsolate(Function onData) {
  _port.listen(onData);
}

void stopIsolate() {
  if (_isolate != null) {
    _isolate.kill(priority: Isolate.immediate);
    _isolate = null;
  }
  if (_port != null) {
    _port.close();
    _port = null;
  }
}
