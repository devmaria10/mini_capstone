var productTemplate = document.querySelector("#product-card");
var productContainer = document.querySelector(".row");

axios.get("http://localhost:3000/products").then(function(response) {
  var products = response.data;
  products.forEach(function(product) {
    var productClone = productTemplate.content.cloneNode(true);
    productClone.querySelector(".card-title").innerText = product.title;
    productClone.querySelector(".price").innerText = product.price;
    productClone.querySelector(".source").innerText = product.source;
    productClone.querySelector(".description").innerText = product.description; 
    productContainer.appendChild(productClone);
  });
});




