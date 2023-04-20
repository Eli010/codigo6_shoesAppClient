import 'package:flutter/material.dart';
import 'package:shoesclientapp/ui/widgets/common_text.dart';
import 'package:shoesclientapp/utils/assets_data.dart';

class ItemMenuWidget extends StatelessWidget {
  final String text;
  final String icon;
  final VoidCallback onTap;
  const ItemMenuWidget({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: Offset(4, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.10),
                    blurRadius: 12,
                    offset: const Offset(4, 4),
                  ),
                ],
              ),
              child: Image.asset(
                icon,
                height: 36.0,
              ),
            ),
            H5(text: text)
          ],
        ),
      ),
    );
  }
}
