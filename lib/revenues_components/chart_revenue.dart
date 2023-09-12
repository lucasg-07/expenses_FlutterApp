import 'package:expenses/models/revenue.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:intl/date_symbol_data_local.dart';

import '../transactions_components/chart_bar.dart';

class RevenueChart extends StatelessWidget {
  final List<Revenue> recentRevenue;

  const RevenueChart(this.recentRevenue, {Key? key}) : super(key: key);

  List<Map<String, Object>> get groupedRevenues {
    initializeDateFormatting('pt_BR', null);
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSum = 0.0;

      for (var i = 0; i < recentRevenue.length; i++) {
        bool sameDay = recentRevenue[i].date.day == weekDay.day;
        bool sameMonth = recentRevenue[i].date.month == weekDay.month;
        bool sameYear = recentRevenue[i].date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += recentRevenue[i].value;
        }
      }

      final dayOfWeek = DateFormat('EEEE', 'pt_BR')
          .format(weekDay)
          .substring(0, 1)
          .toUpperCase();

      return {
        'day': dayOfWeek,
        'value': totalSum,
      };
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedRevenues.fold(0.0, (sum, re) {
      return sum + (re['value'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedRevenues.map((re) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: re['day'] as String,
                value: re['value'] as double,
                percentage: _weekTotalValue == 0
                    ? 0
                    : (re['value'] as double) / _weekTotalValue,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
