import 'package:flutter/material.dart';

class MyDatePicker extends StatefulWidget {
  final ValueChanged<DateTime> updateYear;
  final VoidCallback cancel;
  final DateTime now;
  final Map sql;

  const MyDatePicker(
      {super.key,
      required this.now,
      required this.updateYear,
      required this.cancel,
      required this.sql});

  @override
  State<MyDatePicker> createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  int selectedIndex = DateTime.now().day;
  DateTime currentDate = DateTime.now();
  List<String> monthNames = [
    "",
    "Январь",
    "Февраль",
    "Март",
    "Апрель",
    "Май",
    "Июнь",
    "Июль",
    "Август",
    "Сентябрь",
    "Октябрь",
    "Ноябрь",
    "Декабрь"
  ];
  List<String> weekShortNames = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"];
  late DateTime now;

  @override
  void initState() {
    super.initState();
    now = widget.now;
    selectedIndex = now.day;
  }

  @override
  Widget build(BuildContext context) {
    int getMonthMaxDay(int year, int month) {
      DateTime firstDayNextMonth = DateTime(year, month + 1, 1);
      return firstDayNextMonth.subtract(const Duration(days: 1)).day;
    }

    int getWeekDay(int year, int month) {
      DateTime date = DateTime(year, month, 1);
      int dayOfWeek = date.weekday;
      switch (dayOfWeek) {
        case (1):
          {
            dayOfWeek = 6;
            break;
          }
        case (2):
          {
            dayOfWeek = 7;
            break;
          }
        case (3):
          {
            dayOfWeek = 8;
            break;
          }
        case (4):
          {
            dayOfWeek = 9;
            break;
          }
        case (5):
          {
            dayOfWeek = 10;
            break;
          }
        case (6):
          {
            dayOfWeek = 11;
            break;
          }
        case (7):
          {
            dayOfWeek = 12;
            break;
          }
      }
      return dayOfWeek;
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

    DateTime incrementMonth(DateTime date) {
      int newMonth = date.month + 1;
      int newYear = date.year;

      if (newMonth > 12) {
        newMonth = 1;
        newYear += 1;
      }

      return DateTime(newYear, newMonth, date.day);
    }

    DateTime dencrementMonth(DateTime date) {
      int newMonth = date.month - 1;
      int newYear = date.year;

      if (newMonth < 1) {
        newMonth = 12;
        newYear -= 1;
      }

      return DateTime(newYear, newMonth, date.day);
    }

    return SafeArea(
      child: Stack(
        children: [
          Align(
            alignment: Alignment(0, -0.5),
            child: Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Container(
                height: 480,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: const Color.fromARGB(255, 76, 76, 101)),
                child: Column(
                  children: [
                    Expanded(
                        child: Container(
                      child: Row(
                        children: [
                          Expanded(
                              child: Container(
                            //margin: EdgeInsets.only(left: 6),
                            //color: Colors.green.shade200,
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    now = dencrementMonth(now);
                                  });
                                },
                                icon: const Icon(
                                  Icons.arrow_back_ios_new_outlined,
                                  color: Color.fromARGB(255, 222, 222, 249),
                                )),
                          )),
                          Expanded(
                              flex: 5,
                              child: Container(
                                //color: Colors.green,
                                child: Center(
                                  child: GestureDetector(
                                      // START DIALOG ----------------------------------------------
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              TextEditingController controller =
                                                  TextEditingController();
                                              return Align(
                                                alignment: const Alignment(0, -0.5),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 25),
                                                  child: SizedBox(
                                                    height: 200,
                                                    width: 350,
                                                    child: Material(
                                                      color: const Color.fromARGB(
                                                          255, 76, 76, 103),
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  20)),
                                                      child: Padding(
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 10),
                                                        child: Column(
                                                          children: [
                                                            const Align(
                                                                alignment: Alignment
                                                                    .topCenter,
                                                                child: Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          top: 20),
                                                                  child: Text(
                                                                    "Введите Дату",
                                                                    style: TextStyle(
                                                                        color: Color
                                                                            .fromARGB(
                                                                                255,
                                                                                222,
                                                                                222,
                                                                                249),
                                                                        fontFamily:
                                                                            "Spartan",
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            16),
                                                                  ),
                                                                )),
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            Align(
                                                              alignment:
                                                                  Alignment.center,
                                                              child: TextField(
                                                                cursorColor:
                                                                    const Color
                                                                        .fromARGB(
                                                                        255,
                                                                        222,
                                                                        222,
                                                                        249),
                                                                controller:
                                                                    controller,
                                                                style: const TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            222,
                                                                            222,
                                                                            249)),
                                                                keyboardType:
                                                                    TextInputType
                                                                        .datetime,
                                                                autofocus: true,
                                                                decoration:
                                                                    InputDecoration(
                                                                        //fillColor: Colors.red,
                                                                        focusedBorder: const OutlineInputBorder(
                                                                            borderSide: BorderSide(
                                                                                color: Color.fromARGB(
                                                                                    255,
                                                                                    222,
                                                                                    222,
                                                                                    249))),
                                                                        border: OutlineInputBorder(
                                                                            borderSide: BorderSide(
                                                                                width:
                                                                                    0.5,
                                                                                color: Colors
                                                                                    .grey.shade300)),
                                                                        hintText:
                                                                            "2024-3-23",
                                                                        hintStyle: const TextStyle(
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                144,
                                                                                144,
                                                                                162),
                                                                            fontFamily:
                                                                                "Spartan",
                                                                            fontWeight:
                                                                                FontWeight.normal)),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 15,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                MaterialButton(
                                                                    color: Colors
                                                                        .transparent,
                                                                    splashColor:
                                                                        Colors.grey
                                                                            .shade500,
                                                                    hoverElevation:
                                                                        0,
                                                                    highlightElevation:
                                                                        0,
                                                                    highlightColor:
                                                                        Colors
                                                                            .transparent,
                                                                    focusColor: Colors
                                                                        .transparent,
                                                                    hoverColor: Colors
                                                                        .transparent,
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                15)),
                                                                    elevation: 0,
                                                                    onPressed: () {
                                                                      controller
                                                                          .text = "";
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                      "Отмена",
                                                                      style: TextStyle(
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              222,
                                                                              222,
                                                                              249),
                                                                          fontFamily:
                                                                              "Spartan"),
                                                                    )),
                                                                MaterialButton(
                                                                  color: Colors
                                                                      .transparent,
                                                                  splashColor:
                                                                      Colors.grey
                                                                          .shade500,
                                                                  hoverElevation: 0,
                                                                  highlightElevation:
                                                                      0,
                                                                  highlightColor:
                                                                      Colors
                                                                          .transparent,
                                                                  focusColor: Colors
                                                                      .transparent,
                                                                  hoverColor: Colors
                                                                      .transparent,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                                  15)),
                                                                  elevation: 0,
                                                                  onPressed: () {
                                                                    String text =
                                                                        controller
                                                                            .text;
                                                                    text =
                                                                        correctDateFormat(
                                                                            text);
                                                                    try {
                                                                      DateTime
                                                                          edit =
                                                                          DateTime.parse(
                                                                              text);
                                                                      setState(() {
                                                                        now = edit;
                                                                        selectedIndex =
                                                                            now.day;
                                                                      });
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    } catch (e) {
                                                                      controller
                                                                              .text =
                                                                          "Формат: год-месяц-день";
                                                                      //Navigator.of(context).pop();
                                                                    }
                                                                  },
                                                                  child: const Text(
                                                                      "Сохранить",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Color
                                                                            .fromARGB(
                                                                                255,
                                                                                222,
                                                                                222,
                                                                                249),
                                                                        fontFamily:
                                                                            "Spartan",
                                                                      )),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            });
                                      },
                                      // END DIALOG   ----------------------------------------------
                                      child: Text(
                                          "${monthNames[now.month]} - ${now.year}",
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color:
                                                Color.fromARGB(255, 222, 222, 249),
                                            decoration: TextDecoration.none,
                                            fontFamily: "Spartan",
                                          ))),
                                ),
                              )),
                          Expanded(
                              child: Container(
                            //color: Colors.green.shade200,
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    now = incrementMonth(now);
                                  });
                                },
                                icon: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Color.fromARGB(255, 222, 222, 249),
                                )),
                          ))
                        ],
                      ),
                    )),
                    const Divider(
                      thickness: 1,
                    ),
                    Expanded(
                        flex: 6,
                        child: Container(
                          //color:Colors.grey.shade400,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: GridView.builder(
                                itemCount: 43 + now.weekday,
                                physics: const ScrollPhysics(
                                    parent: NeverScrollableScrollPhysics()),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 7),
                                itemBuilder: (context, index) {
                                  int days =
                                      index - getWeekDay(now.year, now.month);
                                  String cout(int index, DateTime now, int days,
                                      List<String> weekShortNames) {
                                    String text = " ";
                                    if (index < 7) {
                                      text = weekShortNames[index];
                                    } else if (days < 1) {
                                      text = "";
                                    } else if (days <=
                                        getMonthMaxDay(now.year, now.month)) {
                                      text = "$days";
                                    } else {
                                      text = "";
                                    }
                                    return text;
                                  }

                                  Color setupColor() {
                                    DateTime orDate = DateTime.now();
                                    Color finish = Colors.transparent;
                                    Map sql = widget.sql;
                                    if (selectedIndex == days) {
                                      finish =
                                          const Color.fromARGB(255, 222, 222, 249);
                                    } else if ("${now.year}-${now.month}-$days" ==
                                        "${orDate.year}-${orDate.month}-${orDate.day}") {
                                      finish = Colors.purpleAccent;
                                    } else if (days > 0 &&
                                        days <=
                                            getMonthMaxDay(now.year, now.month)) {
                                      try {

                                        if(sql["${now.year}-${now.month}-$days"].every((element) => element == true)){
                                          finish = const Color.fromARGB(255, 64, 255, 73);
                                        }else{
                                          finish = Colors.red;
                                        }
                                      } catch (e) {
                                        finish = Colors.red;
                                      }
                                    } else {
                                      finish = Colors.transparent;
                                    }
                                    return finish;
                                  }

                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (days > 0 &&
                                            days <=
                                                getMonthMaxDay(
                                                    now.year, now.month)) {
                                          selectedIndex = days;
                                        }
                                      });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.all(1),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              width: 1, color: setupColor()),
                                          color: selectedIndex == days
                                              ? const Color.fromARGB(
                                                  255, 87, 87, 87)
                                              : Colors.transparent),
                                      child: Center(
                                        child: Text(
                                          cout(index, now, days, weekShortNames),
                                          style: TextStyle(
                                            fontSize: index < 7 ? 15 : 13,
                                            decoration: TextDecoration.none,
                                            color: const Color.fromARGB(
                                                255, 222, 222, 249),
                                            fontFamily: "Spartan",
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        )),
                    Expanded(
                        child: Container(
                      //color:Colors.grey.shade200
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          MaterialButton(
                              color: Colors.transparent,
                              splashColor: Colors.grey.shade500,
                              hoverElevation: 0,
                              highlightElevation: 0,
                              highlightColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              elevation: 0,
                              onPressed: widget.cancel,
                              child: const Text(
                                "Отмена",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 222, 222, 249),
                                ),
                              )),
                          MaterialButton(
                            color: Colors.transparent,
                            splashColor: Colors.grey.shade500,
                            hoverElevation: 0,
                            highlightElevation: 0,
                            highlightColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            elevation: 0,
                            onPressed: () => widget.updateYear(
                                DateTime(now.year, now.month, selectedIndex)),
                            child: const Text("Сохранить",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 222, 222, 249))),
                          )
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
