import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize notification service
  final NotificationService notificationService = NotificationService();
  await notificationService.initNotification();

  runApp(MyApp(notificationService: notificationService));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.notificationService}) : super(key: key);
  final NotificationService notificationService;
  final String appName = 'Depot AutoHub'; // Default app name

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Depot',
                style: TextStyle(
                  color: Color.fromARGB(255, 186, 12, 0),
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                ' AutoHub',
                style: TextStyle(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(11),
              color: Colors.grey[800],
              child: Row(
                children: [
                  Text(
                    'New Bookings',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('submitform')
                    
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
    notificationService.showNotification(
      title: 'New Booking',
      body: 'New booking received!',
    );
  }

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: 20,
                      columns: [
                        DataColumn(
                            label: Text('Booking Time',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text('Mobile No.',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text('Service',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text('Vehicle',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold))),
                      ],
                      rows: snapshot.data!.docs.map((doc) {
                        String dateTimePicker = doc['datetimepicker'];
                        String mobileNumber = doc['mobilenumber'];
                        String service = doc['service'];
                        String vehicle = doc['vehicle'];

                        DateTime dateTimeValue =
                            DateTime.parse(dateTimePicker);
                        String formattedDate =
                            DateFormat('dd\'th\' MMM ').format(dateTimeValue);
                        String formattedTime =
                            DateFormat('HH:mm').format(dateTimeValue);
                        String combinedDateTime =
                            '$formattedDate\n$formattedTime';

                        return DataRow(
                          cells: [
                            DataCell(
                              Row(
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    color: Color.fromARGB(255, 111, 0, 0),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    combinedDateTime,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              onTap: () {
                                _showDeleteConfirmationDialog(
                                    context, doc.id);
                              },
                            ),
                            DataCell(
                              Text(
                                mobileNumber,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              onTap: () {
                                _showDeleteConfirmationDialog(
                                    context, doc.id);
                              },
                            ),
                            DataCell(
                              Text(
                                service,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              onTap: () {
                                _showDeleteConfirmationDialog(
                                    context, doc.id);
                              },
                            ),
                            DataCell(
                              Text(
                                vehicle,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              onTap: () {
                                _showDeleteConfirmationDialog(
                                    context, doc.id);
                              },
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
            
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, String docId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Text(
            'Delete Confirmation',
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            'Are you sure you want to delete this entry?',
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('submitform')
                    .doc(docId)
                    .delete();
                Navigator.of(context).pop();
              },
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('logo3');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }
}
