import 'dart:io';

import 'package:blog_app/core/theme/palette.dart';
import 'package:blog_app/core/utils/pick_image.dart';
import 'package:blog_app/core/widgets/gap.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddNewBlogScreen extends StatefulWidget {
  static const routeName = 'Add-New-Blog-Page';
  const AddNewBlogScreen({super.key});

  @override
  State<AddNewBlogScreen> createState() => _AddNewBlogScreenState();
}

class _AddNewBlogScreenState extends State<AddNewBlogScreen> {
  @override
  Widget build(BuildContext context) {
    final titlteController = TextEditingController();
    final contentController = TextEditingController();
    List<String> selectedChips = [];
    File? image;

    void selectedImage() async {
      final pickedImg = await pickImage(ImageSource.gallery);
      if (pickedImg != null) {
        setState(() {
          image = pickedImg;
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        actions: const [Icon(Icons.done_rounded)],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              image != null
                  ? GestureDetector(
                      onTap: selectedImage,
                      child: SizedBox(
                          height: 150,
                          width: double.infinity,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(image!))),
                    )
                  : GestureDetector(
                      onTap: selectedImage,
                      child: DottedBorder(
                        color: AppPallete.borderColor,
                        dashPattern: [10, 4],
                        radius: Radius.circular(10),
                        borderType: BorderType.RRect,
                        strokeCap: StrokeCap.round,
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.folder_open,
                                size: 40,
                              ),
                              const Text("Select your image"),
                            ],
                          ),
                        ),
                      ),
                    ),
              const Gap(axis: 'x', width: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      ['Technology', 'Programming', 'Business', 'Entertainment']
                          .map(
                            (e) => GestureDetector(
                              onTap: () {
                                if (selectedChips.contains(e)) {
                                  selectedChips.remove(e);
                                }
                                selectedChips.add(e);
                                setState(() {});
                              },
                              child: Chip(
                                label: Text(e),
                                color: selectedChips.contains(e)
                                    ? MaterialStateProperty.all(
                                        AppPallete.gradient1)
                                    : null,
                                side: selectedChips.contains(e)
                                    ? null
                                    : const BorderSide(
                                        color: AppPallete.borderColor),
                              ),
                            ),
                          )
                          .toList(),
                ),
              ),
              const Gap(
                axis: 'x',
                height: 10,
              ),
              BlogEditor(controller: titlteController, hintText: 'Blog title'),
              const Gap(
                axis: 'x',
                height: 10,
              ),
              BlogEditor(
                  controller: contentController, hintText: 'Blog Content')
            ],
          ),
        ),
      ),
    );
  }
}
