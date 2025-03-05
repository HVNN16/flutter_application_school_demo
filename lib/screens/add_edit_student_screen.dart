// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../models/school.dart';
// import '../providers/school_provider.dart';

// class AddEditStudentScreen extends StatefulWidget {
//   final Student? student;
//   final String schoolId;

//   AddEditStudentScreen({this.student, required this.schoolId});

//   @override
//   _AddEditStudentScreenState createState() => _AddEditStudentScreenState();
// }

// class _AddEditStudentScreenState extends State<AddEditStudentScreen> {
//   final _formKey = GlobalKey<FormState>();
//   late String _name;
//   late int _age;
//   late String _className;

//   @override
//   void initState() {
//     super.initState();
//     _name = widget.student?.name ?? '';
//     _age = widget.student?.age ?? 0;
//     _className = widget.student?.className ?? '';
//   }

//   void _submit() async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       final schoolProvider = Provider.of<SchoolProvider>(context, listen: false);
//       final schoolRef = FirebaseFirestore.instance.collection('schools').doc(widget.schoolId);

//       try {
//         if (widget.student == null) {
//           await schoolProvider.addStudent(Student(
//             id: '',
//             name: _name,
//             age: _age,
//             className: _className,
//             schoolId: schoolRef,
//           ));
//         } else {
//           await schoolProvider.updateStudent(Student(
//             id: widget.student!.id,
//             name: _name,
//             age: _age,
//             className: _className,
//             schoolId: schoolRef,
//           ));
//         }
//         Navigator.pop(context);
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.student == null ? 'Thêm học sinh' : 'Sửa học sinh')),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 initialValue: _name,
//                 decoration: InputDecoration(labelText: 'Tên học sinh'),
//                 validator: (value) => value!.isEmpty ? 'Vui lòng nhập tên' : null,
//                 onSaved: (value) => _name = value!,
//               ),
//               TextFormField(
//                 initialValue: _age.toString(),
//                 decoration: InputDecoration(labelText: 'Tuổi'),
//                 keyboardType: TextInputType.number,
//                 validator: (value) => value!.isEmpty ? 'Vui lòng nhập tuổi' : null,
//                 onSaved: (value) => _age = int.parse(value!),
//               ),
//               TextFormField(
//                 initialValue: _className,
//                 decoration: InputDecoration(labelText: 'Lớp'),
//                 validator: (value) => value!.isEmpty ? 'Vui lòng nhập lớp' : null,
//                 onSaved: (value) => _className = value!,
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(onPressed: _submit, child: Text('Lưu')),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

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
  String? _className; // Đổi thành nullable để Dropdown xử lý giá trị ban đầu

  @override
  void initState() {
    super.initState();
    _name = widget.student?.name ?? '';
    _age = widget.student?.age ?? 0;
    _className = widget.student?.className; // Lấy giá trị lớp ban đầu (nếu có)
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
            className: _className ?? '', // Nếu không chọn lớp, để trống
            schoolId: schoolRef,
          ));
        } else {
          await schoolProvider.updateStudent(Student(
            id: widget.student!.id,
            name: _name,
            age: _age,
            className: _className ?? widget.student!.className, // Giữ lớp cũ nếu không thay đổi
            schoolId: schoolRef,
          ));
        }
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(widget.student == null ? 'Đã thêm học sinh' : 'Đã cập nhật học sinh')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Lỗi: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final schoolProvider = Provider.of<SchoolProvider>(context);

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
              StreamBuilder<List<Classroom>>(
                stream: schoolProvider.getClassrooms(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('Chưa có lớp học nào');
                  }

                  final classrooms = snapshot.data!;
                  return DropdownButtonFormField<String>(
                    value: _className, // Giá trị ban đầu
                    decoration: InputDecoration(labelText: 'Lớp'),
                    items: classrooms.map((classroom) {
                      return DropdownMenuItem<String>(
                        value: classroom.className, // Giá trị là tên lớp
                        child: Text('${classroom.classCode} - ${classroom.className}'),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _className = value; // Cập nhật giá trị khi chọn
                      });
                    },
                    validator: (value) => value == null ? 'Vui lòng chọn lớp' : null,
                    onSaved: (value) => _className = value,
                  );
                },
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