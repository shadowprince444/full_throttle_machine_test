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

  final pageController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    date = DateTime.now();
    firstDate = date.subtract(Duration(days: date.day));
    currentMonth = date.month;
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
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * .4,
                    width: size.width,
                    child: GridView.builder(
                        itemCount: 35,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 7,
                        ),
                        itemBuilder: (context, index) {
                          final day = firstDate.add(Duration(days: index));
                          return Container(
                              alignment: Alignment.center,
                              // margin: EdgeInsets.all(size.height * .05),
                              color: Colors.blue,
                              height: size.height * .4 * .4,
                              width: size.height * .4 * .4,
                              child: Text(
                                "${day.day}",
                              ));
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

  onMonthIncremented() => setState(() {
        if (currentMonth < 12) {
          currentMonth++;
        } else {
          currentMonth = 1;
        }
        firstDate = DateTime(firstDate.year, currentMonth, 1);
      });

  onMonthDecremented() => setState(() {
        if (currentMonth > 1) {
          currentMonth++;
        } else {
          currentMonth = 12;
        }
        currentMonth--;
        firstDate = DateTime(firstDate.year, currentMonth, 1);
      });

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
