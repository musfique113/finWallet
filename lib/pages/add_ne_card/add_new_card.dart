import 'package:firebase_auth/firebase_auth.dart';
import 'package:mfsbd/backend/schema/create_card_recprd.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '/backend/backend.dart';
import '/fin_wallet/fin_wallet_icon_button.dart';
import '/fin_wallet/fin_wallet_theme.dart';
import '/fin_wallet/fin_wallet_util.dart';
import '/fin_wallet/fin_wallet_widgets.dart';
import '/main.dart';
import 'package:flutter/material.dart';
import 'add_new_card_model.dart';
export 'add_new_card_model.dart';

class AddNewCard extends StatefulWidget {
  const AddNewCard({Key? key}) : super(key: key);

  @override
  _AddNewCardState createState() => _AddNewCardState();
}

class _AddNewCardState extends State<AddNewCard> with TickerProviderStateMixin {
  late AddNewCardModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddNewCardModel());

    _model.textController1 ??= TextEditingController();
    _model.accountNUmberController ??= TextEditingController();
    _model.textController3 ??= TextEditingController();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Future<bool> doesCardExist(String cardType) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('cards')
        .where('userid', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .where('cardType', isEqualTo: cardType)
        .get();

    return snapshot.docs.isNotEmpty;
  }

  List<String> dataList = [
    'Bkash',
    'Nagad',
    'Upay',
    'Rocket',
    'Sure Cash',
    'Tap',
    'M Cash',
    'Ok Wallet',
    'Tele Cash'
  ];
  List<String> imagePaths = [
    'assets/images/bkash2.png',
    'assets/images/nagad.png',
    'assets/images/upay.png',
    'assets/images/rocket.png',
    'assets/images/surecash.jpg',
    'assets/images/tap.png',
    'assets/images/mcash.png',
    'assets/images/okwallet.png',
    'assets/images/telecash.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      backgroundColor: FinWalletTheme.of(context).tertiary,
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
                  color: FinWalletTheme.of(context).secondaryBackground,
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
                              'xod9iwab' /* Add Card */,
                            ),
                            style: FinWalletTheme.of(context).displaySmall,
                          ),
                          Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color:
                                FinWalletTheme.of(context).primaryBackground,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: FinWalletIconButton(
                              borderColor: Colors.transparent,
                              borderRadius: 30.0,
                              buttonSize: 48.0,
                              icon: Icon(
                                Icons.close_rounded,
                                color:
                                    FinWalletTheme.of(context).secondaryText,
                                size: 30.0,
                              ),
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      ),

                      //Account Number...
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                        child: TextFormField(
                          controller: _model.accountNUmberController,
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Account Number',
                            labelStyle:
                                FinWalletTheme.of(context).titleMedium,
                            hintStyle: FinWalletTheme.of(context).bodyMedium,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FinWalletTheme.of(context).alternate,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            contentPadding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 32.0, 24.0, 32.0),
                          ),
                          style: FinWalletTheme.of(context).headlineSmall,
                          textAlign: TextAlign.start,
                          // validator: 
                          // _model.budgetNameControllerValidator
                          //     .onlyNumbersValidator(context),
                        ),
                      ),

                      ///Select Card...
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                        child: DropdownButtonFormField<String>(
                          value: _model.dropValue, // Card Type
                          onChanged: (val) =>
                              setState(() => _model.dropValue = val),
                          items: dataList.asMap().entries.map((entry) {
                            final int index = entry.key;
                            final String budgetValue = entry.value;
                            final String imagePath = imagePaths[index];
                            return DropdownMenuItem<String>(
                              value: budgetValue,
                              child: Row(
                                children: [
                                  Image.asset(
                                    imagePath,
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.fitHeight,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    budgetValue,
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: FinWalletTheme.of(context).grayLight,
                            size: 15.0,
                          ),
                          iconSize: 24,
                          elevation: 2,
                          borderRadius: BorderRadius.circular(10.0),
                          decoration: InputDecoration(
                            labelText: FFLocalizations.of(context).getText(
                              'qk15nsmc' /* Select Card */,
                            ),
                            labelStyle:
                                FinWalletTheme.of(context).titleMedium,
                            hintStyle: FinWalletTheme.of(context).bodyMedium,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FinWalletTheme.of(context).alternate,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            contentPadding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 32.0, 24.0, 32.0),
                          ),
                          style: FinWalletTheme.of(context).headlineSmall,
                        ),
                      ),
                      //Amount...
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
                              labelStyle: FinWalletTheme.of(context)
                                  .displaySmall
                                  .override(
                                    fontFamily: 'Lexend',
                                    color:
                                        FinWalletTheme.of(context).grayLight,
                                    fontWeight: FontWeight.w300,
                                  ),
                              hintText: FFLocalizations.of(context).getText(
                                'wih71x51' /* Amount */,
                              ),
                              hintStyle: FinWalletTheme.of(context)
                                  .displaySmall
                                  .override(
                                    fontFamily: 'Lexend',
                                    color:
                                        FinWalletTheme.of(context).grayLight,
                                    fontWeight: FontWeight.w300,
                                  ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: FinWalletTheme.of(context).alternate,
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
                                color: FinWalletTheme.of(context).primaryText,
                                size: 32.0,
                              ),
                            ),
                            style: FinWalletTheme.of(context).displaySmall,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            validator: _model.textController1Validator
                                .asValidator(context),
                          ),
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
                  FFButtonWidget(
                    onPressed: () async {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(16.0)),
                        ),
                        builder: (BuildContext context) {
                          return SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                      borderRadius: BorderRadius.circular(12),
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
                                      final accountNumber =
                                          _model.accountNUmberController.text;
                                      final cardType = _model.dropValue;

                                      final isCardExist = await doesCardExist(
                                          cardType.toString());
                                      if (isCardExist) {
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'You can add one type of card only once!',
                                            ),
                                          ),
                                        );
                                        return;
                                      }
                                      if (!RegExp(r'^[0-9]+$').hasMatch(accountNumber)) {
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Account Number should be only digits!',
                                            ),
                                          ),
                                        );
                                        return;
                                      }
                                      if (!RegExp(r'^[0-9]+$').hasMatch(_model.textController1.text)) {
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

                                      final cardsCreateData =
                                          createcardsRecordData(
                                        userID: FirebaseAuth
                                            .instance.currentUser?.uid,
                                        accountNumber: accountNumber,
                                        cardAmount: _model.textController1.text,
                                        cardCreated: getCurrentTimestamp,
                                        cardType: cardType,
                                      );

                                      await CardsRecord.collection
                                          .doc()
                                          .set(cardsCreateData);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Card Added Successfully!',
                                          ),
                                        ),
                                      );
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
                    text: FFLocalizations.of(context).getText(
                      'xod9iwab' /* Add Card Button */,
                    ),
                    options: FFButtonOptions(
                      width: 300.0,
                      height: 70.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FinWalletTheme.of(context).tertiary,
                      textStyle:
                          FinWalletTheme.of(context).displaySmall.override(
                                fontFamily: 'Lexend',
                                color: FinWalletTheme.of(context).textColor,
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
            ),
            Text(
              FFLocalizations.of(context).getText(
                'knu0nxbp' /* Tap above to complete request */,
              ),
              style: FinWalletTheme.of(context).bodyMedium.override(
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
