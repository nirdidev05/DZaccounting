import 'package:flutter/material.dart';

class ReportsPage extends StatelessWidget {
  final List<String> reports;

  ReportsPage({required this.reports});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports'),
      ),
      body: Center(
        child: DataTable(
          columns: [
            DataColumn(label: Text('Report')),
          ],
          rows: [
            for (String report in reports)
              DataRow(cells: [
                DataCell(Text(report)),
              ]),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: Text('Save'),
              onPressed: () {
                // Save the report and navigate back
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: Text('Cancel'),
              onPressed: () {
                // Navigate back without saving the report
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}