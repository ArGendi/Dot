class Product{
  String name = '';
  String description = '';
  double price = -1;
  int sale = 0;
  String imageUrl = '';
  int rate = 0;
  int numberOfReviews = 0;
  bool isFavourite = false;
  int availabilityInStock = 12;
  String color = 'red';
  int quantityAddedInCart = 0;

  Product({required this.name, required this.price, required this.sale});
}