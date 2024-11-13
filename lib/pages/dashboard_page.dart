import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:slad_app/auth/auth_service.dart';
import 'package:slad_app/customWidgets/dashboard_item_view.dart';
import 'package:slad_app/models/dashboard_model.dart';
import 'package:slad_app/providers/telescope_provider.dart';

class DashboardPage extends StatefulWidget {
  static const String routeName = '/';

  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    Provider.of<TelescopeProvider>(context, listen: false).getAllBrands();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                AuthService.logout()
                    .then((value) => context.goNamed(DashboardPage.routeName));
              })
        ],
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: dashboardModelList.length,
        itemBuilder: (context, index) {
          final model = dashboardModelList[index];
          return DashboardItemView(
              model: model,
              onPress: (route) {
                context.goNamed(route);
              });
        },
      ),
    );
  }
}
