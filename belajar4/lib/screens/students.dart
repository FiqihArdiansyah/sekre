import 'dart:async';

import 'package:belajar4/controllers/student_controller.dart';
import 'package:belajar4/models/add_or_edit_student.dart';
import 'package:belajar4/models/student_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({super.key});

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
// i will declare some variables here

// you can you future builder but for better management you have you stream builder
// also it is good for view data while is changed;
  List<studentModel> studentlist = [];

  StreamController _streamController = StreamController();

  Future getAllstudents() async {
    studentlist = await StudentContoller().getStudents();
    // also stream contoller is equal to students list
    _streamController.sink.add(studentlist);
  }

  //DeleteStudent
  deleteStudent(studentModel studentModel) async {
    await StudentContoller()
        .DeleteStudent(studentModel)
        .then((Success) => {
              FlutterToastr.show("Student delete succes fully", context,
                  duration: FlutterToastr.lengthLong,
                  position: FlutterToastr.center,
                  backgroundColor: Colors.green),
            })
        .onError((error, stackTrace) => {
              FlutterToastr.show("Student is not delete", context,
                  duration: FlutterToastr.lengthLong,
                  position: FlutterToastr.center,
                  backgroundColor: Colors.red),
            });
  }

//to track data i will use iniation
  @override
  void initState() {
    // TODO: implement initState
    Timer.periodic(Duration(seconds: 1), (timer) {
      getAllstudents();
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: ((context) => Add_Edit_Student())));
          },
          child: Icon(Icons.add)),
      appBar: AppBar(title: Text('students page')),
      body: SafeArea(
        child: StreamBuilder(
          stream: _streamController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: studentlist.length,
                  itemBuilder: ((context, index) {
                    studentModel student = studentlist[index];
                    return ListTile(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => Add_Edit_Student(
                                      studentmodel: student,
                                      index: index,
                                    ))));
                      },
                      leading: CircleAvatar(child: Text(student.Name[0])),
                      title: Text(student.Name),
                      subtitle: Text(student.Email),
                      trailing: IconButton(
                        onPressed: () {
                          deleteStudent(student);
                        },
                        icon: Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        ),
                      ),
                    );
                  }));
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
