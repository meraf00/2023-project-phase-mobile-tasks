import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Circular counter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF052C51),
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Circular counter'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final _limit = 11;

  void _incrementCounter() {
    setState(() {
      _counter = (_counter + 1) % _limit;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter = (_counter - 1) % _limit;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(
            widget.title,
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),

        //
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,

          //
          children: [
            Flexible(
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    shape: BoxShape.circle,
                  ),

                  //
                  padding: const EdgeInsets.all(50),

                  //
                  child: Text(
                    _counter.toString(),
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            // buttons
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // decrement button
                  FilledButton(
                    onPressed: _decrementCounter,
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    child: const Text("Decrement"),
                  ),

                  //
                  const SizedBox(
                    width: 30,
                  ),

                  // increment button
                  FilledButton(
                    onPressed: _incrementCounter,
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    child: const Text("Increment"),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
