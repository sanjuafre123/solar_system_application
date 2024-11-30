
import 'package:bottom_bar_matu/bottom_bar/bottom_bar_bubble.dart';
import 'package:bottom_bar_matu/bottom_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../controller/home_controller.dart';
import 'details_screen.dart';
import 'likes_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 10,
      ),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    HomeController homeControllerTrue = Provider.of<HomeController>(context);
    HomeController homeControllerFalse =
    Provider.of<HomeController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Space',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xff0e0e0e),
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: (homeControllerTrue.bottomIndex == 2)
                    ? favoriteListPlanets(
                    homeControllerTrue, context, homeControllerFalse)
                    : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: [
                        ...List.generate(
                          homeControllerTrue.planetsList.length,
                              (index) {
                            return SizedBox(
                              height: 461,
                              width: 320,
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 20.0),
                                      child: Container(
                                        margin: EdgeInsets.only(left: 30),
                                        height: 350,
                                        width: 260,
                                        alignment: Alignment.bottomCenter,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(int.parse(
                                                  homeControllerTrue
                                                      .planetsList[
                                                  index]
                                                      .color))
                                                  .withOpacity(1),
                                              Colors.white,
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, bottom: 45),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                homeControllerTrue
                                                    .planetsList[index]
                                                    .name,
                                                style: GoogleFonts.inter(
                                                    fontSize: 23,
                                                    fontWeight:
                                                    FontWeight.w700,
                                                    color: Colors.black),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                homeControllerTrue
                                                    .planetsList[index]
                                                    .description,
                                                maxLines: 4,
                                                style: GoogleFonts.inter(
                                                    fontSize: 13,
                                                    color: Colors.black),
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 70,
                                    child: AnimatedBuilder(
                                      animation: animationController,
                                      child: Hero(
                                        tag: 'box',
                                        child: Container(
                                          height: 240,
                                          width: 240,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    homeControllerTrue
                                                        .planetsList[
                                                    index]
                                                        .image),
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                      ),
                                      builder: (context, child) =>
                                          RotationTransition(
                                            turns: animationController,
                                            child: child,
                                          ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 422,
                                    left: 149,
                                    child: GestureDetector(
                                      onTap: () {
                                        homeControllerFalse
                                            .changePlanetsIndex(index);
                                        Navigator.of(context).push(
                                            PageTransition(
                                                duration: const Duration(
                                                    milliseconds: 500),
                                                child:
                                                const DetailsScreen(),
                                                type: PageTransitionType
                                                    .bottomToTop));
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.white),
                                          color: Color(int.parse(
                                              homeControllerTrue
                                                  .planetsList[index]
                                                  .color)),
                                        ),
                                        child: const Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomBarBubble(
        height: 60,
        backgroundColor: const Color(0xff161616),
        color: Colors.white,
        onSelect: (value) {
          homeControllerTrue.changeBottomIndex(value);
        },
        selectedIndex: homeControllerTrue.bottomIndex,
        items: [
          BottomBarItem(
            iconData: Icons.home,
          ),
          BottomBarItem(iconData: Icons.dataset_outlined),
          BottomBarItem(iconData: Icons.favorite_border),
          BottomBarItem(iconData: Icons.person),
        ],
      ),
    );
  }
}
