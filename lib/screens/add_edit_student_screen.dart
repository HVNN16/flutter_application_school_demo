import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/school.dart';
import '../providers/school_provider.dart';

class AddEditStudentScreen extends StatefulWidget {
  final Student? student;
  final String schoolId;

  AddEditStudentScreen({this.student, required this.schoolId});

  @override
  _AddEditStudentScreenState createState() => _AddEditStudentScreenState();
}

class _AddEditStudentScreenState extends State<AddEditStudentScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late int _age;
  late String _className;

  @override
  void initState() {
    super.initState();
    _name = widget.student?.name ?? '';
    _age = widget.student?.age ?? 0;
    _className = widget.student?.className ?? '';
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final schoolProvider = Provider.of<SchoolProvider>(context, listen: false);
      final schoolRef = FirebaseFirestore.instance.collection('schools').doc(widget.schoolId);

      try {
        if (widget.student == null) {
          await schoolProvider.addStudent(Student(
            id: '',
            name: _name,
            age: _age,
            className: _className,
            schoolId: schoolRef,
          ));
        } else {
          await schoolProvider.updateStudent(Student(
            id: widget.student!.id,
            name: _name,
            age: _age,
            className: _className,
            schoolId: schoolRef,
          ));
        }
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.student == null ? 'Thêm học sinh' : 'Sửa học sinh')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Tên học sinh'),
                validator: (value) => value!.isEmpty ? 'Vui lòng nhập tên' : null,
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                initialValue: _age.toString(),
                decoration: InputDecoration(labelText: 'Tuổi'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Vui lòng nhập tuổi' : null,
                onSaved: (value) => _age = int.parse(value!),
              ),
              TextFormField(
                initialValue: _className,
                decoration: InputDecoration(labelText: 'Lớp'),
                validator: (value) => value!.isEmpty ? 'Vui lòng nhập lớp' : null,
                onSaved: (value) => _className = value!,
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