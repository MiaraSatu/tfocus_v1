import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tfocus_v_common_2/dddPublicationScreen.dart';
import 'package:tfocus_v_common_2/Views/explore_screen.dart';
import 'package:tfocus_v_common_2/Views/feed_screen.dart';
import 'package:tfocus_v_common_2/Views/message_screen.dart';
import 'package:tfocus_v_common_2/Views/profil_screen.dart';
import 'package:tfocus_v_common_2/discussionScreen.dart';
import 'package:tfocus_v_common_2/discussionsScreen.dart';
import 'package:tfocus_v_common_2/models/publication.dart';
import 'package:tfocus_v_common_2/profileScreen.dart';
import 'package:tfocus_v_common_2/publicationScreen.dart';
import 'package:tfocus_v_common_2/resultScreen.dart';
import 'main.dart';

GoRouter routes = GoRouter(routes: [
  GoRoute(
      routes: [
        GoRoute(
            path: 'feed',
            builder: (BuildContext context, GoRouterState state) =>
                const FeedScreen()),
        GoRoute(
            // discussions
            path: 'message',
            builder: (BuildContext context, GoRouterState state) =>
                DiscussionsScreen()),
        GoRoute(
            path: 'explore',
            builder: (BuildContext context, GoRouterState state) =>
                const ExploreScreen()),
        GoRoute(
            path: 'profil',
            builder: (BuildContext context, GoRouterState state) => ProfileScreen()),
                //const ProfilScreen()),
        GoRoute(
          path: 'discussion',
          builder: (context, state) => DiscussionScreen(user: state.extra as Map<String, String>)
        ),
        GoRoute(
          path: 'publication',
          builder: (context, state) => PublicationScreen(state.extra as Publication)
          // builder: (context, state) => AddPublicationScreen(state.extra as Publication)
        ),
        GoRoute(
          path: 'createPublication',
          builder: (context, state) => AddPublicationScreen()
        ),
        GoRoute(
          path: 'result',
          builder: (context, state) => ResultScreen(state.extra as String)
        )
        //GoRoute(
        //     path: 'list_by/:url',
        //      builder: (BuildContext context, GoRouterState state) =>
        //         const ListArticleBy(url:url )),
      ],
      path: '/',
      builder: (BuildContext context, GoRouterState state) =>
          const MyHomePage())
]);
