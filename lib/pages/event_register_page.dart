import 'dart:io';

import 'package:crash_course/modules/events.dart';
import 'package:crash_course/modules/user.dart';
import 'package:crash_course/modules/ws_webview.dart';
import 'package:crash_course/provider/user_detail_provider.dart';
import 'package:crash_course/pages/registration_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EventRegisterPage extends StatefulWidget {
  final Events event;
  const EventRegisterPage({super.key, required this.event});

  @override
  State<EventRegisterPage> createState() => _EventRegisterPageState();
}

class _EventRegisterPageState extends State<EventRegisterPage> {
  final nameController = TextEditingController();
  final icNumController = TextEditingController();
  final emailController = TextEditingController();
  final schoolInfoController = TextEditingController();
  final addressController = TextEditingController();
  File? selectedImage;
  late User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            children: [
              Text(
                'Registration Form',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              selectedImage != null
                  ? Image.file(selectedImage!, height: 180)
                  : Container(
                      decoration: BoxDecoration(color: Colors.grey[300]),
                      height: 180,
                      width: 180,
                      child: Center(child: Text('Upload an image')),
                    ),
              ElevatedButton(
                onPressed: () => pickImageFromGallery(),
                child: Text('Upload'),
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(hintText: 'Name'),
              ),
              TextField(
                controller: icNumController,
                decoration: InputDecoration(hintText: 'IC Number'),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(hintText: 'Email'),
              ),
              TextField(
                controller: schoolInfoController,
                decoration: InputDecoration(hintText: 'School Information'),
              ),
              TextField(
                controller: addressController,
                decoration: InputDecoration(hintText: 'Address'),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  if (selectedImage != null) {
                    user = User(
                      name: nameController.text,
                      icNum: icNumController.text,
                      email: emailController.text,
                      school: schoolInfoController.text,
                      address: addressController.text,
                      category: widget.event.Title,
                      profilePic: selectedImage!.path,
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Incomplete info'),
                          content: Text('Please insert an image.'),
                          actions: [
                            TextButton(
                              onPressed: Navigator.of(context).pop,
                              child: Text('Ok'),
                            ),
                          ],
                        );
                      },
                    );
                  }

                  Provider.of<UserDetailProvider>(
                    context,
                    listen: false,
                  ).addUser(user);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegistrationDetailPage(),
                    ),
                  );
                },
                child: Text('Submit'),
              ),
            ],
          ),
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

  Future pickImageFromGallery() async {
    final returnedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (returnedImage == null) return;
    setState(() {
      selectedImage = File(returnedImage.path);
    });
  }
}
