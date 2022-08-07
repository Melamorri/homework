import 'package:flutter/material.dart';

showAlertMessage(BuildContext context, String title, String content) {
  Widget okButton = TextButton(
    child: const Text("OK", style: TextStyle(color: Colors.black87),),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        final curvedValue = Curves.easeInOutBack.transform(a1.value) -   1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0)),
              title: Text(title),
              content: Text(content),
              actions: [
                okButton
              ],
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 500),
      barrierDismissible: true,
      barrierLabel: '',
      context: context, pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return const AlertDialog();
  },
  );
}
