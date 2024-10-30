import 'Purachase_Page.dart';
import 'package:flutter/material.dart';
class VendorPurchaseDetailsPage extends StatelessWidget {
  final Vendor vendor;
  final Purchase purchase;

  VendorPurchaseDetailsPage({required this.vendor, required this.purchase});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vendor Purchase Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child:Column(
          children : [ Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Vendor Details:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8.0),
                        Card(
                          elevation: 2,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Name: ${vendor.name}', style: TextStyle(fontSize: 20,)),
                                SizedBox(height: 10,),
                                Text('Contact Person: ${vendor.contactPerson}', style: TextStyle(fontSize: 20,)),
                                SizedBox(height: 10,),

                                Text('Contact Details: ${vendor.contactDetails}', style: TextStyle(fontSize: 20,)),
                                SizedBox(height: 10,),

                                Text('Address: ${vendor.address}', style: TextStyle(fontSize: 20,)),
                                SizedBox(height: 10,),

                                Text('Products/Services: ${vendor.productsServices}', style: TextStyle(fontSize: 20,)),
                                SizedBox(height: 10,),

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Purchase Details:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8.0),
                        Card(
                          elevation: 2,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Vendor: ${purchase.vendor}', style: TextStyle(fontSize: 20,)),
                                SizedBox(height: 10,),
                                Text('Product Name: ${purchase.productName}', style: TextStyle(fontSize: 20,)),                                SizedBox(height: 10,),

                                Text('Quantity: ${purchase.quantity}', style: TextStyle(fontSize: 20,)),
                                SizedBox(height: 10,),

                                Text('Unit Price: ${purchase.unitPrice}', style: TextStyle(fontSize: 20,)),
                                SizedBox(height: 10,),

                                Text('Total Price: ${purchase.totalPrice}', style: TextStyle(fontSize: 20,)),
                                SizedBox(height: 10,),

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
            SizedBox(height: 50,),
            ElevatedButton(onPressed: (){}, child: Text("Print")),
        ],
      ),
        ),
      ),
    );
  }
}
