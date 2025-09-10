import 'package:flutter_cinemapedia/presentation/screens/screens.dart';
import 'package:flutter_cinemapedia/presentation/views/views.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    /// Nested Navigation con keepAlive del estado de los views
    StatefulShellRoute.indexedStack(
      builder:
          (context, state, navigationShell) =>
              HomeScreen(childView: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              name: HomeView.name,
              builder: (context, state) => HomeView(),
              routes: [
                GoRoute(
                  path: 'movie/:id',
                  name: MovieDetailScreen.name,
                  builder:
                      (context, state) => MovieDetailScreen(
                        movieId: state.pathParameters['id'] ?? 'no-id',
                      ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/popular',
              name: PopularView.name,
              builder: (context, state) => PopularView(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/favourites',
              name: FavouritesView.name,
              builder: (context, state) => FavouritesView(),
            ),
          ],
        ),
      ],
    ),

    /// Nested Navigation sin keepAlive del estado de los views
    // ShellRoute(
    //   builder: (context, state, child) {
    //     return HomeScreen(childView: child);
    //   },
    //   routes: [
    //     GoRoute(
    //       path: '/',
    //       name: HomeView.name,
    //       builder: (context, state) => HomeView(),
    //       routes: [
    //         GoRoute(
    //           path: 'movie/:id',
    //           name: MovieDetailScreen.name,
    //           builder:
    //               (context, state) => MovieDetailScreen(
    //                 movieId: state.pathParameters['id'] ?? 'no-id',
    //               ),
    //         ),
    //       ],
    //     ),
    //     GoRoute(
    //       path: 'favourite',
    //       name: FavouritesView.name,
    //       builder: (context, state) => FavouritesView(),
    //     ),
    //   ],
    // ),

    // GoRoute(
    //   path: '/',
    //   name: HomeScreen.name,
    //   builder: (context, state) =>  HomeScreen(),
    //   routes: [
    // GoRoute(
    //   path: 'movie/:id',
    //   name: MovieDetailScreen.name,
    //   builder:
    //       (context, state) => MovieDetailScreen(
    //         movieId: state.pathParameters['id'] ?? 'no-id',
    //       ),
    // ),
    //   ],
    // ),
  ],
);
