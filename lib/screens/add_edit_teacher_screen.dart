import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/school.dart';
import '../providers/school_provider.dart';

class AddEditTeacherScreen extends StatefulWidget {
  final Teacher? teacher;
  final String schoolId;

  AddEditTeacherScreen({this.teacher, required this.schoolId});

  @override
  _AddEditTeacherScreenState createState() => _AddEditTeacherScreenState();
}

class _AddEditTeacherScreenState extends State<AddEditTeacherScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _email;
  late String _subject;

  @override
  void initState() {
    super.initState();
    _name = widget.teacher?.name ?? '';
    _email = widget.teacher?.email ?? '';
    _subject = widget.teacher?.subject ?? '';
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final schoolProvider = Provider.of<SchoolProvider>(context, listen: false);
      final schoolRef = FirebaseFirestore.instance.collection('schools').doc(widget.schoolId);

      if (widget.teacher == null) {
        schoolProvider.addTeacher(Teacher(
          id: '',
          name: _name,
          email: _email,
          subject: _subject,
          schoolId: schoolRef,
        ));
      } else {
        schoolProvider.updateTeacher(Teacher(
          id: widget.teacher!.id,
          name: _name,
          email: _email,
          subject: _subject,
          schoolId: schoolRef,
        ));
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.teacher == null ? 'Thêm giáo viên' : 'Sửa giáo viên')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Tên giáo viên'),
                validator: (value) => value!.isEmpty ? 'Vui lòng nhập tên' : null,
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                initialValue: _email,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) => value!.isEmpty ? 'Vui lòng nhập email' : null,
                onSaved: (value) => _email = value!,
              ),
              TextFormField(
                initialValue: _subject,
                decoration: InputDecoration(labelText: 'Môn giảng dạy'),
                validator: (value) => value!.isEmpty ? 'Vui lòng nhập môn' : null,
                onSaved: (value) => _subject = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _submit, child: Text('Lưu')),
            ],
          ),
        ),
      ),
    );
  }
}