import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

import 'package:optimized_time/app/modules/project/task/task_page.dart';
import 'package:optimized_time/app/view_models/project_model.dart';

import 'controller/task_controller.dart';

class TaskModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        BlocBind.lazySingleton(
          (i) => TaskController(
            projectService: i(),
          ),
        ),
      ];
  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) {
            final ProjectModel projectModel = args.data;
            return TaskPage(
              controller: Modular.get()..setProject(projectModel),
            );
          },
        ),
      ];
}
