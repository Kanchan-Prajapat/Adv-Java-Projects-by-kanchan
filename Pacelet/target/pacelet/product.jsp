<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>

    <title>Pacelet Products</title>

    <style>

        body {
            font-family: Arial, sans-serif;
            background: #f7f9fd;
            margin: 0;
            padding: 40px;
            color: #191c1f;
        }

        h1 {
            margin-bottom: 30px;
        }

        .products {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 24px;
        }

        .product {
            background: white;
            padding: 20px;
            border-radius: 12px;
        }

        .product img {
            width: 100%;
            height: 260px;
            object-fit: cover;
            border-radius: 8px;
        }

        .product h2 {
            margin-bottom: 5px;
        }

        .subtitle {
            color: #666;
        }

        .price {
            font-size: 20px;
            font-weight: bold;
            margin-top: 15px;
        }

        .original-price {
            color: #888;
            text-decoration: line-through;
            margin-left: 8px;
            font-size: 14px;
        }

        .badge {
            display: inline-block;
            margin-top: 10px;
            padding: 5px 10px;
            background: #191c1f;
            color: white;
            font-size: 12px;
            border-radius: 4px;
        }

    </style>

</head>

<body>

    <h1>Pacelet Products</h1>

    <div class="products">

        <%
            java.util.List<com.pacelet.model.Product> products =
                    (java.util.List<com.pacelet.model.Product>)
                    request.getAttribute("products");

            for (com.pacelet.model.Product product : products) {
        %>

            <div class="product">

                <img
                    src="<%= product.getImages().get(0) %>"
                    alt="<%= product.getName() %>"
                >

                <span class="badge">
                    <%= product.getBadge() %>
                </span>

                <h2>
                    <%= product.getName() %>
                </h2>

                <p class="subtitle">
                    <%= product.getSubtitle() %>
                </p>

                <p>
                    <%= product.getDescription() %>
                </p>

                <div class="price">

                    ₹<%= product.getPrice() %>

                    <span class="original-price">
                        ₹<%= product.getOriginalPrice() %>
                    </span>

                </div>

            </div>

        <%
            }
        %>

    </div>

</body>
</html>