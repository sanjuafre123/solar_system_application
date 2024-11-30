import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../modal/modal.dart';


class HomeController extends ChangeNotifier {
  int planetsIndex = 0;
  int bottomIndex = 0;

  HomeController() {
    getData();
    getShareData();
  }

  List<PlanetsModel> favoritePlanetsList = [];

  void changeBottomIndex(int index) {
    bottomIndex = index;
    notifyListeners();
  }

  void changePlanetsIndex(int index) {
    planetsIndex = index;
    notifyListeners();
  }

  List<PlanetsModel> planetsList = [];

  Future<void> getData() async {
    String jsonData = await rootBundle.loadString('assets/json/planet_list.json');
    List json = jsonDecode(jsonData);
    planetsList = json
        .map(
          (e) => PlanetsModel.fromJson(e),
    )
        .toList();
    notifyListeners();
  }

  void addFavoritePlanets() {
    planetsList[planetsIndex].like = !planetsList[planetsIndex].like;
    notifyListeners();
    if (planetsList[planetsIndex].like) {
      favoritePlanetsList.add(planetsList[planetsIndex]);
      notifyListeners();
    } else {
      favoritePlanetsList.remove(planetsList[planetsIndex]);
      notifyListeners();
    }
    setShareData();
    print(favoritePlanetsList.length);
    notifyListeners();
  }

  void removeFavoritePlanets(int index)
  {
    for (int i = 0; i < 9; i++) {
      if(favoritePlanetsList[index].name==planetsList[i].name)
      {
        planetsList[i].like = !planetsList[i].like;
        favoritePlanetsList.removeAt(index);
        notifyListeners();
      }
    }
    setShareData();
    notifyListeners();
  }

  Future<void> setShareData() async {
    SharedPreferences preferencesLike = await SharedPreferences.getInstance();
    for (int i = 0; i < 9; i++) {
      preferencesLike.setBool('like$i', planetsList[i].like);
      notifyListeners();
    }
    notifyListeners();
  }

  Future<void> getShareData() async {
    SharedPreferences preferencesLike = await SharedPreferences.getInstance();
    for (int i = 0; i < 9; i++) {
      planetsList[i].like = preferencesLike.getBool('like$i') ?? false;
      notifyListeners();
      if (planetsList[i].like) {
        favoritePlanetsList.add(planetsList[i]);
        notifyListeners();
      }
    }
    setShareData();
    print(favoritePlanetsList.length);
    notifyListeners();
  }
}