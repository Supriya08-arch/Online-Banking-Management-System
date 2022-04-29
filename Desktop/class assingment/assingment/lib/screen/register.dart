import 'package:assingment/screen/result.dart';
import 'package:flutter/material.dart';
import '../model/details.dart';

class Student_Details extends StatefulWidget {
  const Student_Details({Key? key}) : super(key: key);
  @override
  State<Student_Details> createState() => _Student_DetailsState();
}

class _Student_DetailsState extends State<Student_Details> {
  List<String> items = ["28A", "28B", "28C"];
  String? name, batch, status;
  double? iot_marks, flutter_marks, api_marks, total, percentage;
  List<Student> student = [];
  addStudent(Student stu) {
    setState(() {
      student.add(stu);
      print(student.length);
    });
  }

  final _global_key = GlobalKey<FormState>();
  @override
  int result = 0;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Student Details"),
      ),
      // ignore: prefer_const_literals_to_create_immutables
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        // ignore: prefer_const_literals_to_create_immutables
        child: Form(
          key: _global_key,
          child: Column(children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: "Enter name",
                labelText: "Enter name",
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter your name";
                }
                return null;
              },
              onChanged: (value) {
                name = value;
              },
            ),
            const SizedBox(height: 1),
            DropdownButton(
              hint: const Text('select batch:'),
              dropdownColor: Color.fromARGB(255, 232, 232, 234),
              icon: const Icon(Icons.arrow_drop_down),
              isExpanded: true,
              iconSize: 36,
              value: batch,
              onChanged: (dynamic newValue) {
                setState(() {
                  batch = newValue;
                });
              },
              items: items.map(
                (String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                },
              ).toList(),
            ),
            const SizedBox(height: 1),
            TextFormField(
              decoration: const InputDecoration(
                  hintText: "Enter api marks", labelText: "Enter api marks"),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter api marks";
                }
              },
              onChanged: (value) {
                setState(() {
                  api_marks = double.parse(value);
                });
              },
            ),
            const SizedBox(
              height: 1,
            ),
            TextFormField(
                decoration: const InputDecoration(
                    hintText: "Enter andriod marks",
                    labelText: "Enter andriod marks"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter andriod marks";
                  }
                },
                onChanged: (value) {
                  setState(() {
                    flutter_marks = double.parse(value);
                  });
                }),
            const SizedBox(
              height: 1,
            ),
            TextFormField(
                decoration: const InputDecoration(
                    hintText: "Enter IOT marks", labelText: "Enter IOT marks"),
                onChanged: (value) {
                  setState(() {
                    iot_marks = double.parse(value);
                  });
                }),
            SizedBox(
              child: ElevatedButton(
                onPressed: () {
                  if (_global_key.currentState!.validate()) {
                    setState(() {
                      total = api_marks! + flutter_marks! + iot_marks!;
                      percentage = total! / 3;
                      status = total! > 50 ? "Pass" : "Fail";
                      Student student = Student(
                          name: name,
                          batch: batch,
                          api_marks: api_marks,
                          flutter_marks: flutter_marks,
                          iot_marks: iot_marks,
                          percentage: percentage,
                          status: status);
                      addStudent(student);
                    });
                  }
                },
                child: const Text("Add Student"),
              ),
            ),
            SizedBox(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/view', arguments: student);
                },
                child: const Text("View Result"),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
