import 'package:mfsbd/backend/backend.dart';

import '/fin_wallet/fin_wallet_util.dart';
import '/fin_wallet/form_field_controller.dart';
import 'package:flutter/material.dart';

class TransactionADDModel extends FinWalletModel {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for TextField widget.
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  String? _textController1Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'gzhmf1t6' /* Please enter an amount */,
      );
    }

    return null;
  }

  // State field(s) for SpentAt widget.
  TextEditingController? spentAtController;
  String? Function(BuildContext, String?)? spentAtControllerValidator;
  // State field(s) for budget widget.
  String? dropValue1;
  String? dropValue2;
  FormFieldController<String>? budgetValueController;
  // State field(s) for reason widget.
  TextEditingController? reasonController;
  String? Function(BuildContext, String?)? reasonControllerValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    textController1Validator = _textController1Validator;
  }

  void dispose() {
    textController1?.dispose();
    spentAtController?.dispose();
    reasonController?.dispose();
  }


  /// Action blocks are added here.

  /// Additional helper methods are added here.

}


  Map<String, dynamic> createTransactionsRecordData({
    String? userID,
    Timestamp? tarTime,
    String? tarAmount,
    String? cardType1,
    String? cardType2,
  }) {
    final firestoreData = mapToFirestore(
      <String, dynamic>{
        'userid': userID,
        'transactionTime': tarTime,
        'transactionAmount': tarAmount,
        'cardType1': cardType1,
        'cardType2': cardType2,
      }.withoutNulls,
    );

    return firestoreData;
  }
