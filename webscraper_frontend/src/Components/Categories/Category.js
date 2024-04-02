import React, { useState, useEffect } from 'react';
import provider from "../../Services/provider";

function Category({ onUpdateProducts }) {
	const [categories, setCategories] = useState([]);
	const [isLoading, setIsLoading] = useState(true);

	useEffect(() => {
		provider.get("/api/products/categories")
			.then((response) => {
				setCategories(response.data.data);
				setIsLoading(false);
			})
			.catch((error) => {
				console.error(error);
				setIsLoading(false);
			});
	}, []);

	const handleClick = (event, categoryId) => {
		event.preventDefault();
		onUpdateProducts(categoryId);
	};

	return (
		<section className="panel">
			<header className="panel-heading">
				Category
			</header>
			<div className="panel-body">
				{isLoading ? (
					<p>Loading categories...</p>
				) : categories.length === 0 ? (
					<p>No categories available</p>
				) : (
					<ul className="nav prod-cat">
						<li key="A">
								<a href="/#" onClick={(e) => handleClick(e, 0)}>
									<i className="fa fa-angle-right"></i> All
								</a>
							</li>
						{categories.map((category, index) => (
							<li key={index}>
								<a href="/#" onClick={(e) => handleClick(e, category.id)}>
									<i className="fa fa-angle-right"></i> {category.name} ({category.total_products})
								</a>
							</li>
						))}
					</ul>
				)}
			</div>
		</section>
	);
}

export default Category;
