import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mfsbd/main.dart';

import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'tansfer_money_model.dart';
export 'tansfer_money_model.dart';

class TransferMonery extends StatefulWidget {
  const TransferMonery({Key? key}) : super(key: key);

  @override
  _TransferMoneryState createState() => _TransferMoneryState();
}

class _TransferMoneryState extends State<TransferMonery>
    with TickerProviderStateMixin {
  late TransactionADDModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TransactionADDModel());

    _model.textController1 ??= TextEditingController();
    _model.spentAtController ??= TextEditingController();
    _model.reasonController ??= TextEditingController();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Future<bool> balanceCheck(String cardType, int amnt) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('cards')
        .where('userid', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .where('cardType', isEqualTo: cardType)
        .get();

    if (snapshot.docs.isNotEmpty) {
      var balanceData = snapshot.docs[0].data();
      int currentBalance = int.parse(balanceData['cardAmount'].toString());

      if (currentBalance >= amnt) {
        String newBalance = (currentBalance - amnt).toString();
        print(newBalance);
        print(snapshot.docs[0].id);

        await FirebaseFirestore.instance
            .collection('cards')
            .doc(snapshot.docs[0].id)
            .set({'cardAmount': newBalance}, SetOptions(merge: true));
        print('done');
        return false; // Balance was sufficient, and deduction was successful.
      } else {
        return true; // Insufficient balance.
      }
    } else {
      return true; // No matching card document found.
    }
  }

  Future<bool> balanceTransfer(String cardType, int amnt) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('cards')
        .where('userid', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .where('cardType', isEqualTo: cardType)
        .get();

    if (snapshot.docs.isNotEmpty) {
      var balanceData = snapshot.docs[0].data();
      int currentBalance = int.parse(balanceData['cardAmount']);

        String newBalance = (currentBalance + amnt).toString();

        await FirebaseFirestore.instance
            .collection('cards')
            .doc(snapshot.docs[0].id)
            .update({'cardAmount': newBalance});
      return true;

    } else {
      return false; // No matching card document found.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).tertiary,
      body: Form(
        key: _model.formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Material(
              color: Colors.transparent,
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16.0),
                  bottomRight: Radius.circular(16.0),
                  topLeft: Radius.circular(0.0),
                  topRight: Radius.circular(0.0),
                ),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 1.0,
                height: MediaQuery.of(context).size.height * 0.8,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0),
                    topLeft: Radius.circular(0.0),
                    topRight: Radius.circular(0.0),
                  ),
                ),
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 44.0, 20.0, 20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              'qywon4k1' /*Transfer Money Header*/,
                            ),
                            style: FlutterFlowTheme.of(context).displaySmall,
                          ),
                          Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: FlutterFlowIconButton(
                              borderColor: Colors.transparent,
                              borderRadius: 30.0,
                              buttonSize: 48.0,
                              icon: Icon(
                                Icons.close_rounded,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 30.0,
                              ),
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 100.0,
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.8,
                        ),
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 16.0, 0.0, 0.0),
                          child: TextFormField(
                            controller: _model.textController1,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelStyle: FlutterFlowTheme.of(context)
                                  .displaySmall
                                  .override(
                                    fontFamily: 'Lexend',
                                    color:
                                        FlutterFlowTheme.of(context).grayLight,
                                    fontWeight: FontWeight.w300,
                                  ),
                              hintText: FFLocalizations.of(context).getText(
                                'bh9tad8e' /* Amount */,
                              ),
                              hintStyle: FlutterFlowTheme.of(context)
                                  .displaySmall
                                  .override(
                                    fontFamily: 'Lexend',
                                    color:
                                        FlutterFlowTheme.of(context).grayLight,
                                    fontWeight: FontWeight.w300,
                                  ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedErrorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              contentPadding: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 24.0, 24.0, 24.0),
                              prefixIcon: FaIcon(
                                FontAwesomeIcons.bangladeshiTakaSign,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 32.0,
                              ),
                            ),
                            style: FlutterFlowTheme.of(context).displaySmall,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            validator: _model.textController1Validator
                                .asValidator(context),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('cards')
                                    .where('userid',
                                        isEqualTo: FirebaseAuth
                                            .instance.currentUser?.uid)
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: SizedBox(
                                        width: 40.0,
                                        height: 40.0,
                                        child: SpinKitPumpingHeart(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          size: 40.0,
                                        ),
                                      ),
                                    );
                                  } else {
                                    List cardTypes1 = snapshot.data!.docs
                                        .map((doc) => doc['cardType'] as String)
                                        .toList();
                                    return DropdownButtonFormField<String>(
                                      value: _model
                                          .dropValue2, // Replace with your selected value variable
                                      onChanged: (val) => setState(
                                          () => _model.dropValue2 = val),
                                      items: cardTypes1.map((entry) {
                                        return DropdownMenuItem<String>(
                                          value: entry,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                entry == 'Bkash'
                                                    ? 'assets/images/bkash_full.png'
                                                    : entry == 'Nagad'
                                                        ? 'assets/images/nagad_full.png'
                                                        : entry == 'Upay'
                                                            ? 'assets/images/upay_full.png'
                                                            : entry == 'Rocket'
                                                                ? 'assets/images/rocket_full.jpg'
                                                                : entry ==
                                                                        'Sure Cash'
                                                                    ? 'assets/images/surecash_full.jpg'
                                                                    : entry ==
                                                                            'Tap'
                                                                        ? 'assets/images/tap.png'
                                                                        : entry ==
                                                                                'M Cash'
                                                                            ? 'assets/images/mcash.png'
                                                                            : entry == 'Ok Wallet'
                                                                                ? 'assets/images/okwallet.png'
                                                                                : entry == 'Tele Cash'
                                                                                    ? 'assets/images/telecash.jpg'
                                                                                    : (Theme.of(context).brightness == Brightness.dark ? 'assets/images/finWallet_logo_landscape.png' : 'assets/images/finWallet_logo_landscapeDark@3x.png'),
                                                height: 43,
                                                // width: 110,
                                                fit: BoxFit.fitHeight,
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                      icon: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .grayLight,
                                        size: 15.0,
                                      ),
                                      iconSize: 24,
                                      elevation: 2,
                                      borderRadius: BorderRadius.circular(10.0),
                                      decoration: InputDecoration(
                                        labelText: 'From',
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .titleMedium,
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        contentPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                20.0, 32.0, 24.0, 32.0),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .headlineSmall,
                                      // textAlign: TextAlign.start,
                                    );
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('cards')
                                    .where('userid',
                                        isEqualTo: FirebaseAuth
                                            .instance.currentUser?.uid)
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: SizedBox(
                                        width: 40.0,
                                        height: 40.0,
                                        child: SpinKitPumpingHeart(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          size: 40.0,
                                        ),
                                      ),
                                    );
                                  } else {
                                    List<String> cardTypes = snapshot.data!.docs
                                        .map((doc) => doc['cardType'] as String)
                                        .toList();
                                    return DropdownButtonFormField<String>(
                                      value: _model.dropValue1,
                                      onChanged: (val) => setState(
                                          () => _model.dropValue1 = val),
                                      items: cardTypes.map((entry) {
                                        return DropdownMenuItem<String>(
                                          value: entry,
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                entry == 'Bkash'
                                                    ? 'assets/images/bkash_full.png'
                                                    : entry == 'Nagad'
                                                        ? 'assets/images/nagad_full.png'
                                                        : entry == 'Upay'
                                                            ? 'assets/images/upay_full.png'
                                                            : entry == 'Rocket'
                                                                ? 'assets/images/rocket_full.jpg'
                                                                : entry ==
                                                                        'Sure Cash'
                                                                    ? 'assets/images/surecash_full.jpg'
                                                                    : entry ==
                                                                            'Tap'
                                                                        ? 'assets/images/tap.png'
                                                                        : entry ==
                                                                                'M Cash'
                                                                            ? 'assets/images/mcash.png'
                                                                            : entry == 'Ok Wallet'
                                                                                ? 'assets/images/okwallet.png'
                                                                                : entry == 'Tele Cash'
                                                                                    ? 'assets/images/telecash.jpg'
                                                                                    : (Theme.of(context).brightness == Brightness.dark ? 'assets/images/finWallet_logo_landscape.png' : 'assets/images/finWallet_logo_landscapeDark@3x.png'),
                                                height: 43,
                                                // width: 110,
                                                fit: BoxFit.fitHeight,
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                      icon: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .grayLight,
                                        size: 15.0,
                                      ),
                                      iconSize: 24,
                                      elevation: 2,
                                      borderRadius: BorderRadius.circular(10.0),
                                      decoration: InputDecoration(
                                        labelText: 'To',
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .titleMedium,
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        contentPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                20.0, 32.0, 24.0, 32.0),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .headlineSmall,
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      FFButtonWidget(
                        onPressed: () async {
                          // _showConfirmationBottomSheet(context);
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16.0)),
                            ),
                            builder: (BuildContext context) {
                              return SingleChildScrollView(
                                child: Container(
                                  padding: EdgeInsets.all(16),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        'OTP',
                                        style: TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'We have sent you a 6 digit otp to your mobile please confirm!',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        padding: EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 2,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '000000',
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      ElevatedButton(
                                        onPressed: () async {
                                          if (!RegExp(r'^[0-9]+$').hasMatch(
                                              _model.textController1.text)) {
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Please provide valid amount!',
                                                ),
                                              ),
                                            );
                                            return;
                                          }
                                          final cardType =
                                              _model.dropValue2.toString();
                                          final cardType2 =
                                              _model.dropValue1.toString();
                                          final isBalanceAvailable =
                                              await balanceCheck(
                                                  cardType,
                                                  int.parse(_model
                                                      .textController1.text));

                                          if (isBalanceAvailable) {
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Not Enough Balance in source card!',
                                                ),
                                              ),
                                            );
                                            return;
                                          }

                                          await balanceTransfer(
                                              cardType2,
                                              int.parse(
                                                  _model.textController1.text));

                                          final createTransaction =
                                              createTransactionsRecordData(
                                            userID: FirebaseAuth
                                                .instance.currentUser?.uid,
                                            cardType1: cardType,
                                            cardType2: cardType2,
                                            tarAmount:
                                                _model.textController1.text,
                                            tarTime: Timestamp.now(),
                                                // DateFormat('yyyy-MM-dd – kk:mm')
                                                //     .format(),
                                                    // .toString(),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Transaction was successfull!',
                                              ),
                                            ),
                                          );
                                          await FirebaseFirestore.instance
                                              .collection('transactions')
                                              .doc()
                                              .set(createTransaction);
                                          await Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => NavBarPage(
                                                  initialPage: 'MY_Card'),
                                            ),
                                            (r) => false,
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                        ),
                                        child: Text(
                                          'Skip',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        text: 'Transfer Money',
                        options: FFButtonOptions(
                          width: 300.0,
                          height: 70.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).tertiary,
                          textStyle: FlutterFlowTheme.of(context)
                              .displaySmall
                              .override(
                                fontFamily: 'Lexend',
                                color: FlutterFlowTheme.of(context).textColor,
                              ),
                          elevation: 0.0,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text(
              FFLocalizations.of(context).getText(
                '9stmpsf0' /* Tap above to complete request */,
              ),
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Lexend',
                    color: Color(0x43000000),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
