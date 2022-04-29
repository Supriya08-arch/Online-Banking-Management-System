import 'package:flutter/material.dart';
import '../model/details.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);
  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(child: Text("28A"), value: "28A"),
    const DropdownMenuItem(child: Text("28B"), value: "28B"),
    const DropdownMenuItem(child: Text("28C"), value: "28C"),
  ];
  return menuItems;
}

class _ResultScreenState extends State<ResultScreen> {
  static const IconData delete = IconData(0xe1b9, fontFamily: 'MaterialIcons');
  String selectedValue = "28B";
  @override
  Widget build(BuildContext context) {
    List<Student> lstStudents =
        ModalRoute.of(context)!.settings.arguments as List<Student>;
    List<Student> lstBackup =
        lstStudents.where((i) => i.batch!.contains('$selectedValue')).toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Result Screen"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(
              width: double.infinity,
              child: Text(
                "Select a batch",
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: DropdownButton(
                isExpanded: true,
                value: selectedValue,
                items: dropdownItems,
                onChanged: (String? value) {
                  setState(() {
                    selectedValue = value!;
                  });
                },
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
                width: double.infinity,
                child: Text(
                  'Results of Batch $selectedValue',
                  style: const TextStyle(fontSize: 30, color: Colors.blue),
                  textAlign: TextAlign.center,
                )),
            const SizedBox(
              height: 8,
            ),
            Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                border: TableBorder.all(),
                children: [
                  TableRow(children: [
                    TableCell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const <Widget>[
                          Text('Name', textAlign: TextAlign.center),
                          Text('IOT', textAlign: TextAlign.center),
                          Text('API', textAlign: TextAlign.center),
                          Text('Web', textAlign: TextAlign.center),
                          Text('Percent', textAlign: TextAlign.center),
                          Text('Status', textAlign: TextAlign.center),
                          Text('Actions', textAlign: TextAlign.center),
                          // Text(student.fname.toString()),
                        ],
                      ),
                    ),
                  ]),
                  for (var student in lstBackup)
                    TableRow(children: [
                      TableCell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(student.name.toString(),
                                textAlign: TextAlign.center),
                            Text(student.batch.toString(),
                                textAlign: TextAlign.center),
                            Text(student.iot_marks.toString(),
                                textAlign: TextAlign.center),
                            Text(student.api_marks.toString(),
                                textAlign: TextAlign.center),
                            Text(student.flutter_marks.toString(),
                                textAlign: TextAlign.center),
                            Text(student.percentage!.toStringAsFixed(2),
                                textAlign: TextAlign.center),
                            Text(student.status.toString(),
                                textAlign: TextAlign.center),
                            TextButton.icon(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return (AlertDialog(
                                        title:
                                            const Text("Delete Confirmation"),
                                        content: const Text(
                                            "Are you sure you want to delete this record?"),
                                        actions: [
                                          TextButton(
                                            child: const Text("OK"),
                                            onPressed: () {
                                              setState(() {
                                                lstStudents.remove(student);
                                              });
                                              Navigator.pop(context);
                                            },
                                          ),
                                          TextButton(
                                            child: const Text("Cancle"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          )
                                        ]));
                                  },
                                );
                              },
                              icon: const Icon(delete),
                              label: const Text("Delete"),
                            )
                          ],
                        ),
                      ),
                    ])
                ])
          ],
        ),
      ),
    );
  }
}
