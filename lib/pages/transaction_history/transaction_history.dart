import 'package:firebase_auth/firebase_auth.dart';

import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'm_y_budgets_model.dart';
export 'm_y_budgets_model.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({Key? key}) : super(key: key);

  @override
  _TransactionHistoryState createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory>
    with TickerProviderStateMixin {
  late MYBudgetsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MYBudgetsModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        automaticallyImplyLeading: false,
        title: Text(
          'Transaction History',
          style: FlutterFlowTheme.of(context).displaySmall,
        ),
        actions: [],
        centerTitle: false,
        elevation: 0.0,
      ),
      body: SafeArea(
        top: true,
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 4.0),
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('transactions')
                        .where('userid',
                            isEqualTo: FirebaseAuth.instance.currentUser?.uid)
                        // .orderBy(
                        //     'transactionTime', descending: true) // Add this line to order by the 'transactionTime' field
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: SizedBox(
                            width: 40.0,
                            height: 40.0,
                            child: SpinKitPumpingHeart(
                              color: FlutterFlowTheme.of(context).primary,
                              size: 40.0,
                            ),
                          ),
                        );
                      } else if (snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: Image.asset(
                            'assets/images/notransactionhistory.png',
                            width: 230.0,
                            height: 300.0,
                            fit: BoxFit.fitWidth,
                          ),
                        );
                      } else {
                        var data = snapshot.data!.docs;
                        data.sort((a, b) => (b['transactionTime'] as Timestamp)
                            .compareTo(a['transactionTime'] as Timestamp));
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin:
                                      EdgeInsetsDirectional.only(bottom: 10.0),
                                  width:
                                      MediaQuery.of(context).size.width * 0.92,
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
                                        Color.fromARGB(255, 132, 207, 242)
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
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20.0, 20.0, 20.0, 0.0),
                                        child: Row(
                                          // mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Image.asset(
                                              data[index]['cardType1'] ==
                                                      'Bkash'
                                                  ? 'assets/images/bkash_full.png'
                                                  : data[index]['cardType1'] ==
                                                          'Nagad'
                                                      ? 'assets/images/nagad_full.png'
                                                      : data[index][
                                                                  'cardType1'] ==
                                                              'Upay'
                                                          ? 'assets/images/upay_full.png'
                                                          : data[index][
                                                                      'cardType1'] ==
                                                                  'Rocket'
                                                              ? 'assets/images/rocket_full.jpg'
                                                              : data[index][
                                                                          'cardType1'] ==
                                                                      'Sure Cash'
                                                                  ? 'assets/images/surecash_full.jpg'
                                                                  : data[index][
                                                                              'cardType1'] ==
                                                                          'Tap'
                                                                      ? 'assets/images/tap.png'
                                                                      : data[index]['cardType1'] ==
                                                                              'M Cash'
                                                                          ? 'assets/images/mcash.png'
                                                                          : data[index]['cardType1'] == 'Ok Wallet'
                                                                              ? 'assets/images/okwallet.png'
                                                                              : data[index]['cardType1'] == 'Tele Cash'
                                                                                  ? 'assets/images/telecash.jpg'
                                                                                  : (Theme.of(context).brightness == Brightness.dark ? 'assets/images/finWallet_logo_landscape.png' : 'assets/images/finWallet_logo_landscapeDark@3x.png'),
                                              //card logo
                                              width: 80.0,
                                              height: 40,
                                              fit: BoxFit.contain,
                                            ),
                                            Image.asset(
                                              'assets/images/fast-forward.png',
                                              height: 20,
                                              color: Colors.amber,
                                            ),
                                            Image.asset(
                                              data[index]['cardType2'] ==
                                                      'Bkash'
                                                  ? 'assets/images/bkash_full.png'
                                                  : data[index]['cardType2'] ==
                                                          'Nagad'
                                                      ? 'assets/images/nagad_full.png'
                                                      : data[index][
                                                                  'cardType2'] ==
                                                              'Upay'
                                                          ? 'assets/images/upay_full.png'
                                                          : data[index][
                                                                      'cardType2'] ==
                                                                  'Rocket'
                                                              ? 'assets/images/rocket_full.jpg'
                                                              : data[index][
                                                                          'cardType2'] ==
                                                                      'Sure Cash'
                                                                  ? 'assets/images/surecash_full.jpg'
                                                                  : data[index][
                                                                              'cardType2'] ==
                                                                          'Tap'
                                                                      ? 'assets/images/tap.png'
                                                                      : data[index]['cardType2'] ==
                                                                              'M Cash'
                                                                          ? 'assets/images/mcash.png'
                                                                          : data[index]['cardType2'] == 'Ok Wallet'
                                                                              ? 'assets/images/okwallet.png'
                                                                              : data[index]['cardType2'] == 'Tele Cash'
                                                                                  ? 'assets/images/telecash.jpg'
                                                                                  : (Theme.of(context).brightness == Brightness.dark ? 'assets/images/finWallet_logo_landscape.png' : 'assets/images/finWallet_logo_landscapeDark@3x.png'),
                                              //card logo
                                              width: 80.0,
                                              height: 40,
                                              fit: BoxFit.contain,
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
                                            Text(
                                              '৳ ${data[index]['transactionAmount']}',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .displaySmall
                                                      .override(
                                                        fontFamily: 'Lexend',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .textColor,
                                                        fontSize: 32.0,
                                                      ),
                                            ),
                                            Text(
                                              DateFormat('yyyy-MM-dd HH:mm')
                                                  .format(
                                                (data[index]['transactionTime']
                                                        as Timestamp)
                                                    .toDate(),
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Roboto Mono',
                                                    color: FlutterFlowTheme.of(
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
        ),
      ),
    );
  }
}
