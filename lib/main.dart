import 'package:demo2/animation_controller.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(title: 'Interactive Characters'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String character = "assets/bob.flr";
  double days = 5.0;
  String _currentDays = 'Stand';
  // SmileyController _controller = SmileyController();
  void sliderChanged(double value) {
    if (days == value) return;

    setState(() {
      var direction = days < value ? '+' : '-';
      days = value;
      _currentDays = '${value.round()}$direction';
    });
  }

  void changeAnimation(String ani) {
    setState(() {
      _currentDays = ani;
    });
  }

  void buttonPressedSub() {
    if (days > 1) {
      setState(() {
        var direction = '-';
        days--;
        _currentDays = '${days.round()}$direction';
      });
    }
  }

  void buttonPressedAdd() {
    if (days < 5) {
      setState(() {
        var direction = '+';
        days++;
        _currentDays = '${days.round()}$direction';
      });
    }
  }

  void _incrementCounter() {
    setState(() {
      days++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (character == "assets/animation.flr") {
                    character = "assets/bob.flr";
                  } else {
                    character = "assets/animation.flr";
                    days = 5.0;
                    _currentDays = "5+";
                  }
                });
              },
              child: const Text("Change Character"),
            ),
            Container(
              height: 300,
              width: 300,
              child: FlareActor(
                character,
                alignment: Alignment.center,
                fit: BoxFit.contain,
                //controller: _controller,
                animation: _currentDays,
              ),
            ),
            if (character == "assets/animation.flr") ...{
              Text(
                '$days Rating',
                style: Theme.of(context).textTheme.headline4,
              ),
            },
            if (character == "assets/bob.flr") ...{
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      changeAnimation("Dance");
                    },
                    child: const Text("Dance"),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      changeAnimation("Stand");
                    },
                    child: const Text("Stand"),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      changeAnimation("Jump");
                    },
                    child: const Text("Jump"),
                  ),
                ],
              ),
            },
            if (character == "assets/animation.flr") ...{
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    onPressed: buttonPressedAdd,
                    child: const Icon(Icons.add),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  FloatingActionButton(
                    onPressed: buttonPressedSub,
                    child: const Icon(Icons.remove),
                  ),
                ],
              )
            },
          ],
        ),
      ),
    );
  }
}
