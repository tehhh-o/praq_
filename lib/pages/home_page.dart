import 'dart:convert';
import 'package:crash_course/modules/events.dart';
import 'package:crash_course/modules/ws_webview.dart';
import 'package:crash_course/pages/event_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Events> events;
  List<Events> filteredEvents = [];
  final cateorgyController = TextEditingController();
  String filteredCategory = '';

  Future<void> getEvents() async {
    final data = await rootBundle.loadString('assets/data.json');
    final body = jsonDecode(data);

    setState(() {
      events = body.map<Events>(Events.fromJson).toList();
    });
  }

  @override
  void initState() {
    getEvents();
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
            TextField(
              onSubmitted: (value) {
                setState(() {
                  filteredCategory = value;
                  filteredEvents = events
                      .where(
                        (event) => event.Title.toLowerCase().contains(
                          filteredCategory.toLowerCase(),
                        ),
                      )
                      .toList();
                });
              },
              controller: cateorgyController,
              decoration: InputDecoration(
                hintText: 'Search by category',
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      filteredCategory = cateorgyController.text;
                      filteredEvents = events
                          .where(
                            (event) => event.Title.toLowerCase().contains(
                              filteredCategory.toLowerCase(),
                            ),
                          )
                          .toList();
                    });
                  },
                  icon: Icon(Icons.search),
                ),
              ),
            ),
            EventCard(events: filteredCategory == '' ? events : filteredEvents),
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

class EventCard extends StatelessWidget {
  final List<Events> events;
  const EventCard({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      return Center(child: Text('No event matching your search'));
    }

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
