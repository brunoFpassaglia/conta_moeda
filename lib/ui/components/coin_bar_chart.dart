import 'package:charts_flutter/flutter.dart';
import 'package:conta_moeda/models/coin_model.dart';
import 'package:flutter/material.dart';

class CoinBarChart extends StatefulWidget {
  final List<CoinModel> series;
  const CoinBarChart({
    Key? key,
    required this.series,
  }) : super(key: key);

  @override
  _CoinBarChartState createState() => _CoinBarChartState();
}

class _CoinBarChartState extends State<CoinBarChart> {
  @override
  Widget build(BuildContext context) {
    return BarChart(
      _createSeries(),
      animate: true,
      vertical: false,
      barRendererDecorator: new BarLabelDecorator<String>(),
    );
  }

  List<Series<dynamic, String>> _createSeries() {
    return [
      Series<CoinModel, String>(
        id: 'coins',
        data: widget.series,
        domainFn: (CoinModel coin, _) => coin.name,
        measureFn: (CoinModel coin, _) => coin.quantity,
        labelAccessorFn: (CoinModel coin, _) => '${coin.quantity}',
        colorFn: (CoinModel coin, _) => MaterialPalette.green.shadeDefault,
      ),
    ];
  }
}
