List<String> listOfimagepath = [
  'assets/images/onBoard1.png',
  'assets/images/onBoard2.png',
  'assets/images/onBoard3.png',
  'assets/images/onBoard4.png',
  'assets/images/onBoard5.png',
];

List<String> listOfTitle = [
  ' ',
  'Welcome To Islami',
  'Reading the Quran',
  'Bearish',
  'Holy Quran Radio',
];
List<String> listOfDescribtion = [
  'Welcome To Islmi App',
  'We Are Very Excited To Have You In Our Community',
  'Read, and your Lord is the Most Generous',
  'Praise the name of your Lord, the Most High',
  'You can listen to the Holy Quran Radio through the application for free and easily',
];
class OnBoardingModel {

  String imagepath;
  String Title;
  String Describtion;

  OnBoardingModel({
    required this.imagepath,
    required this.Title,
    required this.Describtion,
  });

  static List<OnBoardingModel> getAllOnBoarding() {
    List<OnBoardingModel> listOfONBoard = [];
    for (int i = 0; i < listOfimagepath.length; i++) {
      listOfONBoard.add(
        OnBoardingModel(

          imagepath: listOfimagepath[i],
          Title: listOfTitle[i],
          Describtion: listOfDescribtion[i],
        ),
      );
    }
    return listOfONBoard;
  }
}