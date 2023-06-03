import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:farmer_app/ui/shimmer_effect/shimmerWidget.dart';
import 'package:flutter/material.dart';
import '../../../constants/exports.dart';

class UpdateProfileInfoScreen extends GetView<UpdateProfileInfoController> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: customAppBar(
              hideLeading: sizedBox(width: 0.0),
              title: profileInfoStr.tr,
            ),
            body:
            GetBuilder<UpdateProfileInfoController>(
              init: UpdateProfileInfoController(),
              builder: (_) {
                return controller.isLoadingData.value?loader():FutureBuilder(
                    future: controller.future,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return SingleChildScrollView(
                              child: setPaddingAll(
                                  margin: margin_20,
                                  widget: Column(
                                    children: [
                                      sizedBox(height: height_30),
                                      _userImage(),
                                      sizedBox(height: height_10),
                                      _form(),
                                      sizedBox(height: height_30),
                                      _continueButton(),
                                    ],
                                  )));
                        } else if (snapshot.hasError) {
                          return noDataAvailable(title: controller.errorMessage.value);
                        } else {
                          return _profileUpdateShimmerWidget();
                        }
                      } else {
                        return _profileUpdateShimmerWidget();
                      }
                    });
              },
            )));
  }

  _userImage() {
    return GetBuilder<UpdateProfileInfoController>(
        id: "image",
        builder: (controller) {
          return getInkWell(
            ontap: () {
              _pickImageDialog();
            },
            widget: Stack(
              children: [
                ClipRRect(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    borderRadius: BorderRadius.circular(radius_50),
                    child:controller.pickedImage != null
                        ? fileImage(image:File(controller.pickedImage!.path),
                      height: 100.0,
                      width: 100.0,
                    ):networkImages("$image_url${controller.profileData!.mediaUrl}${controller.profileData!.data!.avatar}"),
                    ),
                Positioned(
                  bottom: 5,
                  right: 0,
                  child:
                      assetImage(image: ic_camera, height: 30.0, width: 30.0),
                )
              ],
            ),
          );
        });
  }

  _pickImageDialog() {
    return commonDialogs(
        titleText: pickImageStr.tr,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getInkWell(
              ontap: () {
                controller.pickImageCamera();
                Get.back();
              },
              widget: Row(
                children: [
                  const Icon(
                    Icons.camera_alt_outlined,
                    color: primaryColor,
                  ),
                  sizedBox(width: width_10),
                  text(cameraStr.tr, color: subtitleColor),
                ],
              ),
            ),
            sizedBox(height: height_10),
            Divider(
              color: borderColor,
            ),
            getInkWell(
              ontap: () {
                controller.pickImageGallery();
                Get.back();
              },
              widget: Row(
                children: [
                  const Icon(
                    Icons.image_outlined,
                    color: primaryColor,
                  ),
                  sizedBox(width: width_10),
                  text(galleryStr.tr, color: subtitleColor),
                ],
              ),
            )
          ],
        ),
        onConfirmClick: () {});
  }

  _form() {
    return Form(
        key: controller.formKey,
        child: Column(
          children: [
            _applicantTypeEditText(),
            sizedBox(height: height_20),
            _nameEditText(),
            sizedBox(height: height_20),
            _fatherNameEditText(),
            sizedBox(height: height_20),
            _genderEditText(),
            sizedBox(height: height_20),
            _residentEditText(),
            sizedBox(height: height_20),
            _aadhaarCardEditText(),
            sizedBox(height: height_20),
            _phoneNoEditText(),
            sizedBox(height: height_20),
            _casteEditText(),
          ],
        ));
  }

  _applicantTypeEditText() {
    return CommonTextField(
      controller: controller.applicantTypeController,
      readOnly: true,
      validation: (value) {
        if (value == null || value.isEmpty) {
          return pleaseSelectItemStr.tr;
        }
        return null;
      },
      onChanged: (value) {
        controller.applicantTypeController.text = value;
      },
      inputActions: TextInputAction.next,
      labelText: applicantStr.tr,
      suffix: _applicantDropDown(),
    );
  }

  _applicantDropDown() {
    return DropdownSearch<dynamic>(
        popupProps: PopupProps.menu(
          fit: FlexFit.loose,
          showSelectedItems: false,

        ),

        items: controller.applicantName,
        dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle:  GoogleFonts.roboto(
              textStyle:TextStyle(color: paragraphColor,fontSize: font_16,fontWeight: FontWeight.w400),),
            dropdownSearchDecoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(horizontal: margin_20, vertical: margin_10),
          border: InputBorder.none,
        )),
        onChanged: (value) {
          controller.applicantType(value);
          var index = controller.applicantName.indexOf(value);
          controller.selectAppicateTypeIdFun(controller.applicantId[index]);

          print("select value${controller.selectAppicantTypeId} ");
        },
        selectedItem: controller.applicantTypeController.text);
  }

  _nameEditText() {
    return CommonTextField(
      controller: controller.applicantNameController,
      labelText: applicantNameStr.tr,
      inputActions: TextInputAction.next,
      validation: (value) {
        if (value == null || value.isEmpty) {
          return pleaseFillFieldStr.tr;
        }
        return null;
      },
    );
  }

  _fatherNameEditText() {
    return CommonTextField(
      controller: controller.applicantFatherNameController,
      labelText: applicantFatherNameStr.tr,
      inputActions: TextInputAction.next,
      validation: (value) {
        if (value == null || value.isEmpty) {
          return pleaseFillFieldStr.tr;
        }
        return null;
      },
    );
  }

  _genderEditText() {
    return CommonTextField(
      controller: controller.genderController,
      labelText: genderStr.tr,
      readOnly: true,
      validation: (value) {
        if (value == null || value.isEmpty) {
          return pleaseSelectItemStr.tr;
        }
        return null;
      },
      suffix: _genderPopup(),
      inputActions: TextInputAction.next,
    );
  }

  _genderPopup() {
    return DropdownSearch<dynamic>(
        popupProps: const PopupProps.menu(
          fit: FlexFit.loose,
          showSelectedItems: false,
        ),
        items: controller.genderList,
        dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle:  GoogleFonts.roboto(
              textStyle:TextStyle(color: paragraphColor,fontSize: font_16,fontWeight: FontWeight.w400),),
            dropdownSearchDecoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(horizontal: margin_20, vertical: margin_10),
          border: InputBorder.none,
        )),
        onChanged: (value) {
          controller.genderType(value);
          print("select value$value");
        },
        selectedItem: controller.genderController.text);
  }

  _residentEditText() {
    return CommonTextField(
      controller: controller.applicantFatherNameController,
      labelText: residentStr.tr,
      inputActions: TextInputAction.next,
      suffix: _residentPopup(),
      validation: (value) {
        if (value == null || value.isEmpty) {
          return pleaseSelectItemStr.tr;
        }
        return null;
      },
    );
  }

  _residentPopup() {
    return DropdownSearch<dynamic>(
        popupProps: const PopupProps.menu(
          fit: FlexFit.loose,
          showSelectedItems: false,
        ),
        items: controller.residentList,
        dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle:  GoogleFonts.roboto(
              textStyle:TextStyle(color: paragraphColor,fontSize: font_16,fontWeight: FontWeight.w400),),
            dropdownSearchDecoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(horizontal: margin_20, vertical: margin_10),
          border: InputBorder.none,
        )),
        onChanged: (value) {
          controller.residentType(value);
          print("select value$value");
        },
        selectedItem: controller.residentController.text);
  }

  _aadhaarCardEditText() {
    return CommonTextField(
      controller: controller.aadhaarNoController,
      labelText: aadhaarNoStr.tr,
      inputType: TextInputType.number,
      validation: (value) {
        if (value == null || value.isEmpty) {
          return pleaseFillFieldStr.tr;
        } else if (value.length < 12) {
          return aadharLengthStr.tr;
        }
        return null;
      },
      inputFormators: [aadhaarNumberFormatter],
      inputActions: TextInputAction.next,
    );
  }

  // _panNoEditText() {
  //   return CommonTextField(
  //     controller: controller.panNoController,
  //     labelText: panNoStr.tr,
  //     validation: (value) {
  //       if (value == null || value.isEmpty) {
  //         return pleaseFillFieldStr.tr;
  //       } else if (value.length < 10) {
  //         return validPan.tr;
  //       }
  //       return null;
  //     },
  //     inputFormators: [panFormatter],
  //     inputActions: TextInputAction.next,
  //   );
  // }

  _phoneNoEditText(){
    return   getInkWell(
      ontap: (){
        toast(phoneNumberNotEditableStr.tr);
      },
      widget: CommonTextField(
        enable: false,
        controller:controller.mobileNumberController,
        inputType: TextInputType.number,
        labelText:mobileNumberStr.tr,
        inputFormators: [phoneNumberFormatter],
        preText: preTextPhoneStr.tr,
        validation: (value){
          if(value.length<10){
            return  validMobileStr.tr;
          }
          else{
            disableKeyboard();
          }
        },
      ),
    );
  }

  _casteEditText() {
    return CommonTextField(
      controller: controller.casteController,
      labelText: casteStr.tr,
      readOnly: true,
      validation: (value) {
        if (value == null || value.isEmpty) {
          return pleaseSelectItemStr.tr;
        }
        return null;
      },
      suffix: _castePopup(),
      inputActions: TextInputAction.next,
    );
  }

  _castePopup() {
    return DropdownSearch<dynamic>(
        popupProps: const PopupProps.menu(
          fit: FlexFit.loose,
          showSelectedItems: false,
        ),
        items: controller.casteCategory,
        dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle:  GoogleFonts.roboto(
              textStyle:TextStyle(color: paragraphColor,fontSize: font_16,fontWeight: FontWeight.w400),),
            dropdownSearchDecoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(horizontal: margin_20, vertical: margin_10),
          border: InputBorder.none,
        )),
        onChanged: (value) {
          controller.casteType(value);
          var index = controller.casteCategory.indexOf(value);
          controller.selectCategoryTypeId(controller.casteCategoryId[index]);
          print("select category id${controller.selectCategoryTypeId} ");
          print("select value$value");
        },
        selectedItem: controller.casteController.text);
  }

  _continueButton() {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            buttonText: updatePersonalInfoStr.tr,
            onClick: () {
              if(controller.formKey.currentState!.validate()){
                controller.updateProfileData();              }
              },
          ),
        )
      ],
    );
  }
  _profileUpdateShimmerWidget(){
    return SingleChildScrollView(
      child: Center(
        child: setPaddingAll(
          margin: margin_20,
          widget: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              sizedBox(height: height_30),
              ShimmerWidget.circular(width: 100.0, height: 100.0),
              sizedBox(height: height_20),
              ListView.builder(
                  itemCount: 8,
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (context,index){
                    return  setPadding(
                  bottomPadding: height_20,
                    widget: ShimmerWidget.rectangular(height: 56.0));
              }),
            ],
          ),
        ),
      ),
    );

  }
}
