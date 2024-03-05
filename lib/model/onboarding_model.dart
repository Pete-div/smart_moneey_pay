
class OnboardingModel {
  String img;
  String Topic;
  String subTopic;
  OnboardingModel({
    required this.img,
    required this.Topic,
    required this.subTopic,
  });
}

List<OnboardingModel> onBoard = [
  OnboardingModel(
    img: "assets/onboarding_1.png",
    Topic: "Finance app the safest \nand most trusted",
    subTopic:
        "Your finance work starts here. Our here to help \nyou track and deal with speeding up your \ntransactions.",
  ),
  OnboardingModel(
    img: "assets/onboarding_2.png",
    Topic: "The fastest transaction \nprocess only here",
    subTopic:
        "Get easy to pay all your bills with just a few \nsteps. Paying your bills become fast and \nefficient.",
  ),

];