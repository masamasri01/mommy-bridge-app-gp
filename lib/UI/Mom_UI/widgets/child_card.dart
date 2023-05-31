import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

import 'package:gp/Router/app_router.dart';
import 'package:gp/UI/Mom_UI/widgets/timeline.dart';

class ChildCard extends StatelessWidget {
  final Uint8List? img;
  final Color color;
  final String? heading;
  final String description;
  final Color color1;
  final VoidCallback onPressed;

  ChildCard(
      {Key? key,
      required this.img,
      required this.color,
      required this.heading,
      required this.description,
      required this.color1,
      this.onPressed = f})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
      child: Container(
        width: 500,
        height: 500,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[Color(0xFF9599a2), Color(0xFF4F5D75)],
          ),
          shape: BoxShape.rectangle,
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(119, 49, 56, 24),
                offset: Offset(0, 1),
                blurRadius: 1.0),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 150,
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.0),
                      // color: kcp1,
                      image: (img == Uint8List.fromList(([0, 0]).cast<int>()))
                          ? const DecorationImage(
                              image:
                                  AssetImage('lib/core/images/placeholder.png'),
                              fit: BoxFit.contain)
                          : DecorationImage(
                              image: MemoryImage(img!, scale: 10),
                              fit: BoxFit.contain)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                heading ?? "",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 20, color: color1, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                description,
                style: TextStyle(
                    fontFamily: 'SF Pro Rounded', fontSize: 15, color: color1),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: TextButton.icon(
                  onPressed: onPressed,
                  icon: const Icon(Icons.arrow_back_rounded),
                  label: Text(
                    'checkout'.tr(),
                    style: TextStyle(color: color),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(color1),
                    overlayColor: MaterialStateProperty.all<Color>(
                        color.withOpacity(0.3)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )),
                  )),
            ),
            const SizedBox(
              height: 8,
            )
          ],
        ),
      ),
    );
  }
}

f() {
  AppRouter.appRouter.goToWidget(TimelineComponent());
}
