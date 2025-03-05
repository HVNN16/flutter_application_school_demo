import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/school.dart';
import '../providers/school_provider.dart';

class AddEditSchoolScreen extends StatefulWidget {
  final School? school;

  AddEditSchoolScreen({this.school});

  @override
  _AddEditSchoolScreenState createState() => _AddEditSchoolScreenState();
}

class _AddEditSchoolScreenState extends State<AddEditSchoolScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _address;
  late String _phone;

  @override
  void initState() {
    super.initState();
    _name = widget.school?.name ?? '';
    _address = widget.school?.address ?? '';
    _phone = widget.school?.phone ?? '';
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final schoolProvider = Provider.of<SchoolProvider>(context, listen: false);
      if (widget.school == null) {
        schoolProvider.addSchool(School(id: '', name: _name, address: _address, phone: _phone));
      } else {
        schoolProvider.updateSchool(School(id: widget.school!.id, name: _name, address: _address, phone: _phone));
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.school == null ? 'Thêm trường' : 'Sửa trường')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Tên trường'),
                validator: (value) => value!.isEmpty ? 'Vui lòng nhập tên trường' : null,
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                initialValue: _address,
                decoration: InputDecoration(labelText: 'Địa chỉ'),
                validator: (value) => value!.isEmpty ? 'Vui lòng nhập địa chỉ' : null,
                onSaved: (value) => _address = value!,
              ),
              TextFormField(
                initialValue: _phone,
                decoration: InputDecoration(labelText: 'Số điện thoại'),
                validator: (value) => value!.isEmpty ? 'Vui lòng nhập số điện thoại' : null,
                onSaved: (value) => _phone = value!,
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