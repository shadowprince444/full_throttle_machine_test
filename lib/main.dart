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
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  late DateTime firstDate;
  late DateTime date;
  late int currentMonth;
  late int currentYear;

  final pageController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    date = DateTime.now();
    firstDate = date.subtract(Duration(days: date.day - 1));
    currentMonth = date.month;
    currentYear = date.year;
  }

  @override
  Widget build(BuildContext context) {
    //

    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ColoredBox(
              color: Colors.grey,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * .1,
                    width: double.infinity,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: onMonthDecremented,
                          child: const Icon(
                            Icons.arrow_back_ios,
                          ),
                        ),
                        Text(
                          generateMonthName(currentMonth),
                        ),
                        GestureDetector(
                          onTap: onMonthIncremented,
                          child: const Icon(Icons.arrow_forward_ios),
                        ),
                        Expanded(
                          child: SizedBox(),
                        ),
                        GestureDetector(
                          onTap: onYearDecremented,
                          child: const Icon(
                            Icons.arrow_back_ios,
                          ),
                        ),
                        Text(
                          "$currentYear",
                        ),
                        GestureDetector(
                          onTap: onYearIncremented,
                          child: const Icon(Icons.arrow_forward_ios),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: size.width,
                    child: GridView.builder(
                        itemCount: 42,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 7,
                        ),
                        itemBuilder: (context, index) {
                          int dateIndex = index - 7;
                          final day = firstDate.add(Duration(days: dateIndex + 1 - firstDate.weekday));
                          if (index < 7) {
                            return DateWidget(size: size, data: generateWeekName(index + 1), color: Colors.red.withOpacity(.5));
                          } else {
                            if (dateIndex + 1 < firstDate.weekday) {
                              return DateWidget(size: size, data: "${day.day}", color: Colors.blue.withOpacity(.5));
                            } else {
                              if (DateTime(firstDate.year, firstDate.month + 1, 1).isAfter(day)) {
                                return DateWidget(
                                  size: size,
                                  data: "${day.day}",
                                  color: Colors.blue,
                                );
                              } else {
                                return DateWidget(size: size, data: "${day.day}", color: Colors.blue.withOpacity(.5));
                              }
                            }
                          }
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  onYearIncremented() {
    setState(() {
      currentYear++;
      firstDate = DateTime(currentYear, currentMonth, 1);
    });
  }

  onYearDecremented() {
    setState(() {
      currentYear--;
      firstDate = DateTime(currentYear, currentMonth, 1);
    });
  }

  onMonthIncremented() => setState(() {
        if (currentMonth < 12) {
          currentMonth++;
        } else {
          currentYear++;
          currentMonth = 1;
        }
        firstDate = DateTime(currentYear, currentMonth, 1);
        print(firstDate.weekday);
      });

  onMonthDecremented() => setState(() {
        if (currentMonth > 1) {
          currentMonth--;
        } else {
          currentMonth = 12;
          currentYear--;
        }

        firstDate = DateTime(currentYear, currentMonth, 1);
        print(firstDate.weekday);
      });

  String generateWeekName(int weekIndex) {
    switch (weekIndex) {
      case 1:
        return "Mon";
      case 2:
        return "Tue";
      case 3:
        return "Wed";
      case 4:
        return "Thu";
      case 5:
        return "Fri";
      case 6:
        return "Sat";
      case 7:
        return "Sun";

      default:
        return "Invalid Week";
    }
  }

  //Akash.krishnan@fullthrottlelabs.com
  String generateMonthName(int monthIndex) {
    switch (monthIndex) {
      case 1:
        return "Jan";
      case 2:
        return "Feb";
      case 3:
        return "Mar";
      case 4:
        return "APR";
      case 5:
        return "MAY";
      case 6:
        return "JUN";
      case 7:
        return "JUL";
      case 8:
        return "AUG";
      case 9:
        return "SEP";
      case 10:
        return "OCT";
      case 11:
        return "NOV";
      case 12:
        return "Dec";
      default:
        return "Invalid Month";
    }
  }
}

class DateWidget extends StatelessWidget {
  const DateWidget({
    Key? key,
    required this.size,
    required this.data,
    required this.color,
  }) : super(key: key);

  final Size size;
  final String data;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        // margin: EdgeInsets.all(size.height * .05),
        color: color,
        height: size.height * .4 * .4,
        width: size.height * .4 * .4,
        child: Text(
          data,
        ));
  }
}
