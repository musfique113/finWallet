import 'dart:async';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';

class CardsRecord extends FirestoreRecord {
  CardsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "budetName" field.
  String? _budetName;
  String get budetName => _budetName ?? '';
  bool hasBudetName() => _budetName != null;

  // "cardCreated" field.
  DateTime? _cardCreated;
  DateTime? get cardCreated => _cardCreated;
  bool hascardCreated() => _cardCreated != null;

  // "cardDescription" field.
  String? _cardDescription;
  String get cardDescription => _cardDescription ?? '';
  bool hascardDescription() => _cardDescription != null;

  // "usercards" field.
  DocumentReference? _usercards;
  DocumentReference? get usercards => _usercards;
  bool hasUsercards() => _usercards != null;

  // "cardStartDate" field.
  DateTime? _cardStartDate;
  DateTime? get cardStartDate => _cardStartDate;
  bool hascardStartDate() => _cardStartDate != null;

  // "cardTime" field.
  String? _cardTime;
  String get cardTime => _cardTime ?? '';
  bool hascardTime() => _cardTime != null;

  // "cardAmount" field.
  String? _cardAmount;
  String get cardAmount => _cardAmount ?? '';
  bool hascardAmount() => _cardAmount != null;

  // "cardAmountNumber" field.
  int? _cardAmountNumber;
  int get cardAmountNumber => _cardAmountNumber ?? 0;
  bool hascardAmountNumber() => _cardAmountNumber != null;

  // "accountNumber" field.
  int? _accountNumber;
  int get accountNumber => _accountNumber ?? 0;
  bool hasaccountNumber() => _accountNumber != null;

  // "cardType" field.
  String? _cardType;
  String get cardType => _cardType ?? '';
  bool hascardType() => _cardType != null;

  void _initializeFields() {
    _cardCreated = snapshotData['cardCreated'] as DateTime?;
    _cardStartDate = snapshotData['cardStartDate'] as DateTime?;
    _cardTime = snapshotData['cardTime'] as String?;
    _cardAmount = snapshotData['cardAmount'] as String?;
    _accountNumber = snapshotData['accountNumber'] as int?;
    _cardType = snapshotData['cardType'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('cards');

  static Stream<CardsRecord> getDocument(ref) =>
      ref.snapshots().map((s) => CardsRecord.fromSnapshot(s));

  static Future<CardsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CardsRecord.fromSnapshot(s));

  static CardsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CardsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CardsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CardsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'cardsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CardsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createcardsRecordData({
  String? userID,
  DateTime? cardCreated,
  // String? cardDescription,
  // DocumentReference? usercards,
  DateTime? cardStartDate,
  String? cardTime,
  String? cardAmount,
  // int? cardAmountNumber,
  String? accountNumber,
  String? cardType,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'userid': userID,
      'cardCreated': cardCreated,
      // 'cardDescription': cardDescription,
      // 'usercards': usercards,
      'cardStartDate': cardStartDate,
      'cardTime': cardTime,
      'cardAmount': cardAmount,
      // 'cardAmountNumber': cardAmountNumber,
      'accountNumber': accountNumber,
      'cardType': cardType,
    }.withoutNulls,
  );

  return firestoreData;
}
