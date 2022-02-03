import 'package:flutter/material.dart';
import 'package:foocafe_flutter_firebase_chat/helpers/app_constants.dart';
import 'package:foocafe_flutter_firebase_chat/models/app_user.dart';
import 'package:foocafe_flutter_firebase_chat/models/user_data.dart';
import 'package:foocafe_flutter_firebase_chat/screens/edit_profile_screen.dart';
import 'package:foocafe_flutter_firebase_chat/services/database_service.dart';
import 'package:provider/provider.dart';

import 'user_profile_image.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  _buildActivity(BuildContext context, String userId) {
    return FutureBuilder(
        future:
            Provider.of<DatabaseService>(context, listen: true).getUser(userId),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox.shrink();
          }
          AppUser user = snapshot.data;
          return DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                profileImage(user, avatarRadius: 30),
                Text(
                  user.name!,
                  style: const TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  user.bio!,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  tooltip: 'Edit Profile',
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditProfileScreen(
                        user: user,
                      ),
                    ),
                  ),
                  color:
                      AppConstants.hexToColor(AppConstants.APP_PRIMARY_COLOR),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    String? currentUserId = Provider.of<UserData>(context).currentUserId;
    return Drawer(
      child: Column(children: [
        Expanded(
          flex: 1,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            child: currentUserId!.isNotEmpty
                ? _buildActivity(context, currentUserId)
                : const SizedBox.shrink(),
          ),
        ),
        Expanded(
          flex: 2,
          child: ListView(children: [
            ListTile(
              leading: Icon(
                Icons.home,
                color: AppConstants.hexToColor(AppConstants.APP_PRIMARY_COLOR),
              ),
              title: const Text('Home'),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: Icon(
                Icons.people,
                color: AppConstants.hexToColor(AppConstants.APP_PRIMARY_COLOR),
              ),
              title: const Text('Attendants'),
              onTap: () {},
            ),
            const Spacer(flex: 8),
          ]),
        ),
      ]),
    );
  }
}
