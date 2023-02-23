import 'package:auto_size_text/auto_size_text.dart';
import 'package:fire_base_crud/utils/widgets_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'Posts.dart';

class Details extends StatefulWidget {
  final String id;
  final String title;
  final String description;
  final String status;
  final String date;
  final String deadline;
  const Details({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.date,
    required this.deadline,
  });

  @override
  State<Details> createState() =>
      _Details(id, title, description, status, date, deadline);
}

class _Details extends State<Details> {
  String recieved_ID;
  String recieved_title;
  String recieved_description;
  String recieved_status;
  String recieved_date;
  String recieved_deadline;

  _Details(this.recieved_ID, this.recieved_title, this.recieved_description,
      this.recieved_status, this.recieved_date, this.recieved_deadline);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(99, 89, 133, 1.0),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_left_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Posts()),
            );
            //print('card tapped');
          },
        ),
        centerTitle: true,
        title: const Text(
          "Today's Task",
          style: TextStyle(color: Color.fromRGBO(255, 254, 251, 0.992)),
        ),
        backgroundColor: Color.fromRGBO(68, 60, 104, 1.0),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: SizedBox(
                  height: 70,
                  width: 200,
                  child: AutoSizeText(
                    'Details',
                    style: TEXT_THEME_DEFAULT.headline1,
                    minFontSize: 10,
                    stepGranularity: 5.0,
                  ),
                ),
              )
            ],
          ),
          addVerticalSpace(20),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      height: 500,
                      width: 350,
                      child: RichText(
                        text: TextSpan(
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Color.fromRGBO(255, 251, 235, 3.0),
                            ),
                            children: <TextSpan>[
                              const TextSpan(
                                  text: 'Date : ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(248, 203, 166, 1.0))),
                              TextSpan(text: recieved_date),
                              const TextSpan(
                                  text: '\nDeadline : ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(248, 203, 166, 1.0))),
                              TextSpan(text: recieved_deadline),
                              const TextSpan(
                                  text: '\n\nTask : ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(248, 203, 166, 1.0))),
                              TextSpan(text: recieved_title),
                               const TextSpan(
                                  text: '\n\nDescription : ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(248, 203, 166, 1.0))),
                              TextSpan(text:recieved_description),
                               const TextSpan(
                                  text: '\n\nStatus : ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(248, 203, 166, 1.0))),
                              TextSpan(text: recieved_status),
                            ]),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
