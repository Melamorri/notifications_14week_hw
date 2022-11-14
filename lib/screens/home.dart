import 'package:flutter/material.dart';
import 'package:notifications_14week_hw/screens/home.dart';
import 'package:notifications_14week_hw/services/local_notification_service.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final LocalNotificationService service;

  @override
  void initState() {
    service = LocalNotificationService();
    service.intialize();
    listenToNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мучаю уведомления'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: SizedBox(
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Давай кодить!',
                    style: TextStyle(fontSize: 20),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await service.showNotification(
                          id: 0, title: 'Ура!', body: 'Работает');
                    },
                    child: const Text('Здесь Local Notification'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await service.showScheduledNotification(
                        id: 1,
                        title: 'Тук-тук',
                        body: 'Время кодить. СЕЙЧАС',
                        seconds: 4,
                      );
                    },
                    child: const Text('Напоминание через 4 секунды'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await service.scheduleDaily8AMNotification(
                        id: 1,
                        title: 'Тук-тук',
                        body: '8 утра, давай кодить',
                      );
                    },
                    child: const Text('Поставим уведомление на 8 утра'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void listenToNotification() =>
      service.onNotificationClick.stream.listen(onNoticationListener);

  void onNoticationListener(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      print('payload $payload');

      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: ((context) => SecondScreen(payload: payload))));
    }
  }
}
