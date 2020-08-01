import 'package:flutter/material.dart';

import '../../components/general/index.dart';
import '../../services/index.dart';
import '../../components/summary/index.dart';
import '../../utils/constants.dart';
import '../../models/summary.dart';

class FloodSummary extends StatefulWidget {
  @override
  _FloodSummaryState createState() => _FloodSummaryState();
}

class _FloodSummaryState extends State<FloodSummary> {
  Future<Summary> summary;
  SummaryService summaryService = new SummaryService();

  @override
  void initState() {
    super.initState();
    summary = summaryService.fetchSummary();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ScreenDrawer(),
      appBar: AppBar(
        title: Text('Flood Summary'),
        flexibleSpace: BackgroundGradient(),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: FutureBuilder<Summary>(
                future: summary,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: <Widget>[
                        SummaryCard(
                          title: 'Danger Dams',
                          icon: Icon(
                            Icons.priority_high,
                            color: kRed,
                          ),
                          value: snapshot.data.getDanger,
                        ),
                        SummaryCard(
                          title: 'Warning Dams',
                          icon: Icon(
                            Icons.warning,
                            color: kYellow,
                          ),
                          value: snapshot.data.getWarning,
                        ),
                        SummaryCard(
                          title: 'Normal Dams',
                          icon: Icon(
                            Icons.check,
                            color: kGreen,
                          ),
                          value: snapshot.data.getNormal,
                        ),
                        SummaryCard(
                          title: 'Total Dams',
                          icon: Icon(
                            Icons.language,
                            color: kBlue,
                          ),
                          value: snapshot.data.getTotal,
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                }),
          ),
        ),
      ),
    );
  }
}
