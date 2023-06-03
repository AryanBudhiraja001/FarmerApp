import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import '../../../constants/exports.dart';
import '../../../shimmer_effect/shimmerWidget.dart';


class UpdateAddressScreen extends GetView<UpdateAddressController> {
  UpdateAddressScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return SafeArea(child: GetBuilder<UpdateAddressController>(
      init:UpdateAddressController() ,
      builder: (_){
        return Scaffold(
            appBar: customAppBar(
              title: addressStr.tr,
            ),
            body:controller.isLoadingData.value?loader():
            FutureBuilder(
              future: controller.farmerAddressfuture,
              builder: (context,snapshot){
               if(snapshot.connectionState==ConnectionState.done){
                 if(snapshot.hasData){
                   return    SingleChildScrollView(
                       child:   setPaddingAll(
                           margin: margin_20,
                           widget:Column(children: [
                             _form(),
                             sizedBox(height: height_50),
                             _updateAddressButton(),
                           ],)
                       )
                   );
                 }
               }
               if(snapshot.connectionState==ConnectionState.waiting){
                 return _profileAddressShimmerWidget();
               }
               if(snapshot.hasError){
                 return noDataAvailable(title:controller.updateProfileInfoController.errorMessage.value);
               }
               else{
                 return _profileAddressShimmerWidget();
               }
               },
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
        items: controller.updateProfileInfoController.stateList,
        dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle:  GoogleFonts.roboto(
              textStyle:TextStyle(color: paragraphColor,fontSize: font_16,fontWeight: FontWeight.w400),),
            dropdownSearchDecoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: margin_20,vertical: margin_10),
              border: InputBorder.none,
            )
        ),
        onChanged: (value){
          controller.stateController.text=value;
          controller.stateType(value);
        },
        selectedItem:controller.stateController.text
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
        items: controller.districtList,
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
          var index=controller.districtList.indexOf(value);
          controller.selectDistrictSelectedIndexIdFun(index);
          controller.tehsilList.clear();
          controller.tehsilController.text="";
          controller.villageController.text="";
          controller.getTehsilData( controller.selectedDistrictIndex.value);
          controller.selectDistrictTypeIdFun(controller.districtIdList[index]);
          controller.selectDistrictIdFun(controller.selectDistrictTypeId.value);
          print("select value${controller.districtIdList[index]}");
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
        items:controller.tehsilList,
        dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle:  GoogleFonts.roboto(
              textStyle:TextStyle(color: paragraphColor,fontSize: font_16,fontWeight: FontWeight.w400),),
            dropdownSearchDecoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: margin_20,vertical: margin_10),
              border: InputBorder.none,
            )
        ),
        onChanged: (value){
          var index=controller.tehsilList.indexOf(value);
          controller.tehsilController.text=value;
          controller.selectVillageTypeId.value=index;
          controller.villageList.clear();
          controller.villageController.text="";
          controller.selecttehsilSelectedIndexIdFun(index);
          controller.getVillageData(controller.selectedTehsilIndex.value,
              controller.selectedDistrictIndex.value);
          controller.selectTehsilTypeIdFun(controller.tehsilIdList[index]);

          controller.selectTehsilIdFun(controller.selectTehsilTypeId.value);
          print("select value${controller.tehsilIdList[index]}");
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
        items: controller.villageList,
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
          var index=controller.villageList.indexOf(value);
          controller.selectVillageTypeIdFun(controller.villageIdList[index]);
          controller.selectVillageIdFun(controller.selectVillageTypeId.value);
          print("select value${controller.villageIdList[index]}");
        },
        selectedItem:controller.villageController.text==""?selectCityVillageStr:controller.villageController.text

    );

  }


  _fullAddressEditText(){
    return CommonTextField(
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

  _updateAddressButton(){
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            buttonText: updateAddressStr.tr,
            onClick: (){
              if(controller.formKey.currentState!.validate()){
                controller.postUpdateAddressData();
              }
            },
          ),
        )
      ],
    );
  }



  _profileAddressShimmerWidget(){
    return SingleChildScrollView(
      child: Center(
        child: setPaddingAll(
          margin: margin_20,
          widget: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              sizedBox(height: height_30),
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
