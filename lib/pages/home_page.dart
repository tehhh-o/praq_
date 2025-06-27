import 'dart:convert';
import 'package:crash_course/modules/events.dart';
import 'package:crash_course/modules/ws_webview.dart';
import 'package:crash_course/pages/event_detail_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Events>> eventFuture;

  Future<List<Events>> getEvents(BuildContext context) async {
    final assetsBundle = DefaultAssetBundle.of(context);
    final data = await assetsBundle.loadString('assets/data.json');
    final body = jsonDecode(data);

    return body.map<Events>(Events.fromJson).toList();
  }

  @override
  void initState() {
    eventFuture = getEvents(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/wsmb2024_logo.png', height: 65),
        centerTitle: true,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white60,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(decoration: InputDecoration(hintText: 'Search')),
            Expanded(
              child: FutureBuilder(
                future: eventFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final events = snapshot.data!;
                    return EventCards(events: events);
                  } else {
                    return Text('no data');
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: TextButton(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => WebviewPage()));
        },
        child: Text('Official Page'),
      ),
    );
  }
}

class EventCards extends StatelessWidget {
  final List<Events> events;
  const EventCards({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];

          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EventDetailPage(event: event),
              ),
            ),
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 12),
              child: Padding(
                padding: EdgeInsetsGeometry.all(8),
                child: Row(
                  children: [
                    Image.asset(event.Image, height: 100),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            Text(
                              event.Title,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              event.Description,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
