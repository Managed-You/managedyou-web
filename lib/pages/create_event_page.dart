import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum EventType { remote, onsite }

enum EventDate { oneday, multiday }

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({Key? key}) : super(key: key);

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  EventType _eventType = EventType.onsite;
  EventDate _eventDate = EventDate.oneday;
  DateTime dateTime = DateTime.now();
  TimeOfDay commenceTime = TimeOfDay.now();
  DateTimeRange dateTimeRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().add(
      const Duration(days: 1),
    ),
  );

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    DateTime start = dateTimeRange.start;
    DateTime end = dateTimeRange.end;
    DateTime date = dateTime;
    TimeOfDay commence = commenceTime;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Event"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text("Create"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        icon: const Icon(Icons.send_rounded),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    focusColor: Colors.black,
                    floatingLabelStyle: const TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Name of the Event',
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        ListTile(
                          title: const Text('One Day Event'),
                          leading: Radio<EventDate>(
                            fillColor: MaterialStateColor.resolveWith(
                              (states) => Theme.of(context).colorScheme.primary,
                            ),
                            value: EventDate.oneday,
                            groupValue: _eventDate,
                            onChanged: (EventDate? value) {
                              setState(() {
                                _eventDate = value!;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('Multi Day Event'),
                          leading: Radio<EventDate>(
                            fillColor: MaterialStateColor.resolveWith(
                              (states) => Theme.of(context).colorScheme.primary,
                            ),
                            value: EventDate.multiday,
                            groupValue: _eventDate,
                            onChanged: (EventDate? value) {
                              setState(() {
                                _eventDate = value!;
                              });
                            },
                          ),
                        ),
                        (_eventDate == EventDate.multiday)
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Text("From"),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ElevatedButton(
                                          onPressed: pickDateRange,
                                          child: Text(
                                              "${start.day}/${start.month}/${start.year}"),
                                        ),
                                      ),
                                      const Text("To"),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ElevatedButton(
                                          onPressed: pickDateRange,
                                          child: Text(
                                              "${end.day}/${end.month}/${end.year}"),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                      "A ${end.difference(start).inDays} days event"),
                                ],
                              )
                            : Row(
                                children: [
                                  const Text("On"),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      onPressed: pickDate,
                                      child: Text(
                                          "${date.day}/${date.month}/${date.year}"),
                                    ),
                                  ),
                                ],
                              ),
                        Row(
                          children: [
                            const Text("Start Time"),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: pickTime,
                                child:
                                    Text("${commence.hour}:${commence.minute}"),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        ListTile(
                          title: const Text('Onsite'),
                          leading: Radio<EventType>(
                            fillColor: MaterialStateColor.resolveWith(
                              (states) => Theme.of(context).colorScheme.primary,
                            ),
                            value: EventType.onsite,
                            groupValue: _eventType,
                            onChanged: (EventType? value) {
                              setState(() {
                                _eventType = value!;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('Remote'),
                          leading: Radio<EventType>(
                            fillColor: MaterialStateColor.resolveWith(
                              (states) => Theme.of(context).colorScheme.primary,
                            ),
                            value: EventType.remote,
                            groupValue: _eventType,
                            onChanged: (EventType? value) {
                              setState(() {
                                _eventType = value!;
                              });
                            },
                          ),
                        ),
                        (_eventType == EventType.onsite)
                            ? TextFormField(
                                decoration: InputDecoration(
                                  focusColor: Colors.black,
                                  floatingLabelStyle:
                                      const TextStyle(color: Colors.black),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  labelText: 'Venue',
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future pickTime() async {
    TimeOfDay? newCommenceTime = await showTimePicker(
      context: context,
      initialTime: commenceTime,
    );
    if (newCommenceTime != null) {
      setState(() {
        commenceTime = newCommenceTime;
      });
    }
  }

  Future pickDate() async {
    DateTime? newDateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (newDateTime != null && newDateTime.isAfter(DateTime.now())) {
      setState(() {
        dateTime = newDateTime;
      });
    } else {
      showCupertinoDialog(
        context: context,
        builder: ((context) => CupertinoAlertDialog(
              title: const Text("Invalid Date"),
              content: const Text(
                  "Please select a valid date or dates after today,"),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("OK"),
                )
              ],
            )),
      );
    }
  }

  Future pickDateRange() async {
    DateTimeRange? newDateTimeRange = await showDateRangePicker(
      currentDate: DateTime.now(),
      context: context,
      initialDateRange: dateTimeRange,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (newDateTimeRange != null &&
        newDateTimeRange.start.compareTo(DateTime.now()) > 0 &&
        newDateTimeRange.start.compareTo(newDateTimeRange.end) != 0) {
      setState(() {
        dateTimeRange = newDateTimeRange;
      });
    } else {
      showCupertinoDialog(
        context: context,
        builder: ((context) => CupertinoAlertDialog(
              title: const Text("Invalid Date Range"),
              content:
                  const Text("Please select a valid date or dates after today"),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("OK"),
                )
              ],
            )),
      );
    }
  }
}
