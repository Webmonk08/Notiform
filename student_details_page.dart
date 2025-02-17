import 'package:flutter/material.dart';
import 'student_home_page.dart';

class StudentDetailsPage extends StatefulWidget {
  const StudentDetailsPage({Key? key}) : super(key: key);

  @override
  _StudentDetailsPageState createState() => _StudentDetailsPageState();
}

class _StudentDetailsPageState extends State<StudentDetailsPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController collegeController = TextEditingController();
  final TextEditingController deptController = TextEditingController();
  final TextEditingController sectionController = TextEditingController();
  final TextEditingController yearController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account Created Successfully!')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const StudentHomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Student Details")),
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
              TextFormField(
                controller: collegeController,
                decoration: const InputDecoration(labelText: "College Name"),
                validator: (value) =>
                    value!.isEmpty ? "Enter your college name" : null,
              ),
              TextFormField(
                controller: deptController,
                decoration: const InputDecoration(labelText: "Department"),
                validator: (value) =>
                    value!.isEmpty ? "Enter your department" : null,
              ),
              TextFormField(
                controller: sectionController,
                decoration: const InputDecoration(labelText: "Section"),
                validator: (value) =>
                    value!.isEmpty ? "Enter your section" : null,
              ),
              TextFormField(
                controller: yearController,
                decoration: const InputDecoration(labelText: "Year of Study"),
                validator: (value) =>
                    value!.isEmpty ? "Enter your year of study" : null,
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
