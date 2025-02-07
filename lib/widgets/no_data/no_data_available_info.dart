import 'package:flutter/material.dart';
import 'package:race_room/utils/colors/app_colors.dart';

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
            SizedBox(height: (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom) * 0.290),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.info_outline, size: 80, color: AppColors.noDataAvailableIcon),
                  const SizedBox(height: 8),
                  Text(
                    infoLabel,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.noDataAvailableText, fontSize: 14),
                  ),
                  Text(
                    "Please check back later.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.noDataAvailableText, fontSize: 14),
                  ),
                ],
              ),
            )
          ],
        ),
      );
  }
}