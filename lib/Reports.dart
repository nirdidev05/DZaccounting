import 'package:flutter/material.dart';

class Reports extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Reports'),

    );
    // Row(
        //           children: [
        //             Container(
        //               height: 400,
        //               width: 800,
        //               padding: EdgeInsets.all(8.0),
        //               margin: EdgeInsets.all(10.0),
        //               decoration: BoxDecoration(
        //                 color: Colors.white60,
        //                 borderRadius: BorderRadius.circular(8.0),
        //               ),
        //               child: Column(
        //                 children: [
        //                   Align(
        //                     alignment: Alignment.centerLeft,
        //                     child: Text(
        //                       'Sales Graph',
        //                       style: TextStyle(
        //                         fontWeight: FontWeight.bold,
        //                         fontSize: 30,
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             SizedBox(
        //               width: 10,
        //             ),
        //             Container(
        //               height: 400,
        //               width: 400,
        //               padding: EdgeInsets.all(8.0),
        //               margin: EdgeInsets.all(10.0),
        //               decoration: BoxDecoration(
        //                 color: Colors.white60,
        //                 borderRadius: BorderRadius.circular(8.0),
        //               ),
        //               child: Column(
        //                 children: [
        //                   Align(
        //                     alignment: Alignment.centerLeft,
        //                     child: Text(
        //                       'The Best Clients',
        //                       style: TextStyle(
        //                         fontWeight: FontWeight.bold,
        //                         fontSize: 30,
        //                       ),
        //                     ),
        //                   ),
        //
        //     SizedBox(height: 10.0),
        //                     Container(
        //                       height: 200,
        //                       width: double.infinity,
        //                       padding: EdgeInsets.all(8.0),
        //                       margin: EdgeInsets.all(10.0),
        //                       decoration: BoxDecoration(
        //                         color: Colors.white60,
        //                         borderRadius: BorderRadius.circular(8.0),
        //                       ),
        //                         child: sales.length >= 3 ? Table(
        //                         columnWidths: {
        //                           0: FlexColumnWidth(1),
        //                           1: FlexColumnWidth(3),
        //                           2: FlexColumnWidth(2),
        //                           3: FlexColumnWidth(2),
        //                         },
        //                         defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        //                         children: [
        //                           TableRow(
        //                             children: [
        //                               TableCell(
        //                                 child: Icon(Icons.star, color: Colors.yellow),
        //                               ),
        //                               TableCell(
        //                                 child: Text(
        //                                   e(sales)[0].client,
        //                                   style: TextStyle(color: Colors.yellow),
        //
        //                                 ),
        //                               ),
        //                               TableCell(
        //                                 child: Text(
        //                                     calculateTotalPrice(e(sales)[0].client,sales).toString(),
        //                                   style: TextStyle(color: Colors.yellow),
        //                                 ),
        //                               ),
        //                               TableCell(
        //                                 child: Text(
        //                                     calculateTotalQuantity(e(sales)[0].client,sales).toString(),
        //                                   style: TextStyle(color: Colors.yellow),
        //
        //                                 ),
        //                               ),
        //                             ],
        //                           ),
        //                           TableRow(
        //                             children: [
        //                               TableCell(
        //                                 child: Icon(Icons.star, color: Colors.grey),
        //                               ),
        //                               TableCell(
        //                                 child: Text(
        //                                   e(sales)[1].client,
        //                                   style: TextStyle(color: Colors.grey),
        //
        //                                 ),
        //                               ),
        //                               TableCell(
        //                                 child: Text(
        //                                   calculateTotalPrice(e(sales)[1].client,sales).toString(),
        //                                   style: TextStyle(color: Colors.grey),
        //                                 ),
        //                               ),
        //                               TableCell(
        //                                 child: Text(
        //                                   calculateTotalQuantity(e(sales)[1].client,sales).toString(),
        //                                   style: TextStyle(color: Colors.grey),                                      ),
        //                               ),
        //                             ],
        //                           ),
        //                           TableRow(
        //                             children: [
        //                               TableCell(
        //                                 child: Icon(Icons.star, color: Color(0xFFCD7F32)),
        //                               ),
        //                               TableCell(
        //                                 child: Text(
        //                                   e(sales)[2].client,
        //                                   style: TextStyle(color:Color(0xFFCD7F32)),                                      ),
        //                               ),
        //                               TableCell(
        //                                 child: Text(
        //                                   calculateTotalPrice(e(sales)[2].client,sales).toString(),
        //                                   style: TextStyle(color:Color(0xFFCD7F32)),
        //                                 ),
        //                               ),
        //                               TableCell(
        //                                 child: Text(
        //                                   calculateTotalQuantity(e(sales)[2].client,sales).toString(),
        //                                   style: TextStyle(color:Color(0xFFCD7F32)),                                      ),
        //                               ),
        //                             ],
        //                           ),
        //                         ],
        //                       ) : Container(),
        //                     ),
        //             ],
        //               ),
        //
        //             ),
        //   ],
        // ),
  }
}