import 'package:flutter/material.dart';
import 'package:instagram_clone_app/dialogs/generic_dialog.dart';

//Extension for the AlertDialogModel and all classes extending it
extension ShowAlertDialog<T> on AlertDialogModel<T>{
  Future<T?> showAlertDialog(BuildContext context){
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title), content: Text(message),
        actions: buttons.entries.map((entry) => TextButton(
          onPressed: () => Navigator.of(context).pop(entry.value),          
          child: Text(entry.key)
        )).toList()
      )
    );
  }
}