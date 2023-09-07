import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mfsbd/index.dart';
import 'package:mfsbd/pages/card_detail/add_money.dart';

import '/backend/backend.dart';
import '/fin_wallet/fin_wallet_icon_button.dart';
import '/fin_wallet/fin_wallet_theme.dart';
import '/fin_wallet/fin_wallet_util.dart';
import '/fin_wallet/fin_wallet_widgets.dart';
import '/main.dart';
import 'package:flutter/material.dart';
export 'card_detail_model.dart';

class CardDetail extends StatefulWidget {
  final String cardType;
  const CardDetail({Key? key, required this.cardType}) : super(key: key);

  @override
  _CardDetailState createState() => _CardDetailState();
}

class _CardDetailState extends State<CardDetail> with TickerProviderStateMixin {
  late CardDetailModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CardDetailModel());

    _model.textController1 ??= TextEditingController();
    _model.accountNUmberController ??= TextEditingController();
    _model.textController3 ??= TextEditingController();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  void deleteDocument() async {
    try {
      // Identify the reference of the document to be deleted
      final querySnapshot = await FirebaseFirestore.instance
          .collection('cards')
          .where('cardType', whereIn: [widget.cardType])
          .where('userid', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final documentReference = querySnapshot.docs.first.reference;

        // Delete the document
        await documentReference.delete();

        // Document has been deleted successfully
      } else {
        print('Document not found');
      }
    } catch (e) {
      print('Error deleting document: $e');
    }
  }

  void _showConfirmationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Are you sure you want to delete this card?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the bottom sheet
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF39D2C0)),
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      deleteDocument();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Card Removed!',
                          ),
                        ),
                      );
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NavBarPage(initialPage: 'MY_Card'),
                        ),
                        (r) => false,
                      );
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: Text('Delete'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

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
                            widget.cardType,
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
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.88,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 6.0,
                                    color: Color(0x4B1A1F24),
                                    offset: Offset(0.0, 2.0),
                                  )
                                ],
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF00968A),
                                    Color(0xFFF2A384)
                                  ],
                                  stops: [0.0, 1.0],
                                  begin: AlignmentDirectional(0.94, -1.0),
                                  end: AlignmentDirectional(-0.94, 1.0),
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('cards')
                                        .where('cardType',
                                            whereIn: [widget.cardType])
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
                                              color:
                                                  FinWalletTheme.of(context)
                                                      .primary,
                                              size: 40.0,
                                            ),
                                          ),
                                        );
                                      } else if (snapshot.data!.docs.isEmpty) {
                                        return Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 10.0, 20.0, 0.0),
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.error,
                                                color: Colors.white,
                                                size: 60,
                                              ),
                                              Text(
                                                'Your Card May be suspended or deleted!',
                                                style:
                                                    FinWalletTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Lexend',
                                                          color: FinWalletTheme
                                                                  .of(context)
                                                              .textColor,
                                                        ),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else {
                                        var data = snapshot.data!.docs;
                                        return Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 10.0, 20.0, 0.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          '6t7n9ugd' /* Balance */,
                                                        ),
                                                        style:
                                                            FinWalletTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Lexend',
                                                                  color: FinWalletTheme.of(
                                                                          context)
                                                                      .textColor,
                                                                ),
                                                      ),
                                                      Text(
                                                        '৳${data[0]['cardAmount']}',
                                                        style:
                                                            FinWalletTheme.of(
                                                                    context)
                                                                .displaySmall
                                                                .override(
                                                                  fontFamily:
                                                                      'Lexend',
                                                                  color: FinWalletTheme.of(
                                                                          context)
                                                                      .textColor,
                                                                  fontSize:
                                                                      32.0,
                                                                ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text('Account Number',
                                                          style: FinWalletTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Roboto Mono',
                                                                color: FinWalletTheme.of(
                                                                        context)
                                                                    .textColor,
                                                              )),
                                                      Text(
                                                        data[0]
                                                            ['accountNumber'],
                                                        style:
                                                            FinWalletTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Roboto Mono',
                                                                  color: FinWalletTheme.of(
                                                                          context)
                                                                      .textColor,
                                                                ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 12.0, 12.0, 12.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Regular',
                                                      style:
                                                          FinWalletTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Lexend',
                                                                color: FinWalletTheme.of(
                                                                        context)
                                                                    .textColor,
                                                              ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 12.0, 0.0, 16.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/gold_chip.png', //Golden Chip
                                                      width: 60.0,
                                                      fit: BoxFit.fitWidth,
                                                    ),
                                                    Image.asset(
                                                      data[0]['cardType'] ==
                                                              'Bkash'
                                                          ? 'assets/images/bkash_full.png'
                                                          : data[0]['cardType'] ==
                                                                  'Nagad'
                                                              ? 'assets/images/nagad_full.png'
                                                              : data[0]['cardType'] ==
                                                                      'Upay'
                                                                  ? 'assets/images/upay_full.png'
                                                                  : data[0]['cardType'] ==
                                                                          'Rocket'
                                                                      ? 'assets/images/rocket_full.jpg'
                                                                      : data[0]['cardType'] ==
                                                                              'Sure Cash'
                                                                          ? 'assets/images/surecash_full.jpg'
                                                                          : data[0]['cardType'] == 'Tap'
                                                                              ? 'assets/images/tap.png'
                                                                              : data[0]['cardType'] == 'M Cash'
                                                                                  ? 'assets/images/mcash.png'
                                                                                  : data[0]['cardType'] == 'Ok Wallet'
                                                                                      ? 'assets/images/okwallet.png'
                                                                                      : 'assets/images/telecash.jpg', //card logo
                                                      width: 120.0,
                                                      height: 60,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.40,
                            height: 100.0,
                            decoration: BoxDecoration(
                              color: FinWalletTheme.of(context)
                                  .primaryBackground,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.bottomToTop,
                                    duration: Duration(milliseconds: 220),
                                    reverseDuration:
                                        Duration(milliseconds: 220),
                                    child: TransferMonery(),
                                  ),
                                );
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.swap_horiz_rounded,
                                    color: FinWalletTheme.of(context)
                                        .primaryText,
                                    size: 40.0,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 8.0, 0.0, 0.0),
                                    child: Text(
                                      FFLocalizations.of(context).getText(
                                        '8bnd6lco' /* Transfer */,
                                      ),
                                      style: FinWalletTheme.of(context)
                                          .bodyMedium,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.40,
                            height: 100.0,
                            decoration: BoxDecoration(
                              color: FinWalletTheme.of(context)
                                  .primaryBackground,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.bottomToTop,
                                    duration: Duration(milliseconds: 220),
                                    reverseDuration:
                                        Duration(milliseconds: 220),
                                    child: AddMoney(cardType: widget.cardType),
                                  ),
                                );
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // FontAwesomeIcons(
                                  //   FontAwesomeIcons.moneyBillTransfer
                                  // ),
                                  Icon(
                                   FontAwesomeIcons.moneyBill1Wave,
                                    color: FinWalletTheme.of(context)
                                        .primaryText,
                                    size: 40.0,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 8.0, 0.0, 0.0),
                                    child: Text(
                                      'Add Money',
                                      style: FinWalletTheme.of(context)
                                          .bodyMedium,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
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
                      _showConfirmationBottomSheet(context);
                    },
                    text: 'Remove Card',
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
