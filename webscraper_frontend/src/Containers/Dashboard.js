import { React, useState } from "react";
import Header from "../Components/Header/Header";
import Category from "../Components/Categories/Category"
import TopBar from "../Components/TopBar/TopBar";
import Product from "../Components/Products/Product";

function Dashboard() {
	const [updateCategory, setUpdateCategory] = useState(false);
	const [updateProducts, setUpdateProducts] = useState(null);
	const [reloadProducts, setReloadProducts] = useState(false);
	const [searchKeyword, setSearchKeyword] = useState(null);
	const handleUpdateCategory = () => {
		setUpdateCategory(!updateCategory);
		setUpdateProducts(null);
	};

	const handleUpdateProducts = (categoryId) => {
		setUpdateProducts(categoryId);
	}

	const updateProductList = () => {
		setReloadProducts(!reloadProducts);
	}

	const handleSearchTerm = (searchTerm) => {
		setSearchKeyword(searchTerm);
		setReloadProducts(!reloadProducts);
	}

	return (
		<div className="container bootdey">
			<div className="col-md-3">
				<Header onSearchKeyword={handleSearchTerm} />
				<Category key={updateCategory} onUpdateProducts={handleUpdateProducts} />
			</div>
			<div className="col-md-9">
				<TopBar onUpdateCategory={handleUpdateCategory} onUpdateProductsList={updateProductList} />
				<div className="row product-list">
					<Product key={reloadProducts} category={updateProducts} searchKeyword={searchKeyword}/>
				</div>
			</div>
		</div>

	)
}
export default Dashboard;