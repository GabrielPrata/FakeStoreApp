import 'dart:async';
import 'package:fake_store_app/Presentation/style/app_theme.dart';
import 'package:smart_snackbars/smart_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/quickalert.dart';

// VibrationController vibrationController = Get.put(VibrationController());
// CollectController collController = Get.put(CollectController());

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
      // Optionally handle the case where no overlay is found
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
      // Optionally handle the case where no overlay is found
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
      // Optionally handle the case where no overlay is found
      print("No overlay found in current context.");
    }
  }

  // static showAlertLogoutDialog(BuildContext context) {
  //   AlertDialog alert = AlertDialog(
  //     title: Text("Você realmente deseja sair do app?",
  //         style: GoogleFonts.montserrat(
  //             fontWeight: FontWeight.w600, fontSize: 23)),
  //     actions: [
  //       TextButton(
  //           onPressed: () async => await AuthController.logout(),
  //           child: Text("Sair",
  //               style: GoogleFonts.montserrat(
  //                   fontWeight: FontWeight.w600, fontSize: 19))),
  //       TextButton(
  //           onPressed: () => Get.back(),
  //           child: Text("Voltar",
  //               style: GoogleFonts.montserrat(
  //                   fontWeight: FontWeight.w600, fontSize: 19)))
  //     ],
  //   );
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return alert;
  //       });
  // }

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

  // static showAlertConfirmDialogMusic(
  //     BuildContext context, MusicAdapter track, Function action) {
  //   AlertDialog alert = AlertDialog(
  //     backgroundColor: Colors.grey.shade300,
  //     title: Text(
  //       "Você realmente deseja adicionar essa música?",
  //       style: Theme.of(context)
  //           .textTheme
  //           .labelSmall
  //           ?.copyWith(color: Colors.black, fontSize: 20),
  //       textAlign: TextAlign.center,
  //     ),
  //     content: SingleChildScrollView(
  //       // Usando SingleChildScrollView para evitar overflow
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min, // Para manter o conteúdo compacto
  //         children: [
  //           if (track.imageUrl != null) // Mostrar a imagem se disponível
  //             Image.network(
  //               track.imageUrl!,
  //               width: 120,
  //               height: 120,
  //               fit: BoxFit.cover,
  //             ),
  //           SizedBox(
  //             height: 10,
  //           ),
  //           Text(
  //             track.musicName, // Nome da música
  //             textAlign: TextAlign.center,
  //             style: Theme.of(context).textTheme.bodyMedium?.copyWith(
  //                 color: Colors.black,
  //                 fontWeight: FontWeight.w600,
  //                 fontSize: 20),
  //           ),
  //           if (track.albumName !=
  //               null) // Mostrar o nome do álbum se disponível
  //             Padding(
  //               padding: const EdgeInsets.only(top: 2.0),
  //               child: Text(
  //                 "Álbum: ${track.albumName}",
  //                 textAlign: TextAlign.center,
  //                 style: Theme.of(context).textTheme.bodySmall?.copyWith(
  //                       color: Colors.grey.shade700,
  //                       fontSize: 16,
  //                     ),
  //               ),
  //             ),
  //           Padding(
  //             padding: const EdgeInsets.only(top: 2.0),
  //             child: Text(
  //               "Artistas: ${track.convertArtistListoToString()}", // Lista de artistas
  //               textAlign: TextAlign.center,
  //               style: Theme.of(context)
  //                   .textTheme
  //                   .bodySmall
  //                   ?.copyWith(color: Colors.grey.shade700, fontSize: 16),
  //             ),
  //           ),
  //           SizedBox(
  //             height: 10,
  //           )
  //         ],
  //       ),
  //     ),
  //     actions: [
  //       ElevatedButton(
  //         style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade500),
  //         onPressed: () => Get.back(),
  //         child: Row(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Icon(
  //               Icons.close,
  //               color: Colors.white,
  //             ),
  //             SizedBox(
  //               height: 20,
  //             ),
  //             Text(
  //               "Não",
  //               style: Theme.of(context).textTheme.labelMedium?.copyWith(
  //                     color: Colors.white,
  //                     fontSize: 16,
  //                   ),
  //             ),
  //           ],
  //         ),
  //       ),
  //       SizedBox(
  //         height: 5,
  //       ),
  //       ElevatedButton(
  //         onPressed: () => action(),
  //         child: Row(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Icon(
  //               Icons.check,
  //               color: Colors.white,
  //             ),
  //             SizedBox(
  //               height: 20,
  //             ),
  //             Text(
  //               "Sim!",
  //               style: Theme.of(context).textTheme.labelMedium?.copyWith(
  //                     color: Colors.white,
  //                     fontSize: 16,
  //                   ),
  //             ),
  //           ],
  //         ),
  //         style:
  //             ElevatedButton.styleFrom(backgroundColor: Colors.green.shade500),
  //       )
  //     ],
  //   );

  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return alert;
  //       });
  // }

  // static Widget boxLoading(BuildContext context, String title) {
  //   return Container(
  //       decoration: BoxDecoration(
  //           color: AppColors.colorPrimary.withOpacity(0.8),
  //           borderRadius: BorderRadius.circular(15)),
  //       width: MediaQuery.of(context).size.width * 0.8,
  //       height: 200,
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           SizedBox(
  //               width: MediaQuery.of(context).size.width * 0.5,
  //               child: const LinearProgressIndicator(minHeight: 6,)),
  //           Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Text(
  //               title,
  //               style: GoogleFonts.passionOne(
  //                   color: Colors.white,
  //                   fontWeight: FontWeight.w600,
  //                   fontSize: 27),
  //             ),
  //           )
  //         ],
  //       ));
  // }

  // static Future<dynamic> quickSuccessAlert2(BuildContext context, String message) {
  //   return QuickAlert.show(
  //     context: context,
  //     type: QuickAlertType.success,
  //     onConfirmBtnTap: () => Get.to(HomePage()),
  //     showCancelBtn: true,
  //     confirmBtnText: 'OK',
  //     text: message,
  //   );
  // }

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
