import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Daterange.dart';
import 'Notifications.dart';




class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {

  NotificationsManager _notificationsManager = NotificationsManager();
  List<Notifications> _notifications = [];
  bool isExpanded = false;
  String getCurrentTime() {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('HH:mm:ss').format(now);
    return formattedTime;
  }
  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }
  void _loadNotifications() {
    setState(() {
      _notifications = _notificationsManager.getNotificationsFromDatabase().cast<Notifications>();
    });
  }
  void _showNotificationWindow() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NotificationsScreen()),
    );
  }
  DateTime selectedDate = DateTime.now();

  void _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/grey.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child : LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            DateRangePickerBox(),
                            IconButton(
                              onPressed: () async {
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: selectedDate,
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100),
                                  builder: (BuildContext context,
                                      Widget? child) {
                                    return Theme(
                                      data: ThemeData.light().copyWith(
                                        primaryColor: Colors.deepPurple,
                                        // Set the primary color to purple
                                        colorScheme: ColorScheme.light(
                                          primary: Colors
                                              .deepPurple, // Set the primary color to purple
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  },
                                );
                                if (picked != null && picked != selectedDate) {
                                  setState(() {
                                    selectedDate = picked;
                                  });
                                }
                              },
                              icon: Icon(
                                Icons.calendar_today_outlined,
                                color: Colors.grey,
                                size: 30.0,
                              ),
                            ),

                            Text(
                              DateFormat('dd/MM/yyyy').format(selectedDate),
                              style: TextStyle(fontSize: 18.0),
                            ),


                            SizedBox(
                              width: 10.0,
                            ),
                            Stack(
                              children: [IconButton(
                                icon: Icon(
                                  Icons.notification_important_outlined,
                                  color: Colors.grey,
                                  size: 30.0,
                                ),
                                onPressed: _showNotificationWindow,


                              ),
                                Positioned(
                                  top: 7,
                                  right: 7,
                                  child: Container(
                                    width: 12,
                                    height: 12,
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                          color: Colors.redAccent, width: 2),),
                                  ),
                                ),
                              ],
                            ),


                            SizedBox(
                              width: 15.0,
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.lightBlueAccent,
                                  radius: 35.0,
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Adjust Flexible with responsive width
                            Flexible(
                              flex: constraints.maxWidth < 600 ? 1 : 2,
                              child: Card(
                                color: Colors.greenAccent.shade400,
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.monetization_on_outlined,
                                              color: Colors.white, size: 26.0),
                                          SizedBox(
                                            width: 15.0,
                                          ),
                                          Text(
                                            "TOTAL INCOME",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        "0.00 £",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 35.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Receivables",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 85.0,
                                          ),
                                          Text(
                                            "0.00£/0.00£",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: constraints.maxWidth < 600 ? 1 : 2,
                              child: Card(
                                color: Colors.blue.shade600,
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star_purple500,
                                            size: 26.0,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 15.0,
                                          ),
                                          Text(
                                            "TOTAL PROFIT",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 19.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        "0.00 £",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 35.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Upcoming",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 100.0,
                                          ),
                                          Text(
                                            "0.00£/0.00£",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: constraints.maxWidth < 600 ? 1 : 2,
                              child: Card(
                                color:
                                Colors.redAccent.shade400,
                                // set background color here

                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.shopping_cart,
                                            size: 26.0,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 15.0,
                                          ),
                                          Text(
                                            "TOTAL EXPENSES",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        "0.00 £",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 35.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Payables",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 100.0,
                                          ),
                                          Text(
                                            "0.00£/0.00£",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "INCOMES : ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              height: 15.0,
                              width: 50.0,
                              color: Colors.greenAccent.shade400,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              "TOTAL PROFIT : ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              height: 15.0,
                              width: 50.0,
                              color: Colors.lightBlue,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              "OUTCOMES : ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              height: 15.0,
                              width: 50.0,
                              color: Colors.redAccent.shade400,
                            ),

                          ],
                        ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.purple, // Purple background
                            ),

                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
    ),
        ),
    );

  }
  }
