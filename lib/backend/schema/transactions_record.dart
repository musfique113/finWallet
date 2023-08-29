import 'dart:async';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';

class TransactionsRecord extends FirestoreRecord {
  TransactionsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "transactionName" field.
  String? _transactionName;
  String get transactionName => _transactionName ?? '';
  bool hasTransactionName() => _transactionName != null;

  // "transactionAmount" field.
  String? _transactionAmount;
  String get transactionAmount => _transactionAmount ?? '';
  bool hasTransactionAmount() => _transactionAmount != null;

  // "transactionTime" field.
  DateTime? _transactionTime;
  DateTime? get transactionTime => _transactionTime;
  bool hasTransactionTime() => _transactionTime != null;

  // "transactionPlace" field.
  String? _transactionPlace;
  String get transactionPlace => _transactionPlace ?? '';
  bool hasTransactionPlace() => _transactionPlace != null;

  // "category" field.
  DocumentReference? _category;
  DocumentReference? get category => _category;
  bool hasCategory() => _category != null;

  // "user" field.
  DocumentReference? _user;
  DocumentReference? get user => _user;
  bool hasUser() => _user != null;

  // "categoryName" field.
  List<String>? _categoryName;
  List<String> get categoryName => _categoryName ?? const [];
  bool hasCategoryName() => _categoryName != null;

  // "transactionReason" field.
  String? _transactionReason;
  String get transactionReason => _transactionReason ?? '';
  bool hasTransactionReason() => _transactionReason != null;

  // "budgetAssociated" field.
  DocumentReference? _budgetAssociated;
  DocumentReference? get budgetAssociated => _budgetAssociated;
  bool hasBudgetAssociated() => _budgetAssociated != null;

  void _initializeFields() {
    _transactionName = snapshotData['transactionName'] as String?;
    _transactionAmount = snapshotData['transactionAmount'] as String?;
    _transactionTime = snapshotData['transactionTime'] as DateTime?;
    _transactionPlace = snapshotData['transactionPlace'] as String?;
    _category = snapshotData['category'] as DocumentReference?;
    _user = snapshotData['user'] as DocumentReference?;
    _categoryName = getDataList(snapshotData['categoryName']);
    _transactionReason = snapshotData['transactionReason'] as String?;
    _budgetAssociated = snapshotData['budgetAssociated'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('transactions');

  static Stream<TransactionsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TransactionsRecord.fromSnapshot(s));

  static Future<TransactionsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TransactionsRecord.fromSnapshot(s));

  static TransactionsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TransactionsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TransactionsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TransactionsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TransactionsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TransactionsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

// Map<String, dynamic> createTransactionsRecordData({
//   String? transactionName,
//   String? transactionAmount,
//   DateTime? transactionTime,
//   String? transactionPlace,
//   DocumentReference? category,
//   DocumentReference? user,
//   String? transactionReason,
//   DocumentReference? budgetAssociated,
// }) {
//   final firestoreData = mapToFirestore(
//     <String, dynamic>{
//       'transactionName': transactionName,
//       'transactionAmount': transactionAmount,
//       'transactionTime': transactionTime,
//       'transactionPlace': transactionPlace,
//       'category': category,
//       'user': user,
//       'transactionReason': transactionReason,
//       'budgetAssociated': budgetAssociated,
//     }.withoutNulls,
//   );

//   return firestoreData;
// }
