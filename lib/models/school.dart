// import 'package:cloud_firestore/cloud_firestore.dart';

// class School {
//   final String id;
//   final String name;
//   final String address;
//   final String phone;

//   School({
//     required this.id,
//     required this.name,
//     required this.address,
//     required this.phone,
//   });

//   factory School.fromFirestore(Map<String, dynamic> data, String id) {
//     return School(
//       id: id,
//       name: data['name'] ?? '',
//       address: data['address'] ?? '',
//       phone: data['phone'] ?? '',
//     );
//   }

//   Map<String, dynamic> toFirestore() {
//     return {
//       'name': name,
//       'address': address,
//       'phone': phone,
//     };
//   }
// }

// class Teacher {
//   final String id;
//   final String name;
//   final String email;
//   final String subject;
//   final DocumentReference schoolId;

//   Teacher({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.subject,
//     required this.schoolId,
//   });

//   factory Teacher.fromFirestore(Map<String, dynamic> data, String id) {
//     return Teacher(
//       id: id,
//       name: data['name'] ?? '',
//       email: data['email'] ?? '',
//       subject: data['subject'] ?? '',
//       schoolId: data['schoolId'] as DocumentReference,
//     );
//   }

//   Map<String, dynamic> toFirestore() {
//     return {
//       'name': name,
//       'email': email,
//       'subject': subject,
//       'schoolId': schoolId,
//     };
//   }
// }

// class Student {
//   final String id;
//   final String name;
//   final int age;
//   final String className;
//   final DocumentReference schoolId;

//   Student({
//     required this.id,
//     required this.name,
//     required this.age,
//     required this.className,
//     required this.schoolId,
//   });

//   factory Student.fromFirestore(Map<String, dynamic> data, String id) {
//     return Student(
//       id: id,
//       name: data['name'] ?? '',
//       age: data['age'] ?? 0,
//       className: data['class'] ?? '',
//       schoolId: data['schoolId'] as DocumentReference,
//     );
//   }

//   Map<String, dynamic> toFirestore() {
//     return {
//       'name': name,
//       'age': age,
//       'class': className,
//       'schoolId': schoolId,
//     };
//   }
  
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class School {
  final String id;
  final String name;
  final String address;
  final String phone;

  School({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
  });

  factory School.fromFirestore(Map<String, dynamic> data, String id) {
    return School(
      id: id,
      name: data['name'] ?? '',
      address: data['address'] ?? '',
      phone: data['phone'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'address': address,
      'phone': phone,
    };
  }
}

class Teacher {
  final String id;
  final String name;
  final String email;
  final String subject;
  final DocumentReference schoolId;

  Teacher({
    required this.id,
    required this.name,
    required this.email,
    required this.subject,
    required this.schoolId,
  });

  factory Teacher.fromFirestore(Map<String, dynamic> data, String id) {
    return Teacher(
      id: id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      subject: data['subject'] ?? '',
      schoolId: data['schoolId'] as DocumentReference,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'email': email,
      'subject': subject,
      'schoolId': schoolId,
    };
  }
}

class Student {
  final String id;
  final String name;
  final int age;
  final String className;
  final DocumentReference schoolId;

  Student({
    required this.id,
    required this.name,
    required this.age,
    required this.className,
    required this.schoolId,
  });

  factory Student.fromFirestore(Map<String, dynamic> data, String id) {
    return Student(
      id: id,
      name: data['name'] ?? '',
      age: data['age'] ?? 0,
      className: data['class'] ?? '',
      schoolId: data['schoolId'] as DocumentReference,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'age': age,
      'class': className,
      'schoolId': schoolId,
    };
  }
}

class Classroom {
  final String id;
  final String classCode;
  final String className;
  final int studentCount;

  Classroom({
    required this.id,
    required this.classCode,
    required this.className,
    required this.studentCount,
  });

  factory Classroom.fromFirestore(Map<String, dynamic> data, String id) {
    return Classroom(
      id: id,
      classCode: data['classCode'] ?? '',
      className: data['className'] ?? '',
      studentCount: data['studentCount'] ?? 0,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'classCode': classCode,
      'className': className,
      'studentCount': studentCount,
    };
  }
}