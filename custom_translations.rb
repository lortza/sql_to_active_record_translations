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

# this is the closest I can get
Component.includes(:manufacturer).select(:id, :name, :manufacturer_id).find(1).prices
# and this
Price.where(component_id: Component.includes(:manufacturer).find(1).id)

# but i want something like this (which doesn't work)
Component.includes(:manufacturer).find(1).prices.select(c.name, m.name, p.qty, ((p.cost_each + p.shipping_each) * qty) AS total)


# 2. Show a list of manufacturer names and a count of all components they make
SELECT m.name, COUNT(c.manufacturer_id)
  FROM components c
  JOIN manufacturers m ON m.id = c.manufacturer_id
  GROUP BY m.name;

# this is the closest I can get
Component.includes(:manufacturer).select(:name).group(:manufacturer_id).count
#  => {4=>1, 1=>5, 5=>1, 3=>1, 6=>2, 2=>1}

# but I want to get something like this (which doesn't work)
Component.includes(:manufacturer).group('manufacturer.name').count
#  => {'MPC'=>1, 'The Game Crafter'=>5, 'Party Spin'=>1, 'AZ-Cover'=>1, 'Aspire'=>2, 'MFLABEL'=>1}

# and will settle for
sql = "SELECT m.name, COUNT(c.manufacturer_id)
        FROM components c
        JOIN manufacturers m ON m.id = c.manufacturer_id
        GROUP BY m.name;"
records = ActiveRecord::Base.connection.execute(sql).to_a


# 3. List of each component and how many products it is included in
SELECT c.name AS component, COUNT(cp.*) AS products
  FROM components c
  JOIN component_products cp ON c.id = cp.component_id
  GROUP BY c.name;

# this is the closest I can get
Component.all.map { |c| {name: c.name, products: c.products.count} }


# 4. List of products and how many components they each have
SELECT p.name AS product, COUNT(cp.*) AS components
  FROM products p
  JOIN component_products cp ON p.id = cp.product_id
  GROUP BY p.name;

# this is the closest I can get
Product.all.map { |p| {name: p.name, components: p.components.count} }


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

