class CategoryModel {
  int id;
  var parentId;
  var order;
  String nameAr;
  String name;
  String slug;
  var createdAt;
  var updatedAt;
  String image;
  String imgFullPath;
  int hasChild;

  CategoryModel(
      {this.id,
        this.parentId,
        this.order,
        this.nameAr,
        this.name,
        this.slug,
        this.createdAt,
        this.updatedAt,
        this.image,
        this.imgFullPath,
      this.hasChild});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hasChild = json['hasChild'];
    parentId = json['parent_id'];
    order = json['order'];
    nameAr = json['name_ar'];
    name = json['name'];
    slug = json['slug'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
    imgFullPath = json['img_full_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hasChild'] = this.hasChild;
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['order'] = this.order;
    data['name_ar'] = this.nameAr;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image'] = this.image;
    data['img_full_path'] = this.imgFullPath;
    return data;
  }
}