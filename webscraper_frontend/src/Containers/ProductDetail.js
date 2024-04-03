import { React, useEffect, useState } from 'react';
import { useParams } from 'react-router-dom';
import provider from "../Services/provider";
import { Link } from 'react-router-dom';

function ProductDetail() {
	const [product, setProduct] = useState({});
	const [properties, setProperty] = useState([])
	const { id } = useParams();

	useEffect(() => {
		fetchProduct(id)
	}, [id]);

	function fetchProduct(productId) {
		provider.get("/api/products/" + productId)
			.then((response) => {
				setProduct(response.data.data);
				setProperty(response.data.data.properties)
			})
			.catch((error) => {
			});
	}

	const handleClick = (event, productId) => {
		event.preventDefault();
		console.log(productId);
		const data = { url: product.product_url, provider: product.provider };
		console.log(data);
		provider.put("/api/products/" + productId, { data })
			.then((response) => {
					//fetchProduct(productId)
					setProduct(response.data.data);
				setProperty(response.data.data.properties)
			})
			.catch((error) => {
			});
	};

	return (
		<div className="container bootdey">
			<section className="panel">
				<div className="panel-heading">
					<Link to={`/`} >
						{"Home > "}
					</Link>
					Product Details</div>
				<div className="panel-body">
					<div className="container">
						<div className="card">
							<div className="container-fliud">
								<div className="wrapper row">
									<div className="preview col-md-6">
										<div className="preview-pic ">
											<div className="tab-pane active" id="pic-1"><img src={product.product_image_url} width="513px" height="343px" alt={product.name} /></div>
										</div>
									</div>
									<div className="details col-md-5">
										<div className="rating">
											<span className="badge badge-pill badge-primary">{product.provider}</span>
										</div>
										<h3 className="product-title">{product.name}</h3>
										<h5 className="price">Category: <span> {product.category}</span></h5>
										<div className="rating">
											<span className="badge badge-pill badge-info">{product.rating} stars</span>
										</div>
										<p></p>
										<p className="product-description">{product.description}</p>
										<h4 className="price">current price: <span>Rs. {product.price}</span></h4>
										<div className="product-properties">
											{properties.map((property, index) => (
												<div key={index}>
													<h5>{property.display}:</h5>
													<ul>
														{property.data.map((value, subIndex) => (
															<li key={subIndex}>{value}</li>
														))}
													</ul>
												</div>
											))}
										</div>
										<div className="form-group text-center">
											<button onClick={(e) => handleClick(e, product.id)} className='btn btn-primary'>Refetch</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>
	);
}

export default ProductDetail;
