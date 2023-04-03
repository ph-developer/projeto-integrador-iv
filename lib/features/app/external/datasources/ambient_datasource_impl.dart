import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/ambient.dart';
import '../../domain/errors/failures.dart';
import '../../infra/datasources/ambient_datasource.dart';
import '../dtos/ambient_dto.dart';

class AmbientDatasourceImpl extends IAmbientDatasource {
  final FirebaseFirestore _firebaseFirestore;

  AmbientDatasourceImpl(
    this._firebaseFirestore,
  );

  @override
  Future<Ambient> getAmbientById(String ambientId) async {
    final colRef = _firebaseFirestore.collection('ambients');
    final docRef = colRef.doc(ambientId);
    final docSnapshot = await docRef.get();

    if (!docSnapshot.exists) {
      throw const AmbientNotFound();
    }

    final ambientMap = {
      ...docSnapshot.data()!,
      'id': ambientId,
    };
    final ambient = AmbientDTO.fromMap(ambientMap);

    return ambient;
  }

  @override
  Future<List<Ambient>> getAmbients(List<String> ids) async {
    final colRef = _firebaseFirestore.collection('ambients');
    final query = colRef.where(FieldPath.documentId, whereIn: ids);
    final docsSnapshot = await query.get();
    final docsMap = docsSnapshot.docs;
    final ambients = docsMap
        .map((snapshot) {
          final map = snapshot.data();
          map['id'] = snapshot.id;
          return map;
        })
        .map(AmbientDTO.fromMap)
        .toList();

    return ambients;
  }
}
