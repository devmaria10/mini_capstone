/* global Vue, VueRouter, axios */

// Products Components

var ProductsIndexPage = {
  template: "#products-index-page",
  data: function() {
    return {
      products: []
    };
  },
  created: function() {
    axios.get("/products")
      .then(function(response) {
        this.products = response.data;
      }.bind(this));
  },
  methods: {},
  computed: {}
};

var ProductsNewPage = {
  template: "#products-new-page",
  data: function() {
    return {
      name: "",
      price: "",
      image_url: "",
      description: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        name: this.name,
        price: this.price,
        image_url: this.imageUrl,
        description: this.description
      };
      axios
        .post("/products", params)
        .then(function(response) {
          router.push("/");
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
            router.push("/login");
          }.bind(this)
        );
    }
  }
};

var ProductsShowPage = {
  template: "#products-show-page",
  data: function() {
    return {
      product: {
        id: "",
        name: "",
        image_url: "",
        description: "",
        price: ""
      }
    }
  },
  created: function() {
    axios.get("/products/" + this.$route.params.id )
      .then(function(response) {
        this.product = response.data;
      }.bind(this));
  }
};
var ProductsEditPage = {
  template: "#products-edit-page",
  data: function() {
    return {
      name: "",
      price: "",
      image_url: "",
      description: "",
      errors: []
    };
  },
  created: function() {
    axios
      .get("/products/" + this.$route.params.id)
      .then(function(response) {
        var product = response.data;
        this.name = product.name;
        this.price = product.price;
        this.imageUrl = product.image_url;
        this.description = product.description;
      }.bind(this));
  },
  methods: {
    submit: function() {
      var params = {
        name: this.name,
        price: this.price,
        image_url: this.imageUrl,
        description: this.description
      };
      axios
        .patch("/products/" + this.$route.params.id, params)
        .then(function(response) {
          router.push("/products/" + response.data.id);
        }.bind(this)
        )
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
            router.push("/login");
          }.bind(this)
        );
    }
  }
};

//axios.patch().then().catch();

// Authorization Components 

var SignupPage = {
  template: "#signup-page",
  data: function() {
    return {
      name: "",
      email: "",
      password: "",
      passwordConfirmation: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        name: this.name,
        email: this.email,
        password: this.password,
        password_confirmation: this.passwordConfirmation
      };
      axios
        .post("/users", params)
        .then(function(response) {
          router.push("/login");
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
    }
  }
};

var LoginPage = {
  template: "#login-page",
  data: function() {
    return {
      email: "",
      password: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        auth: { email: this.email, password: this.password }
      };
      axios
        .post("/user_token", params)
        .then(function(response) {
          axios.defaults.headers.common["Authorization"] =
            "Bearer " + response.data.jwt;
          localStorage.setItem("jwt", response.data.jwt);
          router.push("/");
        })
        .catch(
          function(error) {
            this.errors = ["Invalid email or password."];
            this.email = "";
            this.password = "";
          }.bind(this)
        );
    }
  }
};

var LogoutPage = {
  created: function() {
    axios.defaults.headers.common["Authorization"] = undefined;
    localStorage.removeItem("jwt");
    router.push("/");
  }
};

var router = new VueRouter({
  routes: [
    { path: "/", component: ProductsIndexPage },
    { path: "/products", component: ProductsIndexPage },
    { path: "/products/new", component: ProductsNewPage },
    { path: "/products/:id", component: ProductsShowPage },
    { path: "/products/:id/edit", component: ProductsEditPage},
    { path: "/signup", component: SignupPage },
    { path: "/login", component: LoginPage },
    { path: "logout", component: LogoutPage }
  ],
  scrollBehavior: function(to, from, savedPosition) {
    return { x: 0, y: 0 };
  }
});

var app = new Vue({
  el: "#vue-app",
  router: router,
  created: function() {
    var jwt = localStorage.getItem("jwt");
    if (jwt) {
      axios.defaults.headers.common["Authorization"] = jwt;
    }
  }
});