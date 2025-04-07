import 'dart:io';

import 'package:encore_shopping_mall/models/item.dart';
import 'package:encore_shopping_mall/providers/item_list_provider.dart';
import 'package:encore_shopping_mall/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class ProductCreatePage extends ConsumerStatefulWidget {
  const ProductCreatePage({super.key});

  @override
  ConsumerState<ProductCreatePage> createState() => _ProductCreatePageState();
}

class _ProductCreatePageState extends ConsumerState<ProductCreatePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  XFile? selectedImage;

  /// 필수 항목 모두 입력되었는지 확인
  bool get isFormValid {
    return //selectedImageUrl != null &&
    nameController.text.trim().isNotEmpty &&
        priceController.text.trim().isNotEmpty &&
        descriptionController.text.trim().isNotEmpty;
  }

  /// 가격 입력값 숫자인지 확인
  bool isNumeric(String str) {
    return int.tryParse(str) != null;
  }

  // 이미지 선택 (Image_picker 사용)
  Future<void> _selectImage() async {
    // 샘플 이미지 URL을 선택한 것으로 처리
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        setState(() {
          selectedImage = pickedFile;
        });
      }
    } catch (e) {
      _showError('이미지 선택 중 오류가 발생했습니다.');
    }
  }

  void _submitForm() {
    if (!isFormValid) {
      _showError('모든 항목을 입력해 주세요.');
      return;
    }

    if (!isNumeric(priceController.text.trim())) {
      _showError('가격은 숫자로만 입력해주세요.');
      return;
    }

    // 상품 목록에 추가
    final item = Item(
      name: nameController.text.trim(),
      price: int.parse(priceController.text.trim()),
      description: descriptionController.text.trim(),
      // 선택한 이미지 추가
      image: selectedImage,
    );
    ref.read(itemListProvider.notifier).addItem(item);
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            content: const Text('등록이 완료되었습니다.'),
            actions: [
              TextButton(
                onPressed: () => context.go(Routes.home),
                child: const Text('확인'),
              ),
            ],
          ),
    );

    // TODO: 상품 저장 로직 추가
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.go(Routes.home)),
        title: const Text('TITLE'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: _selectImage,
                onDoubleTap: null,
                child: Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    border: Border.all(),
                  ),
                  child: Center(
                    child:
                        selectedImage == null
                            ? const Text('Image 선택')
                            : Image.file(File(selectedImage!.path)),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('상품 이름'),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              const SizedBox(height: 16),
              const Text('상품 가격'),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text('원'),
                ],
              ),
              const SizedBox(height: 16),
              const Text('상품 설명'),
              TextField(
                controller: descriptionController,
                maxLines: 5,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('등록하기'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
