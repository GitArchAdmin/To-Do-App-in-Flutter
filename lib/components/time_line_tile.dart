import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MyTimeLineTile extends StatefulWidget {
  final bool isFirst;
  final bool isLast;
  final bool isPast;
  final int index;
  final String text;
  final ValueChanged<bool?> onChecked;
  final GestureTapCallback onTapped;

  const MyTimeLineTile(
      {super.key,
      required this.isFirst,
      required this.isLast,
      required this.isPast,
      required this.index,
      required this.text,
      required this.onChecked,
      required this.onTapped});

  @override
  State<MyTimeLineTile> createState() => _MyTimeLineTileState();
}

class _MyTimeLineTileState extends State<MyTimeLineTile> {
  Color white = const Color.fromARGB(255, 222, 222, 249);
  final style = [
    const LineStyle(color: Color(0xFF9756F9)),
    const LineStyle(color: Color(0xFF3C3C57))
  ];
  final indiStyle = [
    const IndicatorStyle(width: 33, color: Color(0xFF9756F9)),
    const IndicatorStyle(width: 33, color: Color(0xFF3C3C57)),
  ];
  final List icons = [
    Icons.nights_stay_rounded,
    Icons.sunny,
    Icons.sunny_snowing,
    Icons.nightlight_round_outlined,
    Icons.star_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    var perLine = widget.isPast ? style[0] : style[1];
    var perIndi = widget.isPast ? indiStyle[0] : indiStyle[1];

    return SizedBox(
      height: 133,
      child: TimelineTile(
        isFirst: widget.isFirst,
        isLast: widget.isLast,
        beforeLineStyle: perLine,
        indicatorStyle: perIndi,
        endChild: GestureDetector(
          onTap: widget.onTapped,
          child: Padding(
            padding: const EdgeInsets.only(left: 23, right: 10),
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 123, 123, 149),
                borderRadius: BorderRadius.circular(33),
                boxShadow: [
                  const BoxShadow(
                      color: Color.fromARGB(134, 70, 70, 70),
                      spreadRadius: 0.2,
                      blurRadius: 6,
                      offset: Offset(2, 5))
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Center(
                          child: Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                                color: widget.index % 2 == 0
                                    ? const Color(0xFF967FCF)
                                    : const Color(0xFFC980D0),
                                borderRadius: BorderRadius.circular(25)),
                            child: Icon(
                              icons[widget.index],
                              size: 60,
                              color: const Color.fromARGB(255, 222, 222, 249),
                            ),
                          ),
                        )),
                    Expanded(
                        flex: 3,
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Center(
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: FittedBox(
                                  child: Text(
                                    widget.text,
                                    style: const TextStyle(
                                        decoration: TextDecoration.none,
                                        fontFamily: "Spartan",
                                        fontWeight: FontWeight.w100,
                                        color:
                                            Color.fromARGB(255, 222, 222, 249)),
                                  ),
                                )),
                          ),
                        )),
                    Expanded(
                        child: FittedBox(
                      child: Center(
                        child: Material(
                          color: Colors.transparent,
                          child: Checkbox(
                              focusColor: Colors.transparent,
                              checkColor: Colors.grey[300],
                              value: widget.isPast,
                              activeColor: Colors.grey[600],
                              onChanged: widget.onChecked),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
