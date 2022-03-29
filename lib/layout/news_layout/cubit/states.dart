abstract class NewsStates{}

class NewsInitialStates extends NewsStates{}

 //// bottomNavBarTap

class NewsBottomNavBarTapStates extends NewsStates{}

///// get Business
class NewsGetBusinessLoadingState extends NewsStates{}

class NewsGetBusinessSuccessState extends NewsStates{}

class NewsGetBusinessErrorState extends NewsStates{
  final String error;
  NewsGetBusinessErrorState(this.error);
}

///// get science

class NewsGetScienceLoadingState extends NewsStates{}

class NewsGetScienceSuccessState extends NewsStates{}

class NewsGetScienceErrorState extends NewsStates{
  final String error;
  NewsGetScienceErrorState(this.error);
}

///get sports


class NewsGetSportsLoadingState extends NewsStates{}

class NewsGetSportsSuccessState extends NewsStates{}

class NewsGetSportsErrorState extends NewsStates{
  final String error;
  NewsGetSportsErrorState(this.error);
}

/////search


class NewsGetSearchLoadingState extends NewsStates{}

class NewsGetSearchSuccessState extends NewsStates{}

class NewsGetSearchErrorState extends NewsStates{
  final String error;
  NewsGetSearchErrorState(this.error);
}

