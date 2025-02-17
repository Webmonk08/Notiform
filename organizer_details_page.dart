import 'package:flutter/material.dart';
import 'package:citil/organizer_home_page.dart'; // ✅ Ensure correct import

class OrganizerDetailsPage extends StatefulWidget {
  const OrganizerDetailsPage({Key? key}) : super(key: key);

  @override
  _OrganizerDetailsPageState createState() => _OrganizerDetailsPageState();
}

class _OrganizerDetailsPageState extends State<OrganizerDetailsPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account Created Successfully!')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OrganizerHomePage()), // ✅ Correct navigation
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Organizer Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name"),
                validator: (value) => value!.isEmpty ? "Enter your name" : null,
              ),
              TextFormField(
                controller: dobController,
                decoration: const InputDecoration(labelText: "Date of Birth"),
                validator: (value) => value!.isEmpty ? "Enter your DOB" : null,
              ),
              TextFormField(
                controller: ageController,
                decoration: const InputDecoration(labelText: "Age"),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? "Enter your age" : null,
              ),
              TextFormField(
                controller: mobileController,
                decoration: const InputDecoration(labelText: "Mobile No."),
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    value!.length != 10 ? "Enter a valid 10-digit number" : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

