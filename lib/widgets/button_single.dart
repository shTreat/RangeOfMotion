// import 'package:flutter/material.dart';

// class TreatButtonSingle extends StatelessWidget {
//   final String? text;
//   final VoidCallback? onPressed;
//    bool loading;
//   final Color? backgroundColor;
//   final double? width;

//    TreatButtonSingle({
//     Key? key,
//     this.text,
//     this.backgroundColor,
//     this.onPressed,
//     this.width,
//     this.loading = false,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     loading = loading;
//     return SizedBox(
//       width: width ?? double.infinity,
//       height: 56,
//       child: IgnorePointer(
//         ignoring: loading,
//         child: Container(
//           decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Theme.of(context).primaryColorDark,
//                   Theme.of(context).primaryColorLight,

//                   // Color(0xFF38B58C),
//                   // Color(0xFF02756E),
//                 ],
//               ),
//               borderRadius: BorderRadius.circular(7.68),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.1),
//                   spreadRadius: 1,
//                   blurRadius: 10,
//                   offset: Offset(0, 10),
//                 )
//               ]),
//           child: TextButton(
//               onPressed: onPressed,
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     text!,
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   if (loading) ...[
//                     SizedBox(width: 10),
//                     SizedBox(
//                       height: 20.0,
//                       width: 20.0,
//                       child: CircularProgressIndicator(
//                         backgroundColor: Colors.white,
//                       ),
//                     ),
//                   ]
//                 ],
//               )),
//         ),
//       ),
//     );
//   }
// }
