

///
/// Class qui va nous permettre de créer une liste des service Json
/// Cette class vas nous permettre de transferer les donnéer normalement ahha ... les reves
///

class ServiceJson{

  final int index ;

  ServiceJson(int index) : index = index;

  int get ind => index;


}


///
/// Enssemble des classes dont nous avons besoin pour lire le fichier Json
///

class ServiceList{
  List<Service> service;

  ServiceList({
    this.service
  });

  factory ServiceList.fromJson(List<dynamic>parsedJson){
    List<Service> service = new List<Service>();
    service = parsedJson.map((i) => Service.fromJson(i)).toList();

    return new ServiceList(
        service: service
    );

  }

}

class Service{
  final String title;
  final List<Element> element;

  Service({
    this.title,
    this.element
  });

  factory Service.fromJson(Map<String, dynamic> parsedJson){
    var list = parsedJson['elements'] as List;
    List<Element> elementlist = list.map((i) => Element.fromJson(i)).toList();

    return new Service(
      title: parsedJson['title'],
      element: elementlist,
    );
  }

}

class Element{
  final String section;
  final String type;
  final List<String> value;
  final String mandatory;

  Element({
    this.section,
    this.type,
    this.value,
    this.mandatory
  });

  factory Element.fromJson(Map<String, dynamic> parsedJson){
    var valueFromJson = parsedJson['value'];
    List<String> valueList = valueFromJson.cast<String>();

    return new Element (
        section: parsedJson['section'],
        type: parsedJson['type'],
        value: valueList,
        mandatory: parsedJson['mandatory']
    );
  }

}