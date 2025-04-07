import 'dart:async';
import 'package:fake_store_app/Presentation/style/app_theme.dart';
import 'package:smart_snackbars/smart_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/quickalert.dart';


class Alerts {
  static showErrorSnackBar(String message, BuildContext context) {
    final overlay = Overlay.of(context);
    if (overlay != null) {
      showTopSnackBar(
        overlay,
        CustomSnackBar.error(
          maxLines: 7,
          message: message,
        ),
      );
    } else {
      print("No overlay found in current context.");
    }
  }

  static showSuccessSnackBar(String message, BuildContext context) {
    final overlay = Overlay.of(context);
    if (overlay != null) {
      showTopSnackBar(
        overlay,
        CustomSnackBar.success(
          message: message,
        ),
      );
    } else {
      print("No overlay found in current context.");
    }
  }

  static showInfonackBar(String message, BuildContext context) {
    final overlay = Overlay.of(context);
    if (overlay != null) {
      showTopSnackBar(
        overlay,
        CustomSnackBar.info(
          message: message,
        ),
      );
    } else {
      print("No overlay found in current context.");
    }
  }

  static showAlertConfirmDialog(
      BuildContext context, String data, Function action) {
    AlertDialog alert = AlertDialog(
      title: Text(data,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 22)),
      actions: [
        ElevatedButton(
            style:
                ElevatedButton.styleFrom(backgroundColor: Colors.red.shade500),
            onPressed: () => Get.back(),
            child: Icon(
              Icons.close,
              color: Colors.white,
            )),
        ElevatedButton(
          onPressed: () => action.call(),
          child: Icon(
            Icons.check,
            color: Colors.white,
          ),
          style:
              ElevatedButton.styleFrom(backgroundColor: Colors.green.shade500),
        )
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  static Future<dynamic> quickSuccessAlert(
      BuildContext context, String message) {
    return QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      confirmBtnText: 'OK',
      text: message,
    );
  }

  static Future<dynamic> quickWarningAlert(
      BuildContext context, String message) {
    return QuickAlert.show(
      context: context,
      type: QuickAlertType.warning,
      confirmBtnText: 'OK',
      text: message,
    );
  }

  static Future<dynamic> quickErrorAlert(BuildContext context, String message) {
    return QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      confirmBtnText: 'OK',
      text: message,
    );
  }

  static Widget messageTextAlert(
      BuildContext context, String message, Color boxColor,
      {double? sizeWidth, double? sizeHeight, Color? textColor}) {
    return Container(
      decoration: BoxDecoration(
          color: boxColor, borderRadius: BorderRadius.circular(12)),
      width: sizeWidth ?? MediaQuery.of(context).size.width * 0.93,
      height: sizeHeight ?? 53,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8.0),
        child: Center(
          child: Text(
            message,
            style: GoogleFonts.montserrat(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: textColor ?? Colors.black),
          ),
        ),
      ),
    );
  }

  //Smart snack bars
  static smartSuccessSnackBar(String message, BuildContext context,
      {Color? color}) {
    return SmartSnackBars.showTemplatedSnackbar(
      context: context,
      elevation: 20,
      title: '$message',
      titleStyle: GoogleFonts.montserrat(
          fontWeight: FontWeight.w500, color: color ?? Colors.white),
      backgroundColor: AppTheme.successGreen,
      trailing: Icon(
        Icons.check,
        color: Colors.white,
        size: 25,
      ),
    );
  }

  static smartErrorSnackBar(String message, BuildContext context, 
      {Color? color}) {
    return SmartSnackBars.showTemplatedSnackbar(
      context: context,
      elevation: 20,
      title: '$message',
      titleStyle: GoogleFonts.montserrat(
          fontWeight: FontWeight.w500, color: color ?? Colors.white),
      backgroundColor: AppTheme.errorColor,
      trailing: Icon(
        Icons.close,
        color: Colors.white,
        size: 25,
      ),
    );
  }

  static smartWarningSnackBar(String message, BuildContext context, 
      {Color? color}) {
    return SmartSnackBars.showTemplatedSnackbar(
      context: context,
      elevation: 20,
      title: '$message',
      titleStyle: GoogleFonts.montserrat(
          fontWeight: FontWeight.w500, color: color ?? Colors.black),
      backgroundColor: AppTheme.yellowWarning,
      trailing: Icon(
        Icons.warning_rounded,
        color: Colors.black,
        size: 25,
      ),
    );
  }
}
