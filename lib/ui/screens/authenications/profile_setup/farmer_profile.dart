import 'dart:io';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import '../../../constants/exports.dart';


class FarmerProfile extends GetView<FarmerProfileController> {
   FarmerProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   WillPopScope(
      onWillPop: ()async{
        Get.offAllNamed(Routes().loginScreen);
        return false;
      },
      child:  SafeArea(child: GetBuilder<FarmerProfileController>(
        init:FarmerProfileController() ,
        builder: (controller){
          return Scaffold(
              appBar: farmerProfileAppBar(
                leading: getInkWell(
                    widget:Icon(Icons.arrow_back,color: white,),
                    ontap: (){
                      Get.offNamed(Routes().loginScreen);
                    }
                ),
                hideLeading:sizedBox(width: 0.0),
                title: profileInfoStr.tr,

              ),
              body:
              FutureBuilder(
                  future:  controller.future,
                  builder: (context,snapshot){
                    if(snapshot.connectionState==ConnectionState.done){
                      if(snapshot.hasData){
                        return  SingleChildScrollView(
                            child:   setPaddingAll(
                                margin: margin_20,
                                widget:Column(children: [
                                  sizedBox(height: height_30),
                                  _userImage(),
                                  sizedBox(height: height_10),
                                  _form(),
                                  sizedBox(height: height_30),
                                  _continueButton(),
                                ],)
                            ));

                      }
                      else if(snapshot.hasError){
                        return   Center(child:commonText(snapshot.error.toString(),color: black) ,);
                      }
                      else{
                        return Center(
                          child:commonText(noDataAvailStr.tr,color: black)
                        );
                      }
                    }
                    else{
                      return loader();
                    }
                  })
          );
        },
      )));

  }


   _userImage(){
    return GetBuilder<FarmerProfileController>(
        id: "image",
        builder: (controller)
    {
      return
        getInkWell(
        ontap: (){
          _pickImageDialog();
          },
        widget: Stack(
          children: [
            ClipRRect(

              clipBehavior: Clip.antiAliasWithSaveLayer,
              borderRadius: BorderRadius.circular(radius_50),
              child: controller.pickedImage!=null?fileImage(image:File(controller.pickedImage!.path),height:100.0,width:100.0,fit: BoxFit.fill):
              assetImage(image: ic_user, height:100.0,width:100.0,fit: BoxFit.contain
              ),
            ),
             Positioned(
                bottom: 5,
                right: 0, child:  assetImage(image: ic_camera,height: 30.0,width: 30.0
            ),)
          ],
        ),
           );
    }
    );


   }
   _pickImageDialog(){
     return     commonDialogs(
          titleText: pickImageStr.tr,
         body: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
               getInkWell(
                 ontap: (){
                   controller.pickImageCamera();
                   Get.back();
                 },
                 widget: Row(
                   children: [
                     const Icon(Icons.camera_alt_outlined,color: primaryColor,),
                     sizedBox(width: width_10),
                   text(cameraStr.tr,color: subtitleColor),
                   ],
                 ),
               ),
             sizedBox(height: height_10),
             const Divider(color: borderColor,),

             getInkWell(
               ontap: (){
                 controller.pickImageGallery();
                 Get.back();
               },
               widget: Row(
            children: [
               const Icon(Icons.image_outlined,color: primaryColor,),
                sizedBox(width: width_10),
                 text(galleryStr.tr,color: subtitleColor),
            ],
          ),
             )


           ],
         ),
         onConfirmClick: () {}
     );


   }


   _form(){
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

  _applicantTypeEditText(){
    return CommonTextField(
        controller: controller.applicantTypeController,
        focusNode: controller.applicantTypeFocusNode,
        readOnly: true,
      validation: (value){
        if (value == null || value.isEmpty) {
          return pleaseSelectItemStr.tr;
        }
        return null;
      },
      inputActions: TextInputAction.next,
        labelText: applicantStr.tr,
        suffix: _applicantDropDown(),
    );
  }

  _applicantDropDown(){
    return DropdownSearch<dynamic>(
      popupProps:  PopupProps.menu(
        fit: FlexFit.loose,
        showSelectedItems: false,

         // textStyle:GoogleFonts.roboto(
         //   textStyle:TextStyle(color: green,fontSize: font_20,fontWeight: FontWeight.w400),),
      ),
      items: controller.applicantName,
      dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle:  GoogleFonts.roboto(
              textStyle:TextStyle(color: paragraphColor,fontSize: font_16,fontWeight: FontWeight.w400),),
          dropdownSearchDecoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: margin_20,vertical: margin_10),

              border: InputBorder.none,
        ),
      ),

      onChanged: (value){
        controller.applicantType(value);
             var index=controller.applicantName.indexOf(value);
        controller.selectAppicateTypeIdFun(controller.applicantId[index]);

            debugPrint("select value${controller.selectAppicantTypeId} ");
      },
       selectedItem: selectApplicantTypeStr.tr
    );

  }


  _nameEditText(){
    return CommonTextField(
      controller: controller.applicantNameController,
      labelText: applicantNameStr.tr,
      inputActions: TextInputAction.next,
      validation: (value){
        if (value == null || value.isEmpty) {
          return pleaseFillFieldStr.tr;
        }
        return null;
      },
    );
  }

   _fatherNameEditText(){
     return CommonTextField(
       controller: controller.applicantFatherNameController,
       labelText: applicantFatherNameStr.tr,
       inputActions: TextInputAction.next,
       validation: (value){
         if (value == null || value.isEmpty) {
           return pleaseFillFieldStr.tr;
         }
         return null;
       },
     );
   }
   _genderEditText(){
     return CommonTextField(
       controller: controller.genderController,
       labelText: genderStr.tr,
       readOnly: true,
       validation: (value){
         if (value == null || value.isEmpty) {
           return pleaseSelectItemStr.tr;
         }
         return null;
       },
       suffix: _genderPopup(),
       inputActions: TextInputAction.next,

     );
   }
   _genderPopup(){

    return DropdownSearch<dynamic>(
         popupProps: const PopupProps.menu(
           fit: FlexFit.loose,
           showSelectedItems: false,
         ),
         items:controller.genderList,
         dropdownDecoratorProps: DropDownDecoratorProps(
             baseStyle:  GoogleFonts.roboto(
               textStyle:TextStyle(color: paragraphColor,fontSize: font_16,fontWeight: FontWeight.w400),),
             dropdownSearchDecoration: InputDecoration(
               contentPadding: EdgeInsets.symmetric(horizontal: margin_20,vertical: margin_10),
               border: InputBorder.none,
             )
         ),
         onChanged: (value){
           controller.genderType(value);
           debugPrint("select value$value");
         },
         selectedItem: selectGenderStr.tr
       );
  }

   _residentEditText(){
     return CommonTextField(
       controller: controller.residentController,
       labelText: residentStr.tr,
       inputActions: TextInputAction.next,
       suffix: _residentPopup(),
       validation: (value){
         if (value == null || value.isEmpty) {
           return pleaseSelectItemStr.tr;
         }
         return null;
       },
     );
   }

   _residentPopup(){

     return DropdownSearch<dynamic>(
       popupProps: const PopupProps.menu(
         fit: FlexFit.loose,
         showSelectedItems: false,
       ),
       items:controller.residentList,
       dropdownDecoratorProps: DropDownDecoratorProps(
           baseStyle:  GoogleFonts.roboto(
             textStyle:TextStyle(color: paragraphColor,fontSize: font_16,fontWeight: FontWeight.w400),),
           dropdownSearchDecoration: InputDecoration(
             contentPadding: EdgeInsets.symmetric(horizontal: margin_20,vertical: margin_10),
             border: InputBorder.none,
           )
       ),
       onChanged: (value){

         controller.residentType(value);
         debugPrint("select value$value");
       },
       selectedItem:selectResidentStr.tr
     );
   }

   _aadhaarCardEditText(){
     return CommonTextField(
       controller: controller.aadhaarNoController,
       labelText: aadhaarNoStr.tr,
       inputType: TextInputType.number,
       validation: (value){
         if (value == null || value.isEmpty) {
           return pleaseFillFieldStr.tr;
         }
        else if (value.length<12) {
           return aadharLengthStr.tr;
         }
         return null;
       },
       inputFormators:[aadhaarNumberFormatter] ,
       inputActions: TextInputAction.next,
     );
   }
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
   _casteEditText(){
     return CommonTextField(
       controller: controller.casteController,
       labelText: casteStr.tr,
       readOnly: true,
       validation: (value){
         if (value == null || value.isEmpty) {
           return pleaseSelectItemStr.tr;
         }
         return null;
       },
       suffix: _castePopup(),
       inputActions: TextInputAction.next,
     );
   }
   _castePopup(){
     return DropdownSearch<dynamic>(
       popupProps: const PopupProps.menu(
         fit: FlexFit.loose,
         showSelectedItems: false,
       ),
       items:controller.casteCategory,
       dropdownDecoratorProps: DropDownDecoratorProps(
           baseStyle:  GoogleFonts.roboto(
             textStyle:TextStyle(color: paragraphColor,fontSize: font_16,fontWeight: FontWeight.w400),),
           dropdownSearchDecoration: InputDecoration(
             contentPadding: EdgeInsets.symmetric(horizontal: margin_20,vertical: margin_10),
             border: InputBorder.none,
           )
       ),
       onChanged: (value){
         controller.casteType(value);
         var index=controller.casteCategory.indexOf(value);
         controller.selectCategoryTypeId(controller.casteCategoryId[index]);
         debugPrint("select category id${controller.selectCategoryTypeId} ");
         debugPrint("select value$value");
       },
       selectedItem: selectCategoryTypeStr.tr
     );
   }
   _continueButton(){
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            buttonText: continueStr.tr,
            onClick: (){
                  if(controller.pickedImage==null){
                    toast(pleasePickImage.tr);
                  }
                  else if(controller.formKey.currentState!.validate()){

                    Get.toNamed(Routes().completeProfile);
                 }
                  else{
                    toast(pleaseFillRequiredFieldStr.tr);
                  }

            },
          ),
        )
      ],
    );
   }



}
