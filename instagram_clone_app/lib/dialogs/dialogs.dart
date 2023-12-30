import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone_app/dialogs/generic_dialog.dart';

@immutable 
class LogoutAlertDialog extends AlertDialogModel<bool>{
  LogoutAlertDialog(): 
    super(
      title: 'Logout!', message:'Are you sure you want to logout?',
      buttons: {'Cancel': false, 'Logout': true}
    );
}