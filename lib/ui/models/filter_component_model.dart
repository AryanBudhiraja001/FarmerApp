class FilterComponentListModel {
  String? message;
  List<Components>? components;

  FilterComponentListModel({this.message, this.components});

  FilterComponentListModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['components'] != null) {
      components = <Components>[];
      json['components'].forEach((v) {
        components!.add(new Components.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.components != null) {
      data['components'] = this.components!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Components {
  int? componentId;
  String? componentName;
  List<SubComponent>? subComponent;

  Components({this.componentId, this.componentName, this.subComponent});

  Components.fromJson(Map<String, dynamic> json) {
    componentId = json['component_id'];
    componentName = json['component_name'];
    if (json['sub_component'] != null) {
      subComponent = <SubComponent>[];
      json['sub_component'].forEach((v) {
        subComponent!.add(new SubComponent.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['component_id'] = this.componentId;
    data['component_name'] = this.componentName;
    if (this.subComponent != null) {
      data['sub_component'] =
          this.subComponent!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubComponent {
  int? subComponentId;
  String? subComponentName;

  SubComponent({this.subComponentId, this.subComponentName});

  SubComponent.fromJson(Map<String, dynamic> json) {
    subComponentId = json['sub_component_id'];
    subComponentName = json['sub_component_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub_component_id'] = this.subComponentId;
    data['sub_component_name'] = this.subComponentName;
    return data;
  }
}
