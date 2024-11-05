import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todolist/components/date_picker/my_date_picker.dart';
import 'package:todolist/components/time_line_tile.dart';
import 'components/my_float_action_button.dart';

void main() {
  runApp(MaterialApp(
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const [Locale("ru", "")],
    locale: const Locale("ru", ""),
    theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color.fromARGB(255, 222, 222, 249),
        textSelectionTheme: const TextSelectionThemeData(
            selectionHandleColor: Color.fromARGB(255, 222, 222, 249),
            cursorColor: Color.fromARGB(255, 222, 222, 249),
            selectionColor: Color.fromARGB(124, 175, 175, 175)),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            decoration: TextDecoration.none,
            fontFamily: "Spartan",
            fontWeight: FontWeight.w200,
            color: Color.fromARGB(255, 222, 222, 249),
          ),
          bodySmall: TextStyle(
            decoration: TextDecoration.none,
            fontFamily: "Spartan",
            fontWeight: FontWeight.w100,
            color: Color.fromARGB(255, 222, 222, 249),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
              borderSide:
              BorderSide(color: Color.fromARGB(255, 222, 222, 249))),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 222, 222, 249)),
          ),
          labelStyle: TextStyle(
            color: Color.fromARGB(255, 222, 222, 249),
          ),
        )),
    themeMode: ThemeMode.dark,
    debugShowCheckedModeBanner: false,
    home: const Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime now = DateTime.now();

  List checkedList = [
    false,
    false,
    false,
    false,
    false,
  ];
  List<String> names = ["Fajr", "Dzuhr", "Asr", "Maghrib", "Isha"];

  Map sql = {};

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/data.json');
  }

  void saveToBase(String date) {
    setState(() {
      sql[date] = checkedList;
      saveToFile();
    });
  }

  void readInBase(date) {
    setState(() {
      try {
        sql.containsKey(date);
        checkedList = sql["${now.year}-${now.month}-${now.day}"];
      } catch (e) {
        checkedList = [false, false, false, false, false];
        saveToBase("${now.year}-${now.month}-${now.day}");
      }
    });
  }

  String correctDateFormat(String input) {
    RegExp regExp = RegExp(r'^(\d{4})-(\d{1,2})-(\d{1,2})$');
    Match? match = regExp.firstMatch(input);

    if (match != null) {
      String year = match.group(1)!;
      String month = match
          .group(2)!
          .padLeft(2, '0'); // Добавляем ведущий ноль, если необходимо
      String day = match
          .group(3)!
          .padLeft(2, '0'); // Добавляем ведущий ноль, если необходимо
      return '$year-$month-$day';
    }

    return input;
  }

  Future<File> saveToFile() async {
    final file = await _localFile;
    String data = jsonEncode(sql);
    return file.writeAsString(data);
  }

  void readFromFile() async {
    final file = await _localFile;
    try {
      var data = await file.readAsString();
      sql = jsonDecode(data);
      readInBase("${now.year}-${now.month}-${now.day}");
    } catch (e) {
      saveToFile();
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      readFromFile();
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime nowTime = DateTime.now();

    String systemTime = "${nowTime.hour}:${nowTime.minute}";
    String currentDate = "${now.day}.${now.month}.${now.year}";

    void editCheck(value, int index) {
      setState(() {
        saveToBase("${now.year}-${now.month}-${now.day}");
        checkedList[index] = !checkedList[index];
      });
    }

    void editCheckOnTap(index) {
      setState(() {
        saveToBase("${now.year}-${now.month}-${now.day}");
        checkedList[index] = !checkedList[index];
      });
    }

    void checkAll() {
      setState(() {
        for (int i = 0; i < checkedList.length; i++) {
          checkedList[i] = true;
        }
        saveToBase("${now.year}-${now.month}-${now.day}");
      });
    }

    Future showDatePicker(context) {
      return showDialog(
          barrierColor: const Color.fromARGB(240, 42, 62, 79),
          context: context,
          builder: (context) {
            return MyDatePicker(
              cancel: () {
                Navigator.of(context).pop();
              },
              updateYear: (value) {
                editDate(value);
                Navigator.of(context).pop();
              },
              now: now,
              sql: sql,
            );
          });
    }

    return SafeArea(
      child: Stack(
        children: [
          Container(
            color: const Color.fromARGB(255, 30, 30, 57),
          ),
          Column(
            children: [
              // U P P E R -------
              Expanded(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: FittedBox(
                        child: SizedBox(
                          height: 100,
                          width: 250,
                          child: Column(
                            children: [
                              Expanded(child: Container(
                                //color: Colors.grey[200],
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  systemTime,
                                  style: const TextStyle(
                                    decoration: TextDecoration.none,
                                    fontFamily: "Spartan",
                                    fontWeight: FontWeight.w200,
                                    color: Color.fromARGB(255, 222, 222, 249),
                                  ),
                                ),
                              )),
                              Expanded(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    //color: Colors.grey[300],
                                    child: Text(
                                      currentDate,
                                      style: const TextStyle(
                                          decoration: TextDecoration.none,
                                          fontFamily: "Spartan",
                                          fontWeight: FontWeight.w100,
                                          color: Color.fromARGB(255, 222, 222, 249),
                                          fontSize: 25),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  )),
              // D O W N E R -------
              Expanded(
                  flex: 4,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 76, 76, 103),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                          topLeft: Radius.circular(40),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 26, right: 33),
                      child: ListView.builder(
                        itemCount: checkedList.length + 1,
                        itemBuilder: (BuildContext context, index) {
                          return index < checkedList.length
                              ? MyTimeLineTile(
                              onTapped: () => editCheckOnTap(index),
                              onChecked: (value) => editCheck(value, index),
                              text: names[index],
                              isFirst: index == 0 ? true : false,
                              isLast: index == 4 ? true : false,
                              isPast: checkedList[index],
                              index: index)
                              : const SizedBox(
                            height: 200,
                          );
                        },
                      ),
                    ),
                  ))
            ],
          ),
          Positioned(
              right: -80,
              bottom: 240,
              child: FloatMenuButton(
                  onCheckAll: () => checkAll(),
                  showDatePicker: () {
                    setState(() {
                      saveToBase("${now.year}-${now.month}-${now.day}");
                      showDatePicker(context);
                    });
                  },
                  nextDay: () => _nextDay(),
                  previousDay: () => _previousDay())),
        ],
      ),
    );
  }

  void _nextDay() {
    setState(() {
      int day = now.day;
      day++;
      String newDate = correctDateFormat("${now.year}-${now.month}-$day");
      now = DateTime.parse(newDate);
      readInBase(newDate);
    });
  }

  void editDate(DateTime value) {
    setState(() {
      DateTime newDate = value;
      now = newDate;
      readInBase(newDate);
    });
  }

  void _previousDay() {
    setState(() {
      int day = now.day;
      day--;
      String newDate = correctDateFormat("${now.year}-${now.month}-$day");
      now = DateTime.parse(newDate);
      readInBase(newDate);
    });
  }
}
