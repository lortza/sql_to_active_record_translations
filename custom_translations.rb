# Come up with 3 queries just complex enough to test your understanding.
# At least one should use an aggregate function (e.g. COUNT)
# and at least one should us GROUP. Don't repeat the examples we've
# just used above. Then write down each of those queries in both SQL
# and ActiveRecord.

# See the custom_translations_schema.rb for the schema

# 1. For a given component (id = 1), show the manufacturer and total cost at each quantity (cost_each + shipping_each * qty)
SELECT c.name, m.name, p.qty, ((p.cost_each + p.shipping_each) * qty) AS total
  FROM components c
  JOIN prices p ON c.id = p.component_id
  JOIN manufacturers m ON c.manufacturer_id = m.id
  WHERE c.id = 1;

query = "SELECT c.name, m.name, p.qty, ((p.cost_each + p.shipping_each) * qty) AS total
  FROM components c
  JOIN prices p ON c.id = p.component_id
  JOIN manufacturers m ON c.manufacturer_id = m.id
  WHERE c.id = 1;"

components = Component.find_by_sql(query)


# 2. Show a list of manufacturer names and a count of all components they make
SELECT m.name, COUNT(c.manufacturer_id)
  FROM components c
  JOIN manufacturers m ON m.id = c.manufacturer_id
  GROUP BY m.name;

Component.joins("JOIN manufacturers ON manufacturers.id = components.manufacturer_id").group("manufacturers.name").count



# 3. List of each component and how many products it is included in
SELECT c.name AS component, COUNT(cp.*) AS products
  FROM components c
  JOIN component_products cp ON c.id = cp.component_id
  GROUP BY c.name;

Component.joins("JOIN component_products ON component_id = components.id").group("components.name").count


# 4. List of products and how many components they each have
SELECT p.name AS product, COUNT(cp.*) AS components
  FROM products p
  JOIN component_products cp ON p.id = cp.product_id
  GROUP BY p.name;

Product.joins("JOIN component_products ON product_id = products.id").group("products.name").count


# 5. Products and components without joins
# a. List of each component_id and how many products it is included in
SELECT component_id, COUNT(product_id)
  FROM component_products
  GROUP BY component_id;

ComponentProduct.group(:component_id).count


# b. List of product_ids and how many components they each have
SELECT product_id, COUNT(component_id)
  FROM component_products
  GROUP BY product_id;

ComponentProduct.group(:product_id).count

# 6. Show a count of all components in product with id 5
SELECT COUNT(*)
  FROM component_products
  WHERE product_id = 5;

ComponentProduct.where('product_id = ?', 5).count
