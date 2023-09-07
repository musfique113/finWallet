// ignore_for_file: unnecessary_null_comparison

import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/fin_wallet/fin_wallet_theme.dart';
import '/fin_wallet/fin_wallet_util.dart';
import '/fin_wallet/fin_wallet_widgets.dart';
import '/fin_wallet/upload_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'edit_profile_model.dart';
export 'edit_profile_model.dart';

class EditProfileWidget extends StatefulWidget {
  const EditProfileWidget({
    Key? key,
    this.userProfile,
  }) : super(key: key);

  final DocumentReference? userProfile;

  @override
  _EditProfileWidgetState createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  late EditProfileModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditProfileModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UsersRecord>(
      stream: UsersRecord.getDocument(UsersRecord.collection.doc(currentUser!.uid)),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FinWalletTheme.of(context).secondaryBackground,
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
        final editProfileUsersRecord = snapshot.data!;
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: FinWalletTheme.of(context).secondaryBackground,
          appBar: AppBar(
            backgroundColor: FinWalletTheme.of(context).secondaryBackground,
            automaticallyImplyLeading: false,
            leading: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.chevron_left_rounded,
                color: FinWalletTheme.of(context).grayLight,
                size: 32.0,
              ),
            ),
            title: Text(
              FFLocalizations.of(context).getText(
                '4rzqov3y' /* Edit Profile */,
              ),
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      final selectedMedia =
                          await selectMediaWithSourceBottomSheet(
                        context: context,
                        allowPhoto: true,
                        backgroundColor:
                            FinWalletTheme.of(context).darkBackground,
                        textColor: FinWalletTheme.of(context).textColor,
                        pickerFontFamily: 'Lexend Deca',
                      );
                      if (selectedMedia != null &&
                          selectedMedia.every((m) =>
                              validateFileFormat(m.storagePath, context))) {
                        setState(() => _model.isDataUploading = true);
                        var selectedUploadedFiles = <FFUploadedFile>[];
                        var downloadUrls = <String>[];
                        try {
                          showUploadMessage(
                            context,
                            'Uploading file...',
                            showLoading: true,
                          );
                          selectedUploadedFiles = selectedMedia
                              .map((m) => FFUploadedFile(
                                    name: m.storagePath.split('/').last,
                                    bytes: m.bytes,
                                    height: m.dimensions?.height,
                                    width: m.dimensions?.width,
                                    blurHash: m.blurHash,
                                  ))
                              .toList();

                          downloadUrls = (await Future.wait(
                            selectedMedia.map(
                              (m) async =>
                                  await uploadData(m.storagePath, m.bytes),
                            ),
                          ))
                              .where((u) => u != null)
                              .map((u) => u!)
                              .toList();
                        } finally {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          _model.isDataUploading = false;
                        }
                        if (selectedUploadedFiles.length ==
                                selectedMedia.length &&
                            downloadUrls.length == selectedMedia.length) {
                          setState(() {
                            _model.uploadedLocalFile =
                                selectedUploadedFiles.first;
                            _model.uploadedFileUrl = downloadUrls.first;
                          });
                          showUploadMessage(context, 'Success!');
                        } else {
                          setState(() {});
                          showUploadMessage(context, 'Failed to upload data');
                          return;
                        }
                      }
                    },
                    child: Container(
                      width: 100.0,
                      height: 100.0,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: 
                      ((editProfileUsersRecord.photoUrl == '' || editProfileUsersRecord.photoUrl == null) && (_model.uploadedFileUrl == '' || _model.uploadedFileUrl == null)) ?
                      Image.network(
                        // valueOrDefault<String>(
                        //   _model.uploadedFileUrl,
                          'https://storage.googleapis.com/FinWallet-io-6f20.appspot.com/projects/finance-app-sample-kugwu4/assets/ijvuhvqbvns6/uiAvatar@2x.png',
                        // ),
                      ) : ((editProfileUsersRecord.photoUrl != '' || editProfileUsersRecord.photoUrl != null) && (_model.uploadedFileUrl == '' || _model.uploadedFileUrl == null)) ? Image.network(editProfileUsersRecord.photoUrl): Image.network(_model.uploadedFileUrl),
                    ),
                  ),
                ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
                    child: TextFormField(
                      controller: _model.yourNameController ??=
                          TextEditingController(
                        text: editProfileUsersRecord.displayName,
                      ),
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: FFLocalizations.of(context).getText(
                          '3p9y21e2' /* Your Name */,
                        ),
                        labelStyle: FinWalletTheme.of(context).bodySmall,
                        hintText: FFLocalizations.of(context).getText(
                          'dw9gmjdc' /* Please enter a valid number... */,
                        ),
                        hintStyle: FinWalletTheme.of(context).bodySmall,
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
                        filled: true,
                        fillColor:
                            FinWalletTheme.of(context).secondaryBackground,
                        contentPadding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 24.0, 20.0, 24.0),
                      ),
                      style: FinWalletTheme.of(context).bodyMedium,
                      validator: _model.yourNameControllerValidator
                          .asValidator(context),
                    ),
                  ),
                  // Padding(
                  //   padding:
                  //       EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
                  //   child: TextFormField(
                  //     controller: _model.yourEmailController ??=
                  //         TextEditingController(
                  //       text: editProfileUsersRecord.email,
                  //     ),
                  //     obscureText: false,
                  //     decoration: InputDecoration(
                  //       labelText: FFLocalizations.of(context).getText(
                  //         'z4fstn5l' /* Email Address */,
                  //       ),
                  //       labelStyle: FinWalletTheme.of(context).bodySmall,
                  //       hintText: FFLocalizations.of(context).getText(
                  //         'jozgvwyg' /* Your email */,
                  //       ),
                  //       hintStyle: FinWalletTheme.of(context).bodySmall,
                  //       enabledBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(
                  //           color: FinWalletTheme.of(context).alternate,
                  //           width: 2.0,
                  //         ),
                  //         borderRadius: BorderRadius.circular(8.0),
                  //       ),
                  //       focusedBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(
                  //           color: Color(0x00000000),
                  //           width: 2.0,
                  //         ),
                  //         borderRadius: BorderRadius.circular(8.0),
                  //       ),
                  //       errorBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(
                  //           color: Color(0x00000000),
                  //           width: 2.0,
                  //         ),
                  //         borderRadius: BorderRadius.circular(8.0),
                  //       ),
                  //       focusedErrorBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(
                  //           color: Color(0x00000000),
                  //           width: 2.0,
                  //         ),
                  //         borderRadius: BorderRadius.circular(8.0),
                  //       ),
                  //       filled: true,
                  //       fillColor:
                  //           FinWalletTheme.of(context).secondaryBackground,
                  //       contentPadding: EdgeInsetsDirectional.fromSTEB(
                  //           20.0, 24.0, 20.0, 24.0),
                  //     ),
                  //     style: FinWalletTheme.of(context).bodyMedium,
                  //     keyboardType: TextInputType.emailAddress,
                  //     validator: _model.yourEmailControllerValidator
                  //         .asValidator(context),
                  //   ),
                  // ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
                    child: TextFormField(
                      controller: _model.yourAgeController ??=
                          TextEditingController(
                        text: editProfileUsersRecord.age.toString(),
                      ),
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: FFLocalizations.of(context).getText(
                          '8h1cjk5a' /* Your Age */,
                        ),
                        labelStyle: FinWalletTheme.of(context).bodySmall,
                        hintText: FFLocalizations.of(context).getText(
                          '5v21r6gb' /* i.e. 34 */,
                        ),
                        hintStyle: FinWalletTheme.of(context).bodySmall,
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
                        filled: true,
                        fillColor:
                            FinWalletTheme.of(context).secondaryBackground,
                        contentPadding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 24.0, 20.0, 24.0),
                      ),
                      style: FinWalletTheme.of(context).bodyMedium,
                      keyboardType: TextInputType.number,
                      validator: _model.yourAgeControllerValidator
                          .asValidator(context),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
                    child: TextFormField(
                      controller: _model.yourTitleController ??=
                          TextEditingController(
                        text: editProfileUsersRecord.userTitle,
                      ),
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: FFLocalizations.of(context).getText(
                          'zvymbfia' /* Your Title */,
                        ),
                        labelStyle: FinWalletTheme.of(context).bodySmall,
                        hintStyle: FinWalletTheme.of(context).bodySmall,
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
                        filled: true,
                        fillColor:
                            FinWalletTheme.of(context).secondaryBackground,
                        contentPadding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 24.0, 20.0, 24.0),
                      ),
                      style: FinWalletTheme.of(context).bodyMedium,
                      validator: _model.yourTitleControllerValidator
                          .asValidator(context),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        if (_model.uploadedFileUrl == '' || _model.uploadedFileUrl == null){
                          _model.uploadedFileUrl = editProfileUsersRecord.photoUrl;
                        }
                        final usersUpdateData = createUsersRecordData(
                          displayName: _model.yourNameController.text,
                          // email: _model.yourEmailController.text,
                          age: int.tryParse(_model.yourAgeController.text),
                          userTitle: valueOrDefault<String>(
                            _model.yourTitleController.text,
                            'Badass Geek',
                          ),
                          photoUrl: _model.uploadedFileUrl,
                        );
                        await editProfileUsersRecord.reference
                            .update(usersUpdateData);
                        Navigator.pop(context);
                      },
                      text: FFLocalizations.of(context).getText(
                        'i6edcl52' /* Save Changes */,
                      ),
                      options: FFButtonOptions(
                        width: 230.0,
                        height: 56.0,
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FinWalletTheme.of(context).primary,
                        textStyle:
                            FinWalletTheme.of(context).titleSmall.override(
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
      },
    );
  }
}