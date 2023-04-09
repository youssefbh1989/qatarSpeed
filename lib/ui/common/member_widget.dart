import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:qatar_speed/models/user.dart';
import 'package:qatar_speed/ui/chat/chat_list_screen.dart';

import '../../tools/res.dart';
import 'shimmer_bocx.dart';

class MemberWidget extends StatelessWidget {
  const MemberWidget(
      {Key? key,
      required this.member,
      required this.onUserTap,
      this.showPopup = true,
      this.onFollow, required this.showbutton})
      : super(key: key);
  final UserModel member;
  final Function(UserModel? user) onUserTap;
  final bool showPopup;
  final bool showbutton;
  final VoidCallback? onFollow;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: InkWell(
        onTap: () => onUserTap(member),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.transparent),
                padding: const EdgeInsets.all(2.0),
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: member.photo ?? '',
                    fit: BoxFit.cover,
                    placeholder: (context, _) => ShimmerBox(
                      height: Res.isPhone ? 55.0 : 80.0,
                      width: Res.isPhone ? 55.0 : 80.0,
                    ),
                    errorWidget: (_, __, ___) => Container(
                      width: Res.isPhone ? 55.0 : 80.0,
                      height: Res.isPhone ? 55.0 : 80.0,
                      color: Colors.blue,
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                    height: Res.isPhone ? 55.0 : 80.0,
                    width: Res.isPhone ? 55.0 : 80.0,
                  ),
                )),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    member.name ?? '',
                    style: TextStyle(
                        fontFamily: 'arial',
                        fontWeight: FontWeight.w900,
                        fontSize: Res.isPhone ? 14.0 : 18.0),
                  ),
                  Text(member.username ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontFamily: 'arial',
                          fontSize: Res.isPhone ? 12.0 : 15.0)),
                ],
              ),
            ),
            if (showbutton)

            ElevatedButton(
              onPressed: () {
                onUserTap(member);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // <-- Radius
                ),
              ),
              child: const Text('Unblock',style: TextStyle(color: Colors.white)),
            ),
            if (showPopup)
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: PopupMenuButton(
                    itemBuilder: (BuildContext context) => [
                          PopupMenuItem(
                              child: _menuItem(
                                  context,
                                onTap: onFollow!,
                                  text:
                                      '${member.following ? 'Unfollow' : 'Follow'} ',
                                  icon: 'ic_follow_me.svg')),
                          PopupMenuItem(
                              child: _menuItem(
                                  context,
                                onTap: () => Get.to(() => ChatListScreen(user: member)),
                                  text: 'Message me',
                                  icon: 'ic_message_me.svg')),
                          /*PopupMenuItem(
                              child: _menuItem(
                                  text: 'Search mu posts',
                                  icon: 'ic_search_posts.svg')),
                          PopupMenuItem(
                              child: _menuItem(
                                  text: 'WhatsApp me', icon: 'ic_wa_me.svg')),*/
                        ],
                    child: SvgPicture.asset(
                      'assets/ic_add_list.svg',
                      width: Res.isPhone ? 30.0 : 35.0,
                      fit: BoxFit.cover,
                    )),
              ),

          ],
        ),
      ),
    );
  }

  Widget _menuItem(BuildContext context,
      {required String text,
      required String icon,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/$icon'),
          SizedBox(
            width: Res.isPhone ? 5.0 : 10.0,
          ),
          Text(
            text,
            style: TextStyle(
                fontFamily: 'arial', fontSize: Res.isPhone ? 15.0 : 18.0),
          ),
          const SizedBox(
            width: 20.0,
          )
        ],
      ),
    );
  }
}
