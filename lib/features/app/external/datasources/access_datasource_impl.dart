import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/access.dart';
import '../../domain/errors/failures.dart';
import '../../infra/datasources/access_datasource.dart';
import '../dtos/access_dto.dart';

class AccessDatasourceImpl extends IAccessDatasource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  AccessDatasourceImpl(
    this._firebaseAuth,
    this._firebaseFirestore,
  );

  @override
  Future<Access?> getLoggedUserAccess() async {
    final loggedUserId = _getLoggedUserId();
    final colRef = _firebaseFirestore.collection('access');
    final docRef = colRef.doc(loggedUserId);
    final docSnapshot = await docRef.get();

    if (!docSnapshot.exists) {
      return null;
    }

    final accessMap = docSnapshot.data()!;
    final access = AccessDTO.fromMap(accessMap);

    return access;
  }

  @override
  Future<void> addAccess(String ambientId) async {
    final loggedUserId = _getLoggedUserId();
    final colRef = _firebaseFirestore.collection('access');
    final docRef = colRef.doc(loggedUserId);
    final docSnapshot = await docRef.get();

    var ambients = [];

    if (docSnapshot.exists) {
      final accessMap = docSnapshot.data()!;
      final access = AccessDTO.fromMap(accessMap);
      ambients = access.ambients;
    }

    if (!ambients.contains(ambientId)) {
      ambients.add(ambientId);
    }

    await docRef.update({'ambients': ambients});
  }

  @override
  Future<void> removeAccess(String ambientId) async {
    final loggedUserId = _getLoggedUserId();
    final colRef = _firebaseFirestore.collection('access');
    final docRef = colRef.doc(loggedUserId);
    final docSnapshot = await docRef.get();

    if (!docSnapshot.exists) return;

    final accessMap = docSnapshot.data()!;
    final access = AccessDTO.fromMap(accessMap);
    final ambients = access.ambients.where((id) => id != ambientId).toList();

    await docRef.update({'ambients': ambients});
  }

  String _getLoggedUserId() {
    final loggedUserId = _firebaseAuth.currentUser?.uid;

    if (loggedUserId == null) {
      throw const UserUnauthenticated();
    }

    return loggedUserId;
  }
}
