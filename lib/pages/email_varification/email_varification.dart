import 'package:firebase_auth/firebase_auth.dart';
import 'package:mfsbd/index.dart';
// import 'package:mfsbd/pages/complete_profile/complete_profile_widget.dart';

// import '/auth/firebase_auth/auth_util.dart';
import '/fin_wallet/fin_wallet_theme.dart';
import '/fin_wallet/fin_wallet_util.dart';
import '/fin_wallet/fin_wallet_widgets.dart';
import 'package:flutter/material.dart';
import 'email_varification_model.dart';
export 'email_varification_model.dart';

class EmailVarificationWidget extends StatefulWidget {
  const EmailVarificationWidget({Key? key}) : super(key: key);

  @override
  _EmailVarificationWidgetState createState() =>
      _EmailVarificationWidgetState();
}

class _EmailVarificationWidgetState extends State<EmailVarificationWidget> {
  late EmailVarificationModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EmailVarificationModel());

    _model.emailAddressController ??= TextEditingController();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  // Manually check if verification is done and redirect
  void manualRedirect(context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      user.reload();
      if (user.emailVerified) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => 
            CompleteProfileWidget(),
          ),
          (r) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Email is not varified!',
            ),
          ),
        );
      }
    }
  }
  Future<bool> onWillPop() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .delete();
    await FirebaseAuth.instance.currentUser?.delete();
    await Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.leftToRight,
        duration: Duration(milliseconds: 220),
        reverseDuration: Duration(milliseconds: 220),
        child: LoginPageWidget(),
      ),
    );

    return true;
  }
  

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FinWalletTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FinWalletTheme.of(context).primaryBackground,
          automaticallyImplyLeading: true,
          title: Text(
            'Varify Email',
            style: FinWalletTheme.of(context).headlineSmall,
          ),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: Container(
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.attach_email_outlined,
                size: 100,
                color: const Color(0xFF00968A),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'We have sent you an email with varification link. Please varify your account then press continue.',
                        textAlign: TextAlign.center,
                        style: FinWalletTheme.of(context).bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
              //   child: TextFormField(
              //     controller: _model.emailAddressController,
              //     obscureText: false,
              //     decoration: InputDecoration(
              //       labelText: FFLocalizations.of(context).getText(
              //         'u4nuk910' /* Email Address */,
              //       ),
              //       labelStyle: FinWalletTheme.of(context).bodySmall,
              //       hintText: FFLocalizations.of(context).getText(
              //         '37kotxi0' /* Enter your email... */,
              //       ),
              //       hintStyle: FinWalletTheme.of(context).bodySmall,
              //       enabledBorder: OutlineInputBorder(
              //         borderSide: BorderSide(
              //           color: Color(0x00000000),
              //           width: 1.0,
              //         ),
              //         borderRadius: BorderRadius.circular(8.0),
              //       ),
              //       focusedBorder: OutlineInputBorder(
              //         borderSide: BorderSide(
              //           color: Color(0x00000000),
              //           width: 1.0,
              //         ),
              //         borderRadius: BorderRadius.circular(8.0),
              //       ),
              //       errorBorder: OutlineInputBorder(
              //         borderSide: BorderSide(
              //           color: Color(0x00000000),
              //           width: 1.0,
              //         ),
              //         borderRadius: BorderRadius.circular(8.0),
              //       ),
              //       focusedErrorBorder: OutlineInputBorder(
              //         borderSide: BorderSide(
              //           color: Color(0x00000000),
              //           width: 1.0,
              //         ),
              //         borderRadius: BorderRadius.circular(8.0),
              //       ),
              //       filled: true,
              //       fillColor: FinWalletTheme.of(context).secondaryBackground,
              //       contentPadding:
              //           EdgeInsetsDirectional.fromSTEB(20.0, 24.0, 20.0, 24.0),
              //     ),
              //     style: FinWalletTheme.of(context).bodyMedium,
              //     validator:
              //         _model.emailAddressControllerValidator.asValidator(context),
              //   ),
              // ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                child: FFButtonWidget(
                  onPressed: () async {
                    // if (_model.emailAddressController.text.isEmpty) {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     SnackBar(
                    //       content: Text(
                    //         'Email required!',
                    //       ),
                    //     ),
                    //   );
                    //   return;
                    // }
                    // await authManager.resetPassword(
                    //   email: _model.emailAddressController.text,
                    //   context: context,
                    // );
                    manualRedirect(context);
                  },
                  text: 'Continue',
                  options: FFButtonOptions(
                    width: 190.0,
                    height: 50.0,
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FinWalletTheme.of(context).primary,
                    textStyle: FinWalletTheme.of(context).titleSmall.override(
                          fontFamily: 'Lexend',
                          color: FinWalletTheme.of(context).textColor,
                        ),
                    elevation: 3.0,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
