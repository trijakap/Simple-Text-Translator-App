import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Simple Translator App form EN to RU'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _translationResult = '';
  final inputController = TextEditingController();

  void _translate() async {
    var input = inputController.value.text;
    translator(input).then((value) => setState(() {
          log(value);
          _translationResult = value;
        }));
  }

  Future<String> translator(final input) async {
    final translator = GoogleTranslator();
    var translation = await translator.translate(input, from: 'en', to: 'it');
    return translation.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: inputController,
              onChanged: (_) {
                _translate;
              },
              maxLines: 5,
              decoration: const InputDecoration.collapsed(
                  hintText: "Enter your text here",
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Translation from English to Italian',
            ),
            const SizedBox(
              height: 8,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color(0xFF0D47A1),
                            Color(0xFF1976D2),
                            Color(0xFF42A5F5),
                          ],
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(8.0),
                      primary: Colors.white,
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: _translate,
                    child: const Text('Translate'),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Result:',
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              _translationResult,
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _translate,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
