import '../widgets/chart_bar.dart';

import '../models/transaction_data_class.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions, {super.key}) {
    print('costructor chart');
  }

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    });
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    print('build() chart');
    return Card(
        elevation: 6,
        margin: const EdgeInsets.all(20),
        child: LayoutBuilder(builder: (context, constraints) {
          return Column(children: [
            SizedBox(
              height: constraints.maxHeight * 0.10,
              // ignore: prefer_const_constructors
              child: FittedBox(
                child: const Text('Last 7 Days Summary',
                    style: TextStyle(
                        fontFamily: 'Opensans',
                        fontWeight: FontWeight.bold,
                        color: Colors.purple)),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.90,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: groupedTransactionValues.map((data) {
                    return Flexible(
                      fit: FlexFit.tight,
                      child: ChartBar(
                        (data['day'] as String),
                        (data['amount'] as double),
                        totalSpending == 0.0
                            ? 0.0
                            : (data['amount'] as double) / totalSpending,
                      ),
                    );
                  }).toList(),
                ),
              ),
            )
          ]);
        }));
  }
}
