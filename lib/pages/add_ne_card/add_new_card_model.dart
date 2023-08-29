import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class AddNewCardModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for TextField widget.
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  String? _textController1Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        '79au6dyg' /* Please enter an amount */,
      );
    }

    return null;
  }

  // State field(s) for budgetName widget.
  TextEditingController? accountNUmberController;
  String? Function(BuildContext, String?)? budgetNameControllerValidator;
  // State field(s) for TextField widget.
  TextEditingController? textController3;
  String? Function(BuildContext, String?)? textController3Validator;
  String? dropValue;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    textController1Validator = _textController1Validator;
  }

  void dispose() {
    textController1?.dispose();
    accountNUmberController?.dispose();
    textController3?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.

}
