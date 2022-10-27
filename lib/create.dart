import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class Create extends StatefulWidget {
  const Create({super.key});

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  TimeOfDay _newTime = const TimeOfDay(hour: 00, minute: 00);
  DateTime _newDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    TextEditingController title = TextEditingController();
    TextEditingController description = TextEditingController();

    var box = Hive.box("cards");

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 26, 26, 26),
      appBar: AppBar(title: const Text("Create Remind")),
      body: Container(
        color: const Color.fromARGB(255, 26, 26, 26),
        padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
        child: Column(
          children: [
            TextField(
              maxLength: 15,
              cursorColor: Colors.amber,
              controller: title,
              maxLines: 1,
              style: const TextStyle(
                color: Color.fromARGB(255, 190, 190, 190),
              ),
              decoration: const InputDecoration(
                hintStyle: TextStyle(color: Color.fromARGB(255, 90, 90, 90)),
                prefixIcon: Icon(Icons.title),
                hintText: "Enter a title",
              ),
            ),
            TextField(
              maxLength: 15,
              cursorColor: Colors.amber,
              controller: description,
              maxLines: 8,
              style: const TextStyle(
                color: Color.fromARGB(255, 190, 190, 190),
              ),
              decoration: const InputDecoration(
                hintStyle: TextStyle(color: Color.fromARGB(255, 90, 90, 90)),
                prefixIcon: Icon(Icons.title),
                hintText: "Enter a title",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 270,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2021),
                          lastDate: DateTime(2100),
                          builder: (context, child) => Theme(
                            data: ThemeData().copyWith(
                                colorScheme: const ColorScheme.dark(
                                    primary: Colors.amber,
                                    surface: Color.fromARGB(255, 27, 27, 27),
                                    onSurface: Colors.white),
                                dialogBackgroundColor:
                                    const Color.fromARGB(255, 44, 44, 44)),
                            child: child!,
                          ),
                        ).then((value) {
                          setState(() {
                            _newDate = value!;
                          });
                        });
                      });
                    },
                    child: const Text("Add a date"),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      showTimePicker(
                          context: context,
                          initialTime: _newTime,
                          builder: (context, child) => Theme(
                              data: ThemeData().copyWith(
                                  colorScheme: const ColorScheme.dark(
                                      primary: Colors.amber,
                                      surface: Color.fromARGB(255, 27, 27, 27),
                                      onSurface: Colors.white),
                                  dialogBackgroundColor:
                                      const Color.fromARGB(255, 44, 44, 44)),
                              child: child!)).then((value) {
                        setState(() {
                          _newTime = value!;
                          debugPrint("${_newTime.hour}");
                          debugPrint("${_newTime.minute}");
                        });
                      });
                    },
                    child: const Text("Add time"),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  box.add([
                    title.text,
                    description.text,
                    "${_newDate.year}-${_newDate.month < 10 ? "0${_newDate.month}" : _newDate.month}-${_newDate.day < 10 ? "0${_newDate.day}" : _newDate.day} ",
                    "${_newTime.hour < 10 ? "0${_newTime.hour}" : _newTime.hour}:${_newTime.minute < 10 ? "0${_newTime.minute}" : _newTime.minute}"
                  ]);
                });
                Navigator.pop(context, "refresh");
              },
              child: const Text("submit"),
            )
          ],
        ),
      ),
    );
  }
}
