import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class List extends StatefulWidget {
  const List({super.key});

  @override
  State<List> createState() => _ListState();
}

class _ListState extends State<List> {
  @override
  Widget build(BuildContext context) {
    var box = Hive.box("cards");
    return Container(
      child: box.values.isNotEmpty
          ? ListView.builder(
              itemCount: box.values.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(127, 56, 56, 56),
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 28, 28, 28)
                              .withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        )
                      ]),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text("${box.getAt(index)[3]}",
                              style: const TextStyle(
                                  fontSize: 29,
                                  color: Color.fromARGB(255, 199, 199, 199))),
                          Text("${box.getAt(index)[2]}",
                              style: const TextStyle(
                                  fontSize: 29,
                                  color: Color.fromARGB(255, 199, 199, 199))),
                        ],
                      ),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              box.deleteAt(index);
                            });
                          },
                          child: const Icon(
                            Icons.delete,
                            size: 20,
                          ))
                    ],
                  ),
                );
              },
            )
          : const Text("add a remind"),
    );
  }
}
