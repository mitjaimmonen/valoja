import 'dart:math';

import 'package:flutter/material.dart';

const List<String> thingsToDo = [
  'Selaa paikallisia tapahtumia',
  'Opiskele japania',
  'Lue sarjakuvia',
  'Käy ulkona',
  'Kuuntele podcastia',
  'Suunnittele arduino-projekti',
  'Suunnittele Raspberry Pi -projekti',
  'Asenna linux',
  'Piirrä tai maalaa',
  'Paranna tätä sovellusta',
  'Tee sovellus',
  'Käy kuntosalilla',
  'Leivo herkkuja',
  'Ota kaveriin yhteyttä',
  'Kastele kasvit',
  'Pese pyykit',
  'Soita pianoa',
  'Ilmoittaudu kurssille',
  'Käy kirpputorilla',
  'Korjaa rikkinäinen laite',
  'käy valokuvaamassa',
  'Vie roskat',
  'Tiskaa tiskit',
  'Hakkaa alla olevaa nappia niin kuin tekisit jotain hyödyllistä',
];

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final Random random = Random();
  int thingIndex = -1;
  List<int> randomizedList = [];

  @override
  void initState() {
    super.initState();

    randomizedList = List.generate(thingsToDo.length, (index) => index)
      ..shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Valoja',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      home: Builder(
        builder: (context) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          thingIndex == -1
                              ? 'Paina nappia ja lopeta aivovuoto'
                              : thingsToDo[randomizedList[thingIndex]],
                          textAlign: TextAlign.center,
                          style: Theme.of(
                            context,
                          ).textTheme.headlineLarge!.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              thingIndex++;
                              if (thingIndex >= randomizedList.length) {
                                thingIndex = 0;
                                randomizedList.shuffle();
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(16.0),
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            foregroundColor:
                                Theme.of(context).colorScheme.onPrimary,
                            elevation: 12,
                          ),
                          child: Container(
                            width: 200,
                            height: 200,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              'Herää pahvi'.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: Theme.of(
                                context,
                              ).textTheme.titleLarge!.copyWith(
                                fontSize: 32,
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
