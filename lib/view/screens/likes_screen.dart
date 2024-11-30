import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controller/home_controller.dart';

Column favoriteListPlanets(HomeController homeControllerTrue,
    BuildContext context, HomeController homeControllerFalse) {
  return Column(
    children: List.generate(
      homeControllerTrue.favoritePlanetsList.length,
          (index) => Padding(
        padding: const EdgeInsets.only(right: 20.0, top: 20, left: 10),
        child: SizedBox(
          height: 165,
          child: Stack(
            children: [
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xff161616),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 120,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                          gradient: LinearGradient(
                            colors: [
                              Color(int.parse(homeControllerTrue
                                  .favoritePlanetsList[index].color))
                                  .withOpacity(1),
                              Colors.white,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          image: DecorationImage(
                              image: AssetImage(homeControllerTrue
                                  .favoritePlanetsList[index].image),
                              fit: BoxFit.cover)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            homeControllerTrue.favoritePlanetsList[index].name,
                            style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            height: 5,
                          ),

                          SizedBox(
                            width: 182,
                            child: Text(
                              homeControllerTrue
                                  .favoritePlanetsList[index].description,
                              maxLines: 3,
                              style: GoogleFonts.inter(
                                  fontSize: 12, color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            'By Louise Stark | 12 May 2023',
                            maxLines: 3,
                            style: GoogleFonts.inter(
                                fontSize: 10, color: const Color(0xff787878)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () {
                    homeControllerFalse.removeFavoritePlanets(index);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white),
                      color: Color(int.parse(
                          homeControllerTrue.favoritePlanetsList[index].color)),
                    ),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
