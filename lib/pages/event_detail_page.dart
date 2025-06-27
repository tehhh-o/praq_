import 'package:crash_course/modules/events.dart';
import 'package:crash_course/modules/ws_webview.dart';
import 'package:crash_course/pages/event_register_page.dart';
import 'package:flutter/material.dart';

class EventDetailPage extends StatefulWidget {
  final Events event;
  const EventDetailPage({super.key, required this.event});

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  bool readMore = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Event Details',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Image.asset(widget.event.Image, height: 160),
            ),
            Text(
              widget.event.Title,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
            ),
            Spacer(),
            Text(
              widget.event.Description,
              maxLines: readMore ? 10 : 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  readMore = true;
                });
              },
              child: Text(readMore ? '' : 'Read More...'),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        EventRegisterPage(event: widget.event),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text('Register'),
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
