import '/auth/firebase_auth/auth_util.dart';
import '/fin_wallet/fin_wallet_theme.dart';
import '/fin_wallet/fin_wallet_util.dart';
import '/fin_wallet/fin_wallet_widgets.dart';
import '/main.dart';
import '/pages/forgot_password/forgot_password_widget.dart';
import '/pages/register_account/register_account_widget.dart';
import 'package:flutter/material.dart';
import 'login_page_model.dart';
export 'login_page_model.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({Key? key}) : super(key: key);

  @override
  _LoginPageWidgetState createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  late LoginPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginPageModel());

    _model.emailAddressLoginController ??= TextEditingController();
    _model.passwordLoginController ??= TextEditingController();
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
      backgroundColor: FinWalletTheme.of(context).primaryBackground,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 1.0,
                  height: MediaQuery.of(context).size.height * 1.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: Image.asset(
                        'assets/images/login_bg@2x.png',
                      ).image,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 40.0, 0.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 24.0, 0.0, 20.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if (Theme.of(context).brightness == Brightness.dark)
                                Image.asset(
                                  'assets/images/finWallet_logo_landscape.png',
                                  width: 170.0,
                                  height: 60.0,
                                  fit: BoxFit.fitWidth,
                                ),
                              if (!(Theme.of(context).brightness ==
                                  Brightness.dark))
                                Image.asset(
                                  'assets/images/finWallet_logo_landscapeDark@3x.png',
                                  width: 170.0,
                                  height: 60.0,
                                  fit: BoxFit.fitWidth,
                                ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 24.0, 0.0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'o07j3mgv' /* Welcome back */,
                                      ),
                                      style: FinWalletTheme.of(context)
                                          .displaySmall,
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 12.0, 0.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          'fzxvw3mu' /* Login to access your account b... */,
                                        ),
                                        style: FinWalletTheme.of(context)
                                            .titleMedium,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 20.0, 0.0, 0.0),
                                  child: TextFormField(
                                    controller:
                                        _model.emailAddressLoginController,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText:
                                          FFLocalizations.of(context).getText(
                                        'a9j78va9' /* Email Address */,
                                      ),
                                      labelStyle:
                                          FinWalletTheme.of(context).bodySmall,
                                      hintText:
                                          FFLocalizations.of(context).getText(
                                        'i7f18cve' /* Enter your email... */,
                                      ),
                                      hintStyle:
                                          FinWalletTheme.of(context).bodySmall,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      filled: true,
                                      fillColor: FinWalletTheme.of(context)
                                          .secondaryBackground,
                                      contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              20.0, 24.0, 20.0, 24.0),
                                    ),
                                    style:
                                        FinWalletTheme.of(context).bodyMedium,
                                    validator: _model
                                        .emailAddressLoginControllerValidator
                                        .asValidator(context),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 12.0, 0.0, 0.0),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    maxLength: 6,
                                    controller: _model.passwordLoginController,
                                    obscureText: !_model.passwordLoginVisibility,
                                    decoration: InputDecoration(
                                      counterText: '',
                                      labelText:
                                          'Pin',
                                      labelStyle:
                                          FinWalletTheme.of(context).bodySmall,
                                      hintText:
                                         'Enter Your Six Digit Pin',
                                      hintStyle:
                                          FinWalletTheme.of(context).bodySmall,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      filled: true,
                                      fillColor: FinWalletTheme.of(context)
                                          .secondaryBackground,
                                      contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              20.0, 24.0, 20.0, 24.0),
                                      suffixIcon: InkWell(
                                        onTap: () => setState(
                                          () => _model.passwordLoginVisibility =
                                              !_model.passwordLoginVisibility,
                                        ),
                                        focusNode: FocusNode(skipTraversal: true),
                                        child: Icon(
                                          _model.passwordLoginVisibility
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined,
                                          color: Color(0x98FFFFFF),
                                          size: 20.0,
                                        ),
                                      ),
                                    ),
                                    style:
                                        FinWalletTheme.of(context).bodyMedium,
                                    validator: _model
                                        .passwordLoginControllerValidator
                                        .asValidator(context),
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 24.0, 0.0, 24.0),
                                      child: FFButtonWidget(
                                        onPressed: () async {
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ForgotPasswordWidget(),
                                            ),
                                          );
                                        },
                                        text: FFLocalizations.of(context).getText(
                                          'm2xyjvuf' /* Forgot Password? */,
                                        ),
                                        options: FFButtonOptions(
                                          width: 170.0,
                                          height: 40.0,
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                          iconPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          color: Color(0x001A1F24),
                                          textStyle: FinWalletTheme.of(context)
                                              .bodySmall,
                                          elevation: 0.0,
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                      ),
                                    ),
                                    FFButtonWidget(
                                      onPressed: () async {
                                        final user =
                                            await authManager.signInWithEmail(
                                          context,
                                          _model.emailAddressLoginController.text,
                                          _model.passwordLoginController.text,
                                        );
                                        if (user == null) {
                                          return;
                                        }
      
                                        await Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => NavBarPage(
                                                initialPage: 'MY_Card'),
                                          ),
                                          (r) => false,
                                        );
                                      },
                                      text: FFLocalizations.of(context).getText(
                                        'qbmoi1av' /* Login */,
                                      ),
                                      options: FFButtonOptions(
                                        width: 120.0,
                                        height: 50.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color:
                                            FinWalletTheme.of(context).primary,
                                        textStyle: FinWalletTheme.of(context)
                                            .titleSmall,
                                        elevation: 3.0,
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterAccountWidget(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: MediaQuery.of(context).size.width *
                                            0.8,
                                        height: 44.0,
                                        decoration: BoxDecoration(
                                          color: FinWalletTheme.of(context)
                                              .secondaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              FFLocalizations.of(context).getText(
                                                'cjqb8ial' /* Don't have an account? */,
                                              ),
                                              style: FinWalletTheme.of(context)
                                                  .bodyMedium,
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsetsDirectional.fromSTEB(
                                                      24.0, 0.0, 4.0, 0.0),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'a0iimirx' /* Create */,
                                                ),
                                                style:
                                                    FinWalletTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Lexend',
                                                          color:
                                                              FinWalletTheme.of(
                                                                      context)
                                                                  .primary,
                                                        ),
                                              ),
                                            ),
                                            Icon(
                                              Icons.arrow_forward_rounded,
                                              color: FinWalletTheme.of(context)
                                                  .primary,
                                              size: 24.0,
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

                        // Padding(
                        //   padding:
                        //       EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                        //   child: FFButtonWidget(
                        //     onPressed: () async {
                        //       final user =
                        //           await authManager.signInAnonymously(context);
                        //       if (user == null) {
                        //         return;
                        //       }
                        //
                        //       // final budgetListCreateData =
                        //       //     createBudgetListRecordData(
                        //       //   budgetUser: currentUserReference,
                        //       // );
                        //       // await BudgetListRecord.collection
                        //       //     .doc()
                        //       //     .set(budgetListCreateData);
                        //       await Navigator.pushAndRemoveUntil(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (context) =>
                        //               NavBarPage(initialPage: 'MY_Card'),
                        //         ),
                        //         (r) => false,
                        //       );
                        //     },
                        //     text: FFLocalizations.of(context).getText(
                        //       '1zqiw31h' /* Continue as Guest */,
                        //     ),
                        //     options: FFButtonOptions(
                        //       width: 230.0,
                        //       height: 50.0,
                        //       padding: EdgeInsetsDirectional.fromSTEB(
                        //           0.0, 0.0, 0.0, 0.0),
                        //       iconPadding: EdgeInsetsDirectional.fromSTEB(
                        //           0.0, 0.0, 0.0, 0.0),
                        //       color: FinWalletTheme.of(context)
                        //           .secondaryBackground,
                        //       textStyle: FinWalletTheme.of(context)
                        //           .titleSmall
                        //           .override(
                        //             fontFamily: 'Lexend',
                        //             color:
                        //                 FinWalletTheme.of(context).primaryText,
                        //           ),
                        //       elevation: 3.0,
                        //       borderSide: BorderSide(
                        //         color: Colors.transparent,
                        //         width: 1.0,
                        //       ),
                        //       borderRadius: BorderRadius.circular(30.0),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
