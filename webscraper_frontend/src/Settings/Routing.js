import React from 'react'
import { Routes, Route } from "react-router-dom";
import Dashboard from '../Containers/Dashboard';
import ProductDetail from '../Containers/ProductDetail';

function Routing() {
	return (
		<Routes>
			<Route path="/" element={<Dashboard />} />
			<Route path="/product/:id" element={<ProductDetail />} />
		</Routes>
	)
}
export default Routing;
