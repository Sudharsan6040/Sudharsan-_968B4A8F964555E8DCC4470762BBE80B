def linear_search_product(product_list, target_product):
    indices = []
    for i, product in enumerate(product_list):
        if product == target_product:
            indices.append(i)
    return indices

# Example usage
products = ['Apple', 'Banana', 'Orange', 'Apple', 'Grapes', 'Apple']
target_product = 'Apple'
indices = linear_search_product(products, target_product)
print("Indices of", target_product, ":", indices)
