// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import '../models/school.dart';

// class SchoolProvider with ChangeNotifier {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   // Kiểm tra trạng thái đăng nhập
//   bool get isLoggedIn => _auth.currentUser != null;

//   // CRUD cho School
//   Future<void> addSchool(School school) async {
//     await _firestore.collection('schools').add(school.toFirestore());
//     notifyListeners();
//   }

//   Stream<List<School>> getSchools() {
//     return _firestore.collection('schools').snapshots().map((snapshot) {
//       return snapshot.docs.map((doc) => School.fromFirestore(doc.data(), doc.id)).toList();
//     });
//   }

//   Future<void> updateSchool(School school) async {
//     await _firestore.collection('schools').doc(school.id).update(school.toFirestore());
//     notifyListeners();
//   }

//   Future<void> deleteSchool(String schoolId) async {
//     await _firestore.collection('schools').doc(schoolId).delete();
//     notifyListeners();
//   }

//   // CRUD cho Teacher
//   Future<void> addTeacher(Teacher teacher) async {
//     await _firestore
//         .collection('schools')
//         .doc(teacher.schoolId.id)
//         .collection('teachers')
//         .add(teacher.toFirestore());
//     notifyListeners();
//   }

//   Stream<List<Teacher>> getTeachers(String schoolId) {
//     return _firestore
//         .collection('schools')
//         .doc(schoolId)
//         .collection('teachers')
//         .snapshots()
//         .map((snapshot) {
//       return snapshot.docs.map((doc) => Teacher.fromFirestore(doc.data(), doc.id)).toList();
//     });
//   }

//   Future<void> updateTeacher(Teacher teacher) async {
//     await _firestore
//         .collection('schools')
//         .doc(teacher.schoolId.id)
//         .collection('teachers')
//         .doc(teacher.id)
//         .update(teacher.toFirestore());
//     notifyListeners();
//   }

//   Future<void> deleteTeacher(String schoolId, String teacherId) async {
//     await _firestore
//         .collection('schools')
//         .doc(schoolId)
//         .collection('teachers')
//         .doc(teacherId)
//         .delete();
//     notifyListeners();
//   }

//   // CRUD cho Student (Chỉ giáo viên đăng nhập mới được quản lý)
//   Future<void> addStudent(Student student) async {
//     if (_auth.currentUser != null) {
//       await _firestore
//           .collection('schools')
//           .doc(student.schoolId.id)
//           .collection('students')
//           .add(student.toFirestore());
//       notifyListeners();
//     } else {
//       throw Exception('Bạn cần đăng nhập để thực hiện thao tác này');
//     }
//   }

//   Stream<List<Student>> getStudents(String schoolId) {
//     return _firestore
//         .collection('schools')
//         .doc(schoolId)
//         .collection('students')
//         .snapshots()
//         .map((snapshot) {
//       return snapshot.docs.map((doc) => Student.fromFirestore(doc.data(), doc.id)).toList();
//     });
//   }

//   Future<void> updateStudent(Student student) async {
//     if (_auth.currentUser != null) {
//       await _firestore
//           .collection('schools')
//           .doc(student.schoolId.id)
//           .collection('students')
//           .doc(student.id)
//           .update(student.toFirestore());
//       notifyListeners();
//     } else {
//       throw Exception('Bạn cần đăng nhập để thực hiện thao tác này');
//     }
//   }

//   Future<void> deleteStudent(String schoolId, String studentId) async {
//     if (_auth.currentUser != null) {
//       await _firestore
//           .collection('schools')
//           .doc(schoolId)
//           .collection('students')
//           .doc(studentId)
//           .delete();
//       notifyListeners();
//     } else {
//       throw Exception('Bạn cần đăng nhập để thực hiện thao tác này');
//     }
//   }

//   // Đăng xuất
//   Future<void> signOut() async {
//     await _auth.signOut();
//     notifyListeners();
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/school.dart';

class SchoolProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool get isLoggedIn => _auth.currentUser != null;

  // CRUD cho School
  Future<void> addSchool(School school) async {
    try {
      await _firestore.collection('schools').add(school.toFirestore());
      notifyListeners();
    } catch (e) {
      print('Error adding school: $e');
      rethrow;
    }
  }

  Stream<List<School>> getSchools() {
    return _firestore.collection('schools').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => School.fromFirestore(doc.data(), doc.id)).toList();
    });
  }

  Future<void> updateSchool(School school) async {
    try {
      await _firestore.collection('schools').doc(school.id).update(school.toFirestore());
      notifyListeners();
    } catch (e) {
      print('Error updating school: $e');
      rethrow;
    }
  }

  Future<void> deleteSchool(String schoolId) async {
    try {
      await _firestore.collection('schools').doc(schoolId).delete();
      notifyListeners();
    } catch (e) {
      print('Error deleting school: $e');
      rethrow;
    }
  }

  // CRUD cho Teacher
  Future<void> addTeacher(Teacher teacher) async {
    try {
      await _firestore
          .collection('schools')
          .doc(teacher.schoolId.id)
          .collection('teachers')
          .add(teacher.toFirestore());
      notifyListeners();
    } catch (e) {
      print('Error adding teacher: $e');
      rethrow;
    }
  }

  Stream<List<Teacher>> getTeachers(String schoolId) {
    return _firestore
        .collection('schools')
        .doc(schoolId)
        .collection('teachers')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Teacher.fromFirestore(doc.data(), doc.id)).toList();
    });
  }

  Future<void> updateTeacher(Teacher teacher) async {
    try {
      await _firestore
          .collection('schools')
          .doc(teacher.schoolId.id)
          .collection('teachers')
          .doc(teacher.id)
          .update(teacher.toFirestore());
      notifyListeners();
    } catch (e) {
      print('Error updating teacher: $e');
      rethrow;
    }
  }

  Future<void> deleteTeacher(String schoolId, String teacherId) async {
    try {
      await _firestore
          .collection('schools')
          .doc(schoolId)
          .collection('teachers')
          .doc(teacherId)
          .delete();
      notifyListeners();
    } catch (e) {
      print('Error deleting teacher: $e');
      rethrow;
    }
  }

  // CRUD cho Student
  Future<void> addStudent(Student student) async {
    if (_auth.currentUser != null) {
      try {
        await _firestore
            .collection('schools')
            .doc(student.schoolId.id)
            .collection('students')
            .add(student.toFirestore());
        notifyListeners();
      } catch (e) {
        print('Error adding student: $e');
        rethrow;
      }
    } else {
      throw Exception('Bạn cần đăng nhập để thực hiện thao tác này');
    }
  }

  Stream<List<Student>> getStudents(String schoolId) {
    return _firestore
        .collection('schools')
        .doc(schoolId)
        .collection('students')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Student.fromFirestore(doc.data(), doc.id)).toList();
    });
  }

  Future<void> updateStudent(Student student) async {
    if (_auth.currentUser != null) {
      try {
        await _firestore
            .collection('schools')
            .doc(student.schoolId.id)
            .collection('students')
            .doc(student.id)
            .update(student.toFirestore());
        notifyListeners();
      } catch (e) {
        print('Error updating student: $e');
        rethrow;
      }
    } else {
      throw Exception('Bạn cần đăng nhập để thực hiện thao tác này');
    }
  }

  Future<void> deleteStudent(String schoolId, String studentId) async {
    if (_auth.currentUser != null) {
      try {
        await _firestore
            .collection('schools')
            .doc(schoolId)
            .collection('students')
            .doc(studentId)
            .delete();
        notifyListeners();
      } catch (e) {
        print('Error deleting student: $e');
        rethrow;
      }
    } else {
      throw Exception('Bạn cần đăng nhập để thực hiện thao tác này');
    }
  }

  // CRUD cho Classroom
  Future<void> addClassroom(Classroom classroom) async {
    if (_auth.currentUser != null) { // Kiểm tra đăng nhập
      try {
        await _firestore.collection('classrooms').add(classroom.toFirestore());
        notifyListeners();
      } catch (e) {
        print('Error adding classroom: $e');
        rethrow;
      }
    } else {
      throw Exception('Bạn cần đăng nhập để thêm lớp học');
    }
  }

  Stream<List<Classroom>> getClassrooms() {
    return _firestore.collection('classrooms').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Classroom.fromFirestore(doc.data(), doc.id)).toList();
    });
  }

  Future<void> updateClassroom(Classroom classroom) async {
    if (_auth.currentUser != null) { // Kiểm tra đăng nhập
      try {
        await _firestore.collection('classrooms').doc(classroom.id).update(classroom.toFirestore());
        notifyListeners();
      } catch (e) {
        print('Error updating classroom: $e');
        rethrow;
      }
    } else {
      throw Exception('Bạn cần đăng nhập để cập nhật lớp học');
    }
  }

  Future<void> deleteClassroom(String classroomId) async {
    if (_auth.currentUser != null) { // Kiểm tra đăng nhập
      try {
        await _firestore.collection('classrooms').doc(classroomId).delete();
        notifyListeners();
      } catch (e) {
        print('Error deleting classroom: $e');
        rethrow;
      }
    } else {
      throw Exception('Bạn cần đăng nhập để xóa lớp học');
    }
  }

  // Đăng xuất
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      notifyListeners();
    } catch (e) {
      print('Error signing out: $e');
      rethrow;
    }
  }
}