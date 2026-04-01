import 'package:blog_assignment/domain/entities/auth/user_entity.dart';
import 'package:blog_assignment/presentation/auth/bloc/auth_bloc.dart';
import 'package:blog_assignment/presentation/auth/bloc/auth_bloc_event.dart';
import 'package:blog_assignment/presentation/bookmark/screens/bookmark_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileDrawer extends StatelessWidget {
  const ProfileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    UserEntity? userEntity = context.read<AuthBloc>().getUser;
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: userEntity?.profileUrl != null
                  ? Image.asset(userEntity!.profileUrl!)
                  : Icon(Icons.person, size: 40, color: Colors.blue),
            ),
            accountName: Text(userEntity?.displayName ?? 'no name'),
            accountEmail: Text(userEntity!.email),
            decoration: BoxDecoration(color: Colors.blue),
          ),

          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.bookmark),
            title: const Text("Bookmarks"),
            onTap: () {
              Navigator.pop(context); // Close drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BookmarkScreen()),
              );
            },
          ),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout", style: TextStyle(color: Colors.red)),
            onTap: () {
              context.read<AuthBloc>().add(LogOutEvent());
            },
          ),
        ],
      ),
    );
  }
}
