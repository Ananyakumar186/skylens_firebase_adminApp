import 'package:flutter/material.dart';
import 'package:slad_app/pages/add_telescope_page.dart';

import '../pages/brand_page.dart';
import '../pages/view_telescope_page.dart';

class DashboardModel {
  final String title;
  final IconData iconData;
  final String routeName;

  const DashboardModel(
      {required this.title, required this.iconData, required this.routeName});
}

const List<DashboardModel> dashboardModelList = [
  DashboardModel(title: 'Add Telescope', iconData: Icons.add, routeName: AddTelescopePage.routeName),
  DashboardModel(title: 'View Telescope', iconData: Icons.inventory, routeName: ViewTelescopePage.routeName),
  DashboardModel(title: 'Brands', iconData: Icons.category, routeName: BrandPage.routeName)
];
