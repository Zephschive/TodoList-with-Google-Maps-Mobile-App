

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_todolist_googlemaps/db/db_helper.dart';
import 'package:flutter_todolist_googlemaps/screens/calendar_page.dart';
import 'package:flutter_todolist_googlemaps/theme/colors/light_colors.dart';
import 'package:flutter_todolist_googlemaps/widgets/top_container.dart';
import 'package:flutter_todolist_googlemaps/widgets/back_button.dart';
import 'package:flutter_todolist_googlemaps/widgets/my_text_field.dart';
import 'package:flutter_todolist_googlemaps/screens/home_page.dart';

class CreateNewTaskPage extends StatelessWidget {
  Dbhelper db = Dbhelper();
    TextEditingController Taskcontroller = TextEditingController();
    TextEditingController DateController = TextEditingController();
    TextEditingController DescController = TextEditingController();
    TextEditingController nully = TextEditingController();

  @override
  Widget build(BuildContext context) {

    List<String> task =['washing','drying','pasting'];
    Map<String, dynamic> maps = ({
      'Marker1':'Marker2',
      'Marker3':'Marker4'

    });
    double width = MediaQuery.of(context).size.width;
    var downwardIcon = Icon(
      Icons.keyboard_arrow_down,
      color: Colors.black54,
    );
   void addtask () async{
    Timer(Duration(seconds: 10), () {  Center(child: CircularProgressIndicator(),);});
 await db.DB.collection('task').add({
    'task': maps['Marker1'],
    'desc': DescController.text,
    'date': DateController.text,});

   Navigator.push(context, MaterialPageRoute(builder: (context) { return CalendarPage();}));
   }
  
    
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 40),
              width: width,
              child: Column(
                children: <Widget>[
                  MyBackButton(),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Create new task',
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      MyTextField(label: 'Title',
                      icon: Icon(Icons.title)
                      ,controller: Taskcontroller,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Expanded(
                            child: MyTextField(
                              controller: DateController,
                              label: 'Date',
                              icon: downwardIcon,
                            ),
                          ),
                          HomePage.calendarIcon(),
                        ],
                      )
                    ],
                  ))
                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                          child: MyTextField(
                            controller: nully,
                        label: 'Start Time',
                        icon: downwardIcon,
                      )),
                      SizedBox(width: 40),
                      Expanded(
                        child: MyTextField(
                          controller: nully,
                          label: 'End Time',
                          icon: downwardIcon,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  MyTextField(
                    controller: DescController,
                    label: 'Description',
                    minLines: 3,
                    maxLines: 3, 
                    icon: Icon(Icons.description),
                  ),
                  SizedBox(height: 20),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Category',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                          ),
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          //direction: Axis.vertical,
                          alignment: WrapAlignment.start,
                          verticalDirection: VerticalDirection.down,
                          runSpacing: 0,
                          //textDirection: TextDirection.rtl,
                          spacing: 10.0,
                          children: <Widget>[
                            Chip(
                              label: Text("SPORT APP"),
                              backgroundColor: LightColors.kRed,
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                            Chip(
                              label: Text("MEDICAL APP"),
                            ),
                            Chip(
                              label: Text("RENT APP"),
                            ),
                            Chip(
                              label: Text("NOTES"),
                            ),
                            Chip(
                              label: Text("GAMING PLATFORM APP"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
            GestureDetector(
              onTap: addtask,
              child: Container(
                height: 80,
                width: width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      child: Text(
                        'Create Task',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                      alignment: Alignment.center,
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                      width: width - 40,
                      decoration: BoxDecoration(
                        color: LightColors.kBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
