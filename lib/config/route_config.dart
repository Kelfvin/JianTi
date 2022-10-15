import 'package:get/get.dart';

import '../pages/subject_page/subject_page_view.dart';
class RouteConfig {
  static const String home = '/';
  static const String sectionPage = '/sectionPage';
  
  static final List<GetPage> getPage = [
    GetPage(name: home,page:() =>const SubjectPageView()),
  ];
}