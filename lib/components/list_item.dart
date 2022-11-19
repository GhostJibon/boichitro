import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// The base class for the different types of items the list can contain.
abstract class ListItem {
  /// The title line to show in a list item.
  Widget buildTitle(BuildContext context);

  /// The subtitle line, if any, to show in a list item.
  Widget buildSubtitle(BuildContext context);
}

/// A ListItem that contains data to display a heading.
class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);

  @override
  Widget buildTitle(BuildContext context) {
    return Text(
      heading,
      style: Theme.of(context).textTheme.headline5,
    );
  }

  @override
  Widget buildSubtitle(BuildContext context) => const SizedBox.shrink();
}

/// A ListItem that contains data to display a message.
class SettingItem implements ListItem {
  final String title;
  final IconData? leadingIcon;

  SettingItem(this.title, this.leadingIcon);

  @override
  Widget buildTitle(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 65,
        padding: EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          //color: Colors.grey[50],
        ),
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(leadingIcon),
                  SizedBox(width: 10),
                  Text(
                    title,
                    style: TextStyle(
                        // color: Colors.black,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  @override
  Widget buildSubtitle(BuildContext context) => const SizedBox.shrink();
}
