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



@immutable 
class DeletePostAlertDialog extends AlertDialogModel<bool>{
  DeletePostAlertDialog(): super(
    title: 'Delete Post!', message: 'Are you sure you want to delete this post?',
    buttons: {'Cancel': false, 'Delete': true}
  );
}



@immutable 
class DeleteCommentAlertDialog extends AlertDialogModel<bool>{
  DeleteCommentAlertDialog(): super(
    title: 'Delete Comment!', message: 'Are you sure you want to delete this comment',
    buttons: {'Cancel': false, 'Delete': true}
  );
}