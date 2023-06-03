import 'dart:math';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import '../../../constants/exports.dart';

class CompleteProfile extends GetView<CompleteProfileController> {
  CompleteProfile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return
    SafeArea(child: GetBuilder<CompleteProfileController>(
      init:CompleteProfileController() ,
      builder: (_){
       return Scaffold(
              appBar: customAppBar(
                title: addressStr.tr,
              ),
              body:controller.isLoadingData.value?loader():
              SingleChildScrollView(
                child:   setPaddingAll(
                  margin: margin_20,
                  widget:Column(children: [
                    _form(),
                    sizedBox(height: height_50),
                    _completeProfileButton(),
                  ],)
                )
              )

        );
      },
    ));
  }
  _form(){
    return Form(
        key: controller.formKey,
        child: Column(
          children: [
            sizedBox(height: height_20),
            _stateEditText(),
            sizedBox(height: height_20),
            _districtEditText(),
            sizedBox(height: height_20),
            _tehsilEditText(),
            sizedBox(height: height_20),
            _villageEditText(),
            sizedBox(height: height_20),
            _fullAddressEditText(),
            sizedBox(height: height_20),
            _pinCodeEditText(),
          ],
        ));
  }

  _stateEditText(){
    return CommonTextField(
      controller: controller.stateController,
      labelText: stateStr.tr,
      validation: (value){
        if (value == null || value.isEmpty) {
          return pleaseSelectItemStr.tr;
        }
        return null;
      },
      inputActions: TextInputAction.next,
      suffix: _stateDropDown(),
    );
  }


  _stateDropDown(){
    return DropdownSearch<dynamic>(
      popupProps: const PopupProps.menu(
        fit: FlexFit.loose,
        showSelectedItems: false,
      ),
      items: controller.farmerProfileController.stateList,
      dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle:  GoogleFonts.roboto(
            textStyle:TextStyle(color: paragraphColor,fontSize: font_16,fontWeight: FontWeight.w400),),
          dropdownSearchDecoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: margin_20,vertical: margin_10),
            border: InputBorder.none,
          )
      ),
      onChanged: (value){
        controller.stateType(value);
        },
      selectedItem:selectStateStr.tr
    );

  }

  _districtEditText(){
    return CommonTextField(
      controller: controller.districtController,
      labelText: districtStr.tr,
      inputActions: TextInputAction.next,
      validation: (value){
        if (value == null || value.isEmpty) {
          return pleaseSelectItemStr.tr;
        }
        return null;
      },
      suffix: _districtDropDown(),
    );
  }


  _districtDropDown(){
    return DropdownSearch<dynamic>(
      popupProps: const PopupProps.menu(
        fit: FlexFit.loose,
        showSelectedItems: false,
      ),
      items: controller.farmerProfileController.districtList,
      dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle:  GoogleFonts.roboto(
            textStyle:TextStyle(color: paragraphColor,fontSize: font_16,fontWeight: FontWeight.w400),),
          dropdownSearchDecoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: margin_20,vertical: margin_10),
            border: InputBorder.none,
          )
      ),
      onChanged: (value){
        controller.districtType(value);
        var index=controller.farmerProfileController.districtList.indexOf(value);
        controller.farmerProfileController.selectDistrictSelectedIndexIdFun(index);
        controller.farmerProfileController.tehsilList.clear();
        controller.farmerProfileController.tehsilIdList.clear();
        controller.tehsilController.text="";
        controller.villageController.text="";
        controller.farmerProfileController.getTehsilData( controller.farmerProfileController.selectedDistrictIndex.value);
        controller.farmerProfileController.selectDistrictTypeIdFun(controller.farmerProfileController.districtIdList[index]);
        controller.selectDistrictIdFun(controller.farmerProfileController.selectDistrictTypeId.value);
        debugPrint("select value${controller.farmerProfileController.districtIdList[index]}");
      },
      selectedItem:controller.districtController.text==""?selectDistrictTypeStr:controller.districtController.text
    );

  }
  _tehsilEditText(){
    return CommonTextField(
      controller: controller.tehsilController,
      labelText: tehsilStr.tr,
      validation: (value){
        if (value == null || value.isEmpty) {
          return pleaseSelectItemStr.tr;
        }
        return null;
      },
      inputActions: TextInputAction.next,
       suffix: _tehsilDropDown(),
    );
  }


  _tehsilDropDown(){
    return DropdownSearch<dynamic>(
      popupProps: const PopupProps.menu(
        fit: FlexFit.loose,
        showSelectedItems: false,
      ),
      items:controller.farmerProfileController.tehsilList,
      dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle:  GoogleFonts.roboto(
            textStyle:TextStyle(color: paragraphColor,fontSize: font_16,fontWeight: FontWeight.w400),),
          dropdownSearchDecoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: margin_20,vertical: margin_10),
            border: InputBorder.none,
          )
      ),
      onChanged: (value){
        var index=controller.farmerProfileController.tehsilList.indexOf(value);
        controller.tehsilController.text=value;
        controller.farmerProfileController.selectVillageTypeId.value=index;
        controller.farmerProfileController.villageList.clear();
        controller.farmerProfileController.villageIdList.clear();
        controller.villageController.text="";
        controller.farmerProfileController.selecttehsilSelectedIndexIdFun(index);
        controller.farmerProfileController.getVillageData(controller.farmerProfileController.selectedTehsilIndex.value, controller.farmerProfileController.selectedDistrictIndex.value);
        controller.farmerProfileController.selectTehsilTypeIdFun(controller.farmerProfileController.tehsilIdList[index]);
        controller.selectTehsilIdFun(controller.farmerProfileController.selectTehsilTypeId.value);
        debugPrint("select value${controller.farmerProfileController.tehsilIdList[index]}");
      },
      selectedItem:controller.tehsilController.text==""?selectTehsilStr:controller.tehsilController.text
    );

  }

  _villageEditText(){
    return CommonTextField(
      controller: controller.villageController,
      labelText: villageStr.tr,
      validation: (value){
        if (value == null || value.isEmpty) {
          return pleaseSelectItemStr.tr;
        }
        return null;
      },
      inputActions: TextInputAction.next,
       suffix: _villageDropDown(),
    );
  }

  _villageDropDown(){
    return DropdownSearch<dynamic>(
      popupProps: const PopupProps.menu(
        fit: FlexFit.loose,
        showSelectedItems: false,
      ),
      items: controller.farmerProfileController.villageList,
      dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle:  GoogleFonts.roboto(
            textStyle:TextStyle(color: paragraphColor,fontSize: font_16,fontWeight: FontWeight.w400),),
          dropdownSearchDecoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: margin_20,vertical: margin_10),
            border: InputBorder.none,
          )
      ),
      onChanged: (value){
        controller.villageController.text=value;
        var index=controller.farmerProfileController.villageList.indexOf(value);
        controller.farmerProfileController.selectVillageTypeIdFun(controller.farmerProfileController.villageIdList[index]);
        controller.selectVillageIdFun(controller.farmerProfileController.selectVillageTypeId.value);
        debugPrint("select value${controller.farmerProfileController.villageIdList[index]}");
      },
      selectedItem:controller.villageController.text==""?selectCityVillageStr:controller.villageController.text
    );

  }


  _fullAddressEditText(){
    return CommonTextField(
      maxlines: 2,
      controller: controller.fullAddressController,
      labelText: fullAddressStr.tr,
      inputActions: TextInputAction.next,
      validation: (value){
        if (value == null || value.isEmpty) {
          return pleaseFillFieldStr.tr;
        }
        return null;
      },
    );
  }

  _pinCodeEditText(){
    return CommonTextField(
      controller: controller.pincodeController,
      labelText: pinCodeStr.tr,
      inputType: TextInputType.number,
      inputFormators: [pinCodeFormatter],
      inputActions: TextInputAction.done,
      validation: (value){
        if (value == null || value.isEmpty) {
          return pleaseFillFieldStr.tr;
        }
        else if (value.length<6) {
          return validPin.tr;
        }
        return null;
      },
    );
  }

  _completeProfileButton(){
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            buttonText: completeStr.tr,
            onClick: (){

              if(controller.formKey.currentState!.validate()){
                disableKeyboard();
                controller.postProfileData();
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
