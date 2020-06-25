/*
Copyright 2020 Google LLC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fos_tracker/data_models/status_series.dart';
import 'package:charts_flutter/flutter.dart' as charts;


/// Class that defines features of the complete chart i.e. domain and measure of bar
class StatusChart extends StatelessWidget {
  final List<StatusSeries> data;

  StatusChart({
    @required this.data,
  });

  @override
  Widget build(BuildContext context) {
    List<charts.Series<StatusSeries, String>> series = [
      charts.Series(
        id: "Number of Merchants",
        data: data,
        domainFn: (StatusSeries series, _) => series.status,
        measureFn: (StatusSeries series, _) => series.merchantNumber,
        colorFn: (StatusSeries series, _) => series.color,
      )
    ];
    return charts.BarChart(
      series,
      animate: true,
      animationDuration: Duration(seconds: 2),
    );
  }
}
