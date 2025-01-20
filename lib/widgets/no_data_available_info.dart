import 'package:flutter/material.dart';

class NoDataAvailable extends StatelessWidget {
  const NoDataAvailable({super.key, required this.onRefresh, required this.infoLabel});

  final void Function() onRefresh;
  final String infoLabel;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
        onRefresh: () async {
          onRefresh();
        },
        child: ListView(
          children: [
            SizedBox(height: (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom) * 0.30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  Icon(Icons.error_outline, size: 85, color: Colors.grey),
                  Text(
                    infoLabel,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  Text(
                    "Check back later.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                ],
              ),
            )
          ],
        ),
      );
  }
}