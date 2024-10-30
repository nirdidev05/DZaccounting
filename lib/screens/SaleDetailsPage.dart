import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Classes/Cale.dart';
import 'Sales_page.dart';

class SaleDetailsPage extends StatelessWidget {
  final Cale sale;

  SaleDetailsPage({required this.sale});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sale Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              child: ListTile(
                title: Text('Product Name'),
                subtitle: Text(sale.product_name),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Date'),
                subtitle: Text('${DateFormat('yyyy-MM-dd').format(sale.creationDate)}'),
              ),
            ),


            Card(
              child: ListTile(
                title: Text('Client Name'),
                subtitle: Text(sale.client_name),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Quantity'),
                subtitle: Text(sale.quantity.toString()),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Unity Price'),
                subtitle: Text(sale.unityprice.toString()),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Reduction'),
                subtitle: Text(sale.reductionAmount.toString()),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Price'),
                subtitle: Text(sale.price.toString()),
              ),
            ),

            Card(
              child: ListTile(
                title: Text('The Case'),
                subtitle: Text(sale.cas),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
              },
              child: Text('Print'),
            ),
          ],
        ),
      ),
    );
  }
}
