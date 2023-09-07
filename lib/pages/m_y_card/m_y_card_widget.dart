import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mfsbd/index.dart';
import 'package:mfsbd/pages/card_detail/card_detail.dart';

import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/fin_wallet/fin_wallet_theme.dart';
import '/fin_wallet/fin_wallet_util.dart';
import 'm_y_card_model.dart';

export 'm_y_card_model.dart';

class MYCardWidget extends StatefulWidget {
  const MYCardWidget({Key? key}) : super(key: key);

  @override
  _MYCardWidgetState createState() => _MYCardWidgetState();
}

class _MYCardWidgetState extends State<MYCardWidget>
    with TickerProviderStateMixin {
  late MYCardModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MYCardModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UsersRecord>(
      stream: UsersRecord.getDocument(currentUserReference!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FinWalletTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 40.0,
                height: 40.0,
                child: SpinKitPumpingHeart(
                  color: FinWalletTheme.of(context).primary,
                  size: 40.0,
                ),
              ),
            ),
          );
        }
        final mYProfilePageUsersRecord = snapshot.data!;

        return Scaffold(
          key: scaffoldKey,
          backgroundColor: FinWalletTheme.of(context).primaryBackground,

          //Floating Action Button
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.bottomToTop,
                  duration: Duration(milliseconds: 220),
                  reverseDuration: Duration(milliseconds: 220),
                  child: TransferMonery(),
                ),
              );
            },
            backgroundColor: FinWalletTheme.of(context).tertiary,
            elevation: 8.0,
            child: Icon(
              Icons.swap_horiz_rounded,
              color: FinWalletTheme.of(context).textColor,
              size: 36.0,
            ),
          ),

          body: SafeArea(
            top: true,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 20.0, 16.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: FinWalletTheme.of(context).tertiary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    2.0, 2.0, 2.0, 2.0),
                                child: Container(
                                  width: 60.0,
                                  height: 60.0,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    valueOrDefault<String>(
                                      mYProfilePageUsersRecord.photoUrl,
                                      'https://firebasestorage.googleapis.com/v0/b/mfsbd-25488.appspot.com/o/user_1177568.png?alt=media&token=2a1946f5-73cb-457c-957b-f68547ffafbd',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              12.0, 0.0, 0.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    FFLocalizations.of(context).getText(
                                      '51kawpgz' /* Welcome, */,
                                    ),
                                    style: FinWalletTheme.of(context)
                                        .headlineSmall,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        4.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      valueOrDefault<String>(
                                        mYProfilePageUsersRecord.displayName,
                                        'User',
                                      ),
                                      style: FinWalletTheme.of(context)
                                          .headlineSmall
                                          .override(
                                            fontFamily: 'Lexend',
                                            color: FinWalletTheme.of(context)
                                                .tertiary,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 4.0, 0.0, 0.0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    '30kx6e5v' /* Your latest updates are below. */,
                                  ),
                                  style: FinWalletTheme.of(context).bodySmall,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  //Card Design.....
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.92,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 6.0,
                                color: Color(0x4B1A1F24),
                                offset: Offset(0.0, 2.0),
                              )
                            ],
                            gradient: LinearGradient(
                              colors: [Color(0xFF00968A), Color(0xFFF2A384)],
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
                                    .where('cardType', whereIn: ['FinWallet'])
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
                                          color: FinWalletTheme.of(context)
                                              .primary,
                                          size: 40.0,
                                        ),
                                      ),
                                    );
                                  } else if (snapshot.data!.docs.isEmpty) {
                                    return Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20.0, 10.0, 20.0, 0.0),
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.error,
                                            color: Colors.white,
                                            size: 60,
                                          ),
                                          Text(
                                            'Your FinWallet May be suspended or deleted!',
                                            style: FinWalletTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Lexend',
                                                  color:
                                                      FinWalletTheme.of(context)
                                                          .textColor,
                                                ),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    var data = snapshot.data!.docs;
                                    return Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20.0, 10.0, 20.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  '6t7n9ugd' /* Balance */,
                                                ),
                                                style:
                                                    FinWalletTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Lexend',
                                                          color:
                                                              FinWalletTheme.of(
                                                                      context)
                                                                  .textColor,
                                                        ),
                                              ),
                                              Text(
                                                '৳${data[0]['cardAmount']}',
                                                style:
                                                    FinWalletTheme.of(context)
                                                        .displaySmall
                                                        .override(
                                                          fontFamily: 'Lexend',
                                                          color:
                                                              FinWalletTheme.of(
                                                                      context)
                                                                  .textColor,
                                                          fontSize: 32.0,
                                                        ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text('Account Number',
                                                  style:
                                                      FinWalletTheme.of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Roboto Mono',
                                                            color: FinWalletTheme
                                                                    .of(context)
                                                                .textColor,
                                                          )),
                                              Text(
                                                data[0]['accountNumber'],
                                                style: FinWalletTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Roboto Mono',
                                                      color: FinWalletTheme.of(
                                                              context)
                                                          .textColor,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                },
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 12.0, 20.0, 16.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Golden',
                                      style: FinWalletTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Lexend',
                                            color: FinWalletTheme.of(context)
                                                .textColor,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 12.0, 20.0, 16.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      'assets/images/gold_chip.png',
                                      //Golden Chip
                                      width: 60.0,
                                      fit: BoxFit.fitWidth,
                                    ),
                                    Image.asset(
                                      'assets/images/finWallet_logo_landscape.png',
                                      //card logo
                                      width: 150.0,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  //Quick Service....
                  Container(
                    width: MediaQuery.of(context).size.width * 1.0,
                    decoration: BoxDecoration(
                      color: FinWalletTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0.0),
                        bottomRight: Radius.circular(0.0),
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 16.0, 20.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                FFLocalizations.of(context).getText(
                                  'yet7zk5d' /* Quick Service */,
                                ),
                                style: FinWalletTheme.of(context).bodySmall,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 12.0, 16.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //Transfer...
                              Container(
                                width: MediaQuery.of(context).size.width * 0.44,
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

                              //Add Cards...
                              Container(
                                width: MediaQuery.of(context).size.width * 0.44,
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
                                        child: AddNewCard(),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add_rounded,
                                        color: FinWalletTheme.of(context)
                                            .primaryText,
                                        size: 40.0,
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 8.0, 0.0, 0.0),
                                        child: Text(
                                          FFLocalizations.of(context).getText(
                                            'roobc02h' /*Add Card Button*/,
                                          ),
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
                        ),

                        ///All Cards
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 12.0, 20.0, 12.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                FFLocalizations.of(context).getText(
                                  '27pb7ji4' /* Other Cards */,
                                ),
                                style: FinWalletTheme.of(context).bodySmall,
                              ),
                            ],
                          ),
                        ),

                        //Other Cards....
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 24.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 4.0, 0.0, 4.0),
                                child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('cards')
                                      .where('cardType', whereIn: [
                                        'Bkash',
                                        'Nagad',
                                        'Upay',
                                        'Rocket',
                                        'Sure Cash',
                                        'Tap',
                                        'M Cash',
                                        'Ok Wallet',
                                        'Tele Cash',
                                      ])
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
                                            color: FinWalletTheme.of(context)
                                                .primary,
                                            size: 40.0,
                                          ),
                                        ),
                                      );
                                    } else if (snapshot.data!.docs.isEmpty) {
                                      return Center(
                                        child: Image.asset(
                                          'assets/images/nocardsadded.png',
                                          width: 230.0,
                                          height: 300.0,
                                          fit: BoxFit.fitWidth,
                                        ),
                                      );
                                    } else {
                                      var data = snapshot.data!.docs;
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: data.length,
                                        itemBuilder: (context, index) {
                                          return Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  await Navigator.push(
                                                    context,
                                                    PageTransition(
                                                      type: PageTransitionType
                                                          .bottomToTop,
                                                      duration: Duration(
                                                          milliseconds: 220),
                                                      reverseDuration: Duration(
                                                          milliseconds: 220),
                                                      child: CardDetail(
                                                          cardType: data[index]
                                                              ['cardType']),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  margin: EdgeInsetsDirectional
                                                      .only(bottom: 10.0),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.92,
                                                  decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 6.0,
                                                        color:
                                                            Color(0x4B1A1F24),
                                                        offset:
                                                            Offset(0.0, 2.0),
                                                      )
                                                    ],
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Color(0xFF00968A),
                                                        Color.fromARGB(
                                                            255, 132, 207, 242)
                                                      ],
                                                      stops: [0.0, 1.0],
                                                      begin:
                                                          AlignmentDirectional(
                                                              0.94, -1.0),
                                                      end: AlignmentDirectional(
                                                          -0.94, 1.0),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    20.0,
                                                                    20.0,
                                                                    20.0,
                                                                    0.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Image.asset(
                                                              data[index]['cardType'] ==
                                                                      'Bkash'
                                                                  ? 'assets/images/bkash_full.png'
                                                                  : data[index][
                                                                              'cardType'] ==
                                                                          'Nagad'
                                                                      ? 'assets/images/nagad_full.png'
                                                                      : data[index]['cardType'] ==
                                                                              'Upay'
                                                                          ? 'assets/images/upay_full.png'
                                                                          : data[index]['cardType'] == 'Rocket'
                                                                              ? 'assets/images/rocket_full.jpg'
                                                                              : data[index]['cardType'] == 'Sure Cash'
                                                                                  ? 'assets/images/surecash_full.jpg'
                                                                                  : data[index]['cardType'] == 'Tap'
                                                                                      ? 'assets/images/tap.png'
                                                                                      : data[index]['cardType'] == 'M Cash'
                                                                                          ? 'assets/images/mcash.png'
                                                                                          : data[index]['cardType'] == 'Ok Wallet'
                                                                                              ? 'assets/images/okwallet.png'
                                                                                              : 'assets/images/telecash.jpg',
                                                              //card logo
                                                              width: 80.0,
                                                              height: 40,
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                                            Text(
                                                              '৳ ${data[index]['cardAmount']}',
                                                              style: FinWalletTheme
                                                                      .of(context)
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
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    20.0,
                                                                    12.0,
                                                                    20.0,
                                                                    16.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              'AC-${data[index]['accountNumber']}',
                                                              style: FinWalletTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Roboto Mono',
                                                                    color: FinWalletTheme.of(
                                                                            context)
                                                                        .textColor,
                                                                  ),
                                                            ),
                                                            Text(
                                                              'Card-${index + 1}',
                                                              style: FinWalletTheme
                                                                      .of(context)
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
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
