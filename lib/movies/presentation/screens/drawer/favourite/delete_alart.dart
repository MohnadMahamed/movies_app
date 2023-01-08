import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:movies_app/movies/presentation/controllers/auth_controller/cubit/auth_cubit.dart';
import 'package:movies_app/movies/presentation/widgets/cutome_text.dart';

class DeleteAlartWidget extends StatelessWidget {
  final int index;
  const DeleteAlartWidget({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(300.0)),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0), color: Colors.red),
              child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    AuthCubit.get(context).removeFromFavourite(
                        AuthCubit.get(context).userModel.fav[index].id,
                        AuthCubit.get(context).userModel.fav[index].title,
                        AuthCubit.get(context)
                            .userModel
                            .fav[index]
                            .backdropPath);
                  },
                  // AuthCubit.get(context)
                  //     .removeFromFavourite(
                  //         AuthCubit.get(
                  //                 context)
                  //             .userModel
                  //             .fav[index]
                  //             .id,
                  //         AuthCubit.get(
                  //                 context)
                  //             .userModel
                  //             .fav[index]
                  //             .title,
                  //         AuthCubit.get(
                  //                 context)
                  //             .userModel
                  //             .fav[index]
                  //             .backdropPath);,
                  // () {
                  //   Navigator.pop(context);
                  //   // controller.deleteProductById(model.productId!, model);
                  //   // showToast(
                  //   //     text: 'Task deleted successfully',
                  //   //     state: ToastStates.error);
                  // },
                  child: Center(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 4.0,
                        ),
                        const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          height: 2.0,
                        ),
                        CustomeText(
                          text: 'Delete'.tr,
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                      ],
                    ),
                  )),
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.blue),
              child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Center(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 5.0,
                        ),
                        const Icon(
                          Icons.cancel,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          height: 2.0,
                        ),
                        Text('Cancel'.tr,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                            )),
                        const SizedBox(
                          height: 5.0,
                        ),
                      ],
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
