import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'home_page.dart';
import 'create.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('cards');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Remind me',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const MyHomePage(title: 'Remind me'),
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
  bool conditionHomePage = false;
  @override
  Widget build(BuildContext context) {
    var box = Hive.box("cards");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: conditionHomePage
          ? Container(
              padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
              height: double.infinity,
              width: double.infinity,
              decoration:
                  const BoxDecoration(color: Color.fromARGB(255, 26, 26, 26)),
              child: const HomePage(),
            )
          : Container(
              padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
              height: double.infinity,
              width: double.infinity,
              decoration:
                  const BoxDecoration(color: Color.fromARGB(255, 26, 26, 26)),
              child: const HomePage(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String refresh = await Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => const Create()));
          setState(() {
            if (refresh == 'refresh') {
              conditionHomePage = !conditionHomePage;
            }
          });
          debugPrint("${box.values}");
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
