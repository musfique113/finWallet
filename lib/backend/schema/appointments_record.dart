// import 'dart:async';

// import '/backend/schema/util/firestore_util.dart';
// import '/backend/schema/util/schema_util.dart';

// import 'index.dart';

// class AppointmentsRecord extends FirestoreRecord {
//   AppointmentsRecord._(
//     DocumentReference reference,
//     Map<String, dynamic> data,
//   ) : super(reference, data) {
//     _initializeFields();
//   }

//   // "appointmentName" field.
//   String? _appointmentName;
//   String get appointmentName => _appointmentName ?? '';
//   bool hasAppointmentName() => _appointmentName != null;

//   // "appointmentDescription" field.
//   String? _appointmentDescription;
//   String get appointmentDescription => _appointmentDescription ?? '';
//   bool hasAppointmentDescription() => _appointmentDescription != null;

//   // "appointmentPerson" field.
//   DocumentReference? _appointmentPerson;
//   DocumentReference? get appointmentPerson => _appointmentPerson;
//   bool hasAppointmentPerson() => _appointmentPerson != null;

//   // "appointmentTime" field.
//   DateTime? _appointmentTime;
//   DateTime? get appointmentTime => _appointmentTime;
//   bool hasAppointmentTime() => _appointmentTime != null;

//   // "appointmentType" field.
//   String? _appointmentType;
//   String get appointmentType => _appointmentType ?? '';
//   bool hasAppointmentType() => _appointmentType != null;

//   // "appointmentEmail" field.
//   String? _appointmentEmail;
//   String get appointmentEmail => _appointmentEmail ?? '';
//   bool hasAppointmentEmail() => _appointmentEmail != null;

//   void _initializeFields() {
//     _appointmentName = snapshotData['appointmentName'] as String?;
//     _appointmentDescription = snapshotData['appointmentDescription'] as String?;
//     _appointmentPerson =
//         snapshotData['appointmentPerson'] as DocumentReference?;
//     _appointmentTime = snapshotData['appointmentTime'] as DateTime?;
//     _appointmentType = snapshotData['appointmentType'] as String?;
//     _appointmentEmail = snapshotData['appointmentEmail'] as String?;
//   }

//   static CollectionReference get collection =>
//       FirebaseFirestore.instance.collection('appointments');

//   static Stream<AppointmentsRecord> getDocument(DocumentReference ref) =>
//       ref.snapshots().map((s) => AppointmentsRecord.fromSnapshot(s));

//   static Future<AppointmentsRecord> getDocumentOnce(DocumentReference ref) =>
//       ref.get().then((s) => AppointmentsRecord.fromSnapshot(s));

//   static AppointmentsRecord fromSnapshot(DocumentSnapshot snapshot) =>
//       AppointmentsRecord._(
//         snapshot.reference,
//         mapFromFirestore(snapshot.data() as Map<String, dynamic>),
//       );

//   static AppointmentsRecord getDocumentFromData(
//     Map<String, dynamic> data,
//     DocumentReference reference,
//   ) =>
//       AppointmentsRecord._(reference, mapFromFirestore(data));

//   @override
//   String toString() =>
//       'AppointmentsRecord(reference: ${reference.path}, data: $snapshotData)';

//   @override
//   int get hashCode => reference.path.hashCode;

//   @override
//   bool operator ==(other) =>
//       other is AppointmentsRecord &&
//       reference.path.hashCode == other.reference.path.hashCode;
// }

// Map<String, dynamic> createAppointmentsRecordData({
//   String? appointmentName,
//   String? appointmentDescription,
//   DocumentReference? appointmentPerson,
//   DateTime? appointmentTime,
//   String? appointmentType,
//   String? appointmentEmail,
// }) {
//   final firestoreData = mapToFirestore(
//     <String, dynamic>{
//       'appointmentName': appointmentName,
//       'appointmentDescription': appointmentDescription,
//       'appointmentPerson': appointmentPerson,
//       'appointmentTime': appointmentTime,
//       'appointmentType': appointmentType,
//       'appointmentEmail': appointmentEmail,
//     }.withoutNulls,
//   );

//   return firestoreData;
// }
