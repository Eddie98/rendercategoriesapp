// ignore_for_file: prefer_if_null_operators, unnecessary_null_comparison, unnecessary_new, prefer_conditional_assignment

import 'dart:convert';

class Model {
  Model({
    required this.context,
    required this.id,
    required this.type,
    required this.hydraMember,
    required this.hydraTotalItems,
  });

  String? context;
  String? id;
  String? type;
  List<HydraMember>? hydraMember;
  int? hydraTotalItems;

  factory Model.fromRawJson(String str) => Model.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Model.fromJson(Map<String, dynamic> json) => Model(
        context: json["@context"],
        id: json["@id"],
        type: json["@type"],
        hydraMember: List<HydraMember>.from(
            json["hydra:member"].map((x) => HydraMember.fromJson(x))),
        hydraTotalItems: json["hydra:totalItems"],
      );

  Map<String, dynamic> toJson() => {
        "@context": context,
        "@id": id,
        "@type": type,
        "hydra:member": List<dynamic>.from(hydraMember!.map((x) => x.toJson())),
        "hydra:totalItems": hydraTotalItems,
      };
}

class HydraMember {
  HydraMember({
    required this.type,
    required this.id,
    required this.hydraMemberId,
    required this.eeCatId,
    required this.name,
    required this.slug,
    required this.categories,
  });

  Type? type;
  String? id;
  int? hydraMemberId;
  int? eeCatId;
  String? name;
  String? slug;
  List<HydraMemberCategory>? categories;

  factory HydraMember.fromRawJson(String str) =>
      HydraMember.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HydraMember.fromJson(Map<String, dynamic> json) => HydraMember(
        type: typeValues.map[json["@type"]],
        id: json["@id"],
        hydraMemberId: json["id"],
        eeCatId: json["eeCatId"],
        name: json["name"],
        slug: json["slug"],
        categories: List<HydraMemberCategory>.from(
            json["categories"].map((x) => HydraMemberCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "@type": typeValues.reverse[type],
        "@id": id,
        "id": hydraMemberId,
        "eeCatId": eeCatId,
        "name": name,
        "slug": slug,
        "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
      };
}

class HydraMemberCategory {
  HydraMemberCategory({
    required this.id,
    required this.name,
    required this.slug,
    required this.categoryEeCatId,
    required this.imageUrl,
    required this.categoryCategories,
    required this.eeCatId,
    required this.imagEUrl,
    required this.categories,
    required this.imageURl,
    required this.categoriEs,
    required this.iMageUrl,
  });

  int? id;
  String? name;
  String? slug;
  int? categoryEeCatId;
  dynamic imageUrl;
  List<CategoryCategory>? categoryCategories;
  int? eeCatId;
  dynamic imagEUrl;
  List<dynamic>? categories;
  dynamic imageURl;
  List<dynamic>? categoriEs;
  dynamic iMageUrl;

  factory HydraMemberCategory.fromRawJson(String str) =>
      HydraMemberCategory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HydraMemberCategory.fromJson(Map<String, dynamic> json) =>
      HydraMemberCategory(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        categoryEeCatId: json["eeCatId"] == null ? null : json["eeCatId"],
        imageUrl: json["imageUrl"],
        categoryCategories: json["categories"] == null
            ? null
            : List<CategoryCategory>.from(
                json["categories"].map((x) => CategoryCategory.fromJson(x))),
        eeCatId: json[" eeCatId"] == null ? null : json[" eeCatId"],
        imagEUrl: json["imag eUrl"],
        categories: json[" categories"] == null
            ? null
            : List<dynamic>.from(json[" categories"].map((x) => x)),
        imageURl: json["imageU rl"],
        categoriEs: json["categori es"] == null
            ? null
            : List<dynamic>.from(json["categori es"].map((x) => x)),
        iMageUrl: json["i mageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "eeCatId": categoryEeCatId == null ? null : categoryEeCatId,
        "imageUrl": imageUrl,
        "categories": categoryCategories == null
            ? null
            : List<dynamic>.from(categoryCategories!.map((x) => x.toJson())),
        " eeCatId": eeCatId == null ? null : eeCatId,
        "imag eUrl": imagEUrl,
        " categories": categories == null
            ? null
            : List<dynamic>.from(categories!.map((x) => x)),
        "imageU rl": imageURl,
        "categori es": categoriEs == null
            ? null
            : List<dynamic>.from(categoriEs!.map((x) => x)),
        "i mageUrl": iMageUrl,
      };
}

class CategoryCategory {
  CategoryCategory({
    required this.id,
    required this.categoryName,
    required this.categorySlug,
    required this.fluffyEeCatId,
    required this.imageUrl,
    required this.eECatId,
    required this.imagEUrl,
    required this.imaGeUrl,
    required this.purpleEeCatId,
    required this.purpleName,
    required this.namE,
    required this.sLug,
    required this.iMageUrl,
    required this.slug,
    required this.name,
    required this.eeCatId,
    required this.slUg,
    required this.categoryEeCatId,
  });

  int? id;
  String? categoryName;
  String? categorySlug;
  int? fluffyEeCatId;
  dynamic imageUrl;
  int? eECatId;
  dynamic imagEUrl;
  dynamic imaGeUrl;
  int? purpleEeCatId;
  String? purpleName;
  String? namE;
  String? sLug;
  dynamic iMageUrl;
  String? slug;
  String? name;
  int? eeCatId;
  String? slUg;
  int? categoryEeCatId;

  factory CategoryCategory.fromRawJson(String str) =>
      CategoryCategory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryCategory.fromJson(Map<String, dynamic> json) =>
      CategoryCategory(
        id: json["id"],
        categoryName: json["name"] == null ? null : json["name"],
        categorySlug: json["slug"] == null ? null : json["slug"],
        fluffyEeCatId: json["eeCatId"] == null ? null : json["eeCatId"],
        imageUrl: json["imageUrl"],
        eECatId: json["e eCatId"] == null ? null : json["e eCatId"],
        imagEUrl: json["imag eUrl"],
        imaGeUrl: json["ima geUrl"],
        purpleEeCatId: json["eeCat Id"] == null ? null : json["eeCat Id"],
        purpleName: json["name "] == null ? null : json["name "],
        namE: json["nam e"] == null ? null : json["nam e"],
        sLug: json["s lug"] == null ? null : json["s lug"],
        iMageUrl: json["i mageUrl"],
        slug: json[" slug"] == null ? null : json[" slug"],
        name: json[" name"] == null ? null : json[" name"],
        eeCatId: json[" eeCatId"] == null ? null : json[" eeCatId"],
        slUg: json["sl ug"] == null ? null : json["sl ug"],
        categoryEeCatId: json["ee CatId"] == null ? null : json["ee CatId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": categoryName == null ? null : categoryName,
        "slug": categorySlug == null ? null : categorySlug,
        "eeCatId": fluffyEeCatId == null ? null : fluffyEeCatId,
        "imageUrl": imageUrl,
        "e eCatId": eECatId == null ? null : eECatId,
        "imag eUrl": imagEUrl,
        "ima geUrl": imaGeUrl,
        "eeCat Id": purpleEeCatId == null ? null : purpleEeCatId,
        "name ": purpleName == null ? null : purpleName,
        "nam e": namE == null ? null : namE,
        "s lug": sLug == null ? null : sLug,
        "i mageUrl": iMageUrl,
        " slug": slug == null ? null : slug,
        " name": name == null ? null : name,
        " eeCatId": eeCatId == null ? null : eeCatId,
        "sl ug": slUg == null ? null : slUg,
        "ee CatId": categoryEeCatId == null ? null : categoryEeCatId,
      };
}

enum Type { CATEGORY }

final typeValues = EnumValues({"Category": Type.CATEGORY});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
