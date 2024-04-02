import React, { useState, useEffect, useCallback } from 'react';
import provider from "../../Services/provider";
import { Link } from 'react-router-dom';

function Product({ category, searchKeyword }) {
	const [products, setProducts] = useState([]);

	const fetchData = useCallback(() => {
		console.log(searchKeyword);
		let url = "/api/products";
		if (category !== null) {
			url = "/api/products?category=" + category;
		}
		if (searchKeyword != null) {
			url = "/api/products?search=" + searchKeyword; // Corrected typo from "serch" to "search"
		}
		provider.get(url)
			.then((response) => {
				setProducts(response.data.data);
			})
			.catch((error) => {
				console.error(error);
			});
	}, [category, searchKeyword]); // Include searchTerm in the dependency array

	useEffect(() => {
		fetchData();
	}, [fetchData]);

	return (
		<div className="row">
			{products.map((product, index) => (
				<div key={index} className="col-md-4">
					<section className="panel">
						<div className="panel-body">
							<div className="pro-img-box">
								<img alt={product.name} src={product.product_image_url} width="255px" height="220px" />
							</div>
							<div className='row'>
								<div className='col col-lg-12'>
									<Link to={`/product/${product.id}`}>{product.name.substring(0, 62) + '...'}</Link>
								</div>
							</div>
							<div className='row'>
							<div className='col col-lg-6'>
									<p className="badge badge-pill badge-info">{product.rating} Stars</p>
								</div>
								<div className='col col-lg-6'>
									<p className="badge badge-pill badge-primary  pull-right">{product.provider}</p>
								</div>
							</div>
							<div className='row'>
								<div className='col col-lg-12'>
								<p className="price">Rs. {product.price}</p>
									</div>	
							</div>
							
							
							<div className='row'>
							<div className='col col-lg-12 text-center'>
									<Link to={`/product/${product.id}`} className='btn btn-primary'>View Details</Link>
								</div>
							</div>
							
						</div>
					</section>
				</div>
			))}
		</div>
	);
}

export default Product;
