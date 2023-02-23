import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base_crud/Models/Task_Model.dart';
import 'package:fire_base_crud/services/remort_services.dart';
// import 'package:fire_base_crud/Models/insert_model.dart';
// import 'package:fire_base_crud/services/remort_services.dart';
import 'package:fire_base_crud/utils/constants.dart';
import 'package:fire_base_crud/utils/widgets_function.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'Posts.dart';

//import 'Posts.dart';

class Insertion extends StatefulWidget {
  const Insertion({super.key});

  @override
  State<Insertion> createState() => _Insertion();
}

class _Insertion extends State<Insertion> {
  final Task = TextEditingController();
  final Description = TextEditingController();
  int _selectedOption = 0;
  final DateInput = TextEditingController();
  final DateInput1 = TextEditingController();
  bool inserted = false;
  //final ID = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedOption = 0;
  }

  getStatus() {
    if (_selectedOption == 1) {
      return 'Active';
    } else {
      return 'InActive';
    }
  }

  process() {
    try {
      insertData();
      return;
    } catch (e) {
      inserted = false;
      return;
    }
  }

  insertData() async {
    if (Task.text != '' && Description.text != '' && _selectedOption != 0) {
      TaskModel dm = TaskModel(
          id: '',
          title: Task.text,
          status: getStatus(),
          description: Description.text,
          isDeleted: '0',
          date: DateInput.text,
          deadline: DateInput1.text);
      await remort_services().Insert(dm);
      inserted = true;
      return;
    }
    inserted = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(99, 89, 133, 1.0),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_left_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Posts()),
            );
          },
        ),
        centerTitle: true,
        title: const Text(
          "Today's Task",
          style: TextStyle(color: Color.fromRGBO(255, 254, 251, 0.992)),
        ),
        backgroundColor: Color.fromRGBO(68, 60, 104, 1.0),
      ),
      body: SingleChildScrollView(
        //physics: const NeverScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: SizedBox(
                              height: 70,
                              width: 200,
                              child: AutoSizeText(
                                'Add Task',
                                style: TEXT_THEME_DEFAULT.headline1,
                                minFontSize: 10,
                                stepGranularity: 5.0,
                              ),
                            ),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextField(
                            controller: DateInput,
                            style: TextStyle(
                                color: Colors
                                    .white), //editing controller of this TextField
                            decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.calendar_month,
                                    color: Color.fromRGBO(68, 60, 104, 1.0)),
                                fillColor: COLOR_GREY,
                                filled: true,
                                hintText: 'Date',
                                hintStyle: TEXT_THEME_SMALL.bodyText2,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            readOnly:
                                true, //set it true, so that user will not able to edit text
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(
                                      2000), //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2101));

                              if (pickedDate != null) {
                                print(
                                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                print(
                                    formattedDate); //formatted date output using intl package =>  2021-03-16
                                //you can implement different kind of Date Format here according to your requirement

                                setState(() {
                                  DateInput.text =
                                      formattedDate; //set output date to TextField value.
                                });
                              } else {
                                print("Date is not selected");
                              }
                            },
                          )
                        ],
                      ),
                      addVerticalSpace(30),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextField(
                            controller: DateInput1,
                            style: TextStyle(
                                color: Colors
                                    .white), //editing controller of this TextField
                            decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.calendar_month,
                                    color: Color.fromRGBO(68, 60, 104, 1.0)),
                                fillColor: COLOR_GREY,
                                filled: true,
                                hintText: 'Deadline',
                                hintStyle: TEXT_THEME_SMALL.bodyText2,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            readOnly:
                                true, //set it true, so that user will not able to edit text
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(
                                      2000), //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2101));

                              if (pickedDate != null) {
                                print(
                                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                print(
                                    formattedDate); //formatted date output using intl package =>  2021-03-16
                                //you can implement different kind of Date Format here according to your requirement

                                setState(() {
                                  DateInput1.text =
                                      formattedDate; //set output date to TextField value.
                                });
                              } else {
                                print("Date is not selected");
                              }
                            },
                          )
                        ],
                      ),
                      addVerticalSpace(30),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextField(
                            controller: Task,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.title,
                                  color: Color.fromRGBO(68, 60, 104, 1.0)),
                              fillColor: COLOR_GREY,
                              filled: true,
                              hintText: 'Task',
                              hintStyle: TEXT_THEME_SMALL.bodyText2,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ],
                      ),
                      addVerticalSpace(30),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextField(
                            controller: Description,
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.description,
                                  color: Color.fromRGBO(68, 60, 104, 1.0)),
                              fillColor: COLOR_GREY,
                              filled: true,
                              hintText: 'Enter the description here...',
                              hintStyle: TEXT_THEME_SMALL.bodyText2,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ],
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: []),
                      addVerticalSpace(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio(
                            value: 1,
                            groupValue: _selectedOption,
                            onChanged: (value) {
                              setState(() {
                                _selectedOption = 1;
                              });
                            },
                          ),
                          Text('Active', style: TextStyle(color: Colors.white)),
                          SizedBox(
                            width: 50,
                          ),
                          Radio(
                            value: 2,
                            groupValue: _selectedOption,
                            onChanged: (value) {
                              setState(() {
                                _selectedOption = 2;
                              });
                            }, // Make the radio button inactive
                          ),
                          Text('Inactive',
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      addVerticalSpace(30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                fixedSize: const Size(120, 50),
                                backgroundColor: Colors.cyan,
                              ),
                              onPressed: () {
                                process();
                                if (inserted == true) {
                                  //ID.text = '';
                                  Task.text = '';
                                  Description.text = '';
                                  _selectedOption = 0;
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text('Successfull!'),
                                      content: const Text(
                                          'Data inserted with no problems :) !'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'OK'),
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text('Error'),
                                      content: const Text(
                                          'Input Missing! Please fill all the input boxes'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Cancel'),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'OK'),
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },
                              icon: Icon(
                                Icons.save,
                                color: Colors.white,
                              ),
                              label: Text(
                                'Save',
                                style: TEXT_THEME_DEFAULT.bodyText1,
                              )),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
