import 'package:crash_course/modules/ws_webview.dart';
import 'package:crash_course/provider/user_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationDetailPage extends StatefulWidget {
  const RegistrationDetailPage({super.key});

  @override
  State<RegistrationDetailPage> createState() => _RegistrationDetailPageState();
}

class _RegistrationDetailPageState extends State<RegistrationDetailPage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserDetailProvider>(context).userDetails;

    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/wsmb2024_logo.png', height: 65),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text('Registration Detail', style: titlestyle()),
            SizedBox(height: 40),
            Text(
              'Thank You for Your\nRegistration',
              style: titlestyle(),
              textAlign: TextAlign.center,
            ),
            DisplayText(content: user.name, styles: bodyStyle()),
            DisplayText(content: user.category, styles: bodyStyle()),
            DisplayText(content: user.icNum, styles: bodyStyle()),
            DisplayText(content: user.email, styles: bodyStyle()),
            DisplayText(content: user.school, styles: bodyStyle()),
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

TextStyle titlestyle() {
  return TextStyle(fontSize: 32, fontWeight: FontWeight.bold);
}

TextStyle bodyStyle() {
  return TextStyle(fontSize: 24, fontWeight: FontWeight.w500);
}

class DisplayText extends StatelessWidget {
  final String content;
  final TextStyle styles;
  const DisplayText({super.key, required this.content, required this.styles});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(content, style: styles),
    );
  }
}
