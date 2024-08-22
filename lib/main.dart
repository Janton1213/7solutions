import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final ItemScrollController itemScrollController = ItemScrollController();
  var fibonacciList = [];
  var ice = [];
  var square = [];
  var circle = [];
  var plane = [];
  var removeItem = [];
  @override
  void initState() {
    calFibonacci(41);
    super.initState();
  }

  fibonacci(int n) {
    if (n == 0 || n == 1) {
      return n;
    }
    return fibonacci(n - 1) + fibonacci(n - 2);
  }

  calFibonacci(fibonacciNum) {
    for (var i = 0; i < fibonacciNum; i++) {
      fibonacciList.add([i, fibonacci(i)]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 20, top: 20),
          child: Center(
            child: ScrollablePositionedList.builder(
                itemScrollController: itemScrollController,
                itemCount: fibonacciList.length,
                itemBuilder: ((context, index) {
                  return Container(
                    color: removeItem.isNotEmpty && (removeItem[0] == fibonacciList[index][0]) ? Colors.red : null,
                    child: InkWell(
                      focusColor: Colors.red,
                      splashColor: Colors.amber,
                      onTap: () {
                        var showList = [];
                        IconData icon = Icons.abc;
                        var selectIndex = fibonacciList[index][0];
                        switch (fibonacciList[index][0] % 4) {
                          case 0:
                            ice.add(fibonacciList[index]);
                            showList = ice;
                            icon = Icons.ac_unit;
                            break;
                          case 1:
                            square.add(fibonacciList[index]);
                            showList = square;
                            icon = Icons.crop_square;
                            break;
                          case 2:
                            circle.add(fibonacciList[index]);
                            showList = circle;
                            icon = Icons.circle_rounded;
                            break;
                          case 3:
                            plane.add(fibonacciList[index]);
                            showList = plane;
                            icon = Icons.airplanemode_active;
                            break;
                          default:
                        }
                        setState(() {
                          fibonacciList.removeAt(index);
                        });
                        showList.sort((a, b) {
                          return a[0].compareTo(b[0]);
                        });
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox(
                              child: ListView.builder(
                                  itemCount: showList.length,
                                  itemBuilder: ((context, index2) {
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          fibonacciList.add(showList[index2]);
                                          removeItem = showList[index2];
                                          showList.removeAt(index2);
                                          fibonacciList.sort((a, b) {
                                            return a[0].compareTo(b[0]);
                                          });
                                        });
                                        itemScrollController.jumpTo(index: removeItem[0]);
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        color: showList[index2][0] == selectIndex ? Colors.green : null,
                                        padding: const EdgeInsets.all(10),
                                        child: InkWell(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('Number : ${showList[index2][1].toString()}'),
                                                  Text('Index : ${showList[index2][0].toString()}')
                                                ],
                                              ),
                                              Icon(icon)
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  })),
                            );
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Index : ${fibonacciList[index][0]}, Number : ${fibonacciList[index][1].toString()}',
                              style: const TextStyle(fontSize: 20),
                            ),
                            Icon(fibonacciList[index][0] % 4 == 1
                                ? Icons.crop_square
                                : fibonacciList[index][0] % 4 == 2
                                    ? Icons.circle_rounded
                                    : fibonacciList[index][0] % 4 == 3
                                        ? Icons.airplanemode_active
                                        : Icons.ac_unit)
                          ],
                        ),
                      ),
                    ),
                  );
                })),
          ),
        ),
      ),
    );
  }
}
