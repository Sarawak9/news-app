import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/inner_screens/bookmarks_screen.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import 'vertical_spacing.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final Color textColor = Theme.of(context).textTheme.bodyLarge!.color!;

    return Drawer(
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Image.asset(
                      'assets/images/newspaper.png',
                      height: 60,
                      width: 60,
                    ),
                  ),
                  const VerticalSpacing(20),
                  Flexible(
                    child: Text(
                      'News app',
                      style: GoogleFonts.lobster(
                        textStyle: TextStyle(
                          fontSize: 20,
                          letterSpacing: 0.6,
                          color: textColor, // Use theme-based color
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const VerticalSpacing(20),
            ListTilesWidget(
              label: "Home",
              icon: IconlyBold.home,
              fct: () {
                Navigator.pushReplacement(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: const HomeScreen(),
                    inheritTheme: true,
                    ctx: context,
                  ),
                );
              },
            ),
            ListTilesWidget(
              label: "Bookmark",
              icon: IconlyBold.bookmark,
              fct: () {
                Navigator.pushReplacement(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: const BookmarkScreen(),
                    inheritTheme: true,
                    ctx: context,
                  ),
                );
              },
            ),
            const Divider(
              thickness: 5,
            ),
            SwitchListTile(
              title: Text(
                themeProvider.getDarkTheme ? 'Dark' : 'Light',
                style: TextStyle(
                    fontSize: 20, color: textColor), // Adjust text color
              ),
              secondary: Icon(
                themeProvider.getDarkTheme ? Icons.dark_mode : Icons.light_mode,
                color: Theme.of(context).colorScheme.secondary,
              ),
              value: themeProvider.getDarkTheme,
              onChanged: (bool value) {
                setState(() {
                  themeProvider.setDarkTheme = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ListTilesWidget extends StatelessWidget {
  const ListTilesWidget({
    Key? key,
    required this.label,
    required this.fct,
    required this.icon,
  }) : super(key: key);

  final String label;
  final Function fct;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final Color textColor = Theme.of(context).textTheme.bodyLarge!.color!;
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.secondary,
      ),
      title: Text(
        label,
        style: TextStyle(
            fontSize: 20, color: textColor), // Dynamically set text color
      ),
      onTap: () {
        fct();
      },
    );
  }
}
