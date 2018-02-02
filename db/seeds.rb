Category.create(name: "Dr. Seuss")
Category.create(name: "Not Dr. Seuss")
Category.create(name: "Little")

CategoryProduct.create!([
                        {category_id: 1, product_id: 2},
                        {category_id: 1, product_id: 3},
                        {category_id: 1, product_id: 4},
                        {category_id: 1, product_id: 1},
                        {category_id: 2, product_id: 2},
                        {category_id: 3, product_id: 5}
                        ])
