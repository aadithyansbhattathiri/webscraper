import { React, useState } from "react";

import useForm from "../../Validators/useForm";
import validate from "../../Validators/FormValidation";
import provider from "../../Services/provider";

function TopBar({ onUpdateCategory, onUpdateProductsList }) {
	const [showDangerAlert, setshowDangerAlert] = useState(false);
	const [showSuccessAlert, setshowSuccessAlert] = useState(false);
	const [message, setMessage] = useState('');
	const { values, errors, handleChange, handleSubmit, resetForm } = useForm(
		createProduct,
		validate
	);

	function createProduct() {
		const data = { url: values.url, provider: values.provider };
		provider.post("/api/products", { data })
			.then((response) => {
				resetForm();
				console.log(response);
				if (response.data.message === 'success') {
					setMessage('Product successfully Imported');
					setshowSuccessAlert(true);
					onUpdateCategory();
					onUpdateProductsList();
				} else if (response.data.message === 'already_exists') {
					setMessage('Product already Imported');
					setshowDangerAlert(true)
				} else if (response.data.message === 'page_not_found') {
					setMessage('Product not found');
					setshowDangerAlert(true)
				}
			})
			.catch((error) => {
				setshowDangerAlert(true)
			});
	}

	return (
		<section className="panel">
			<div className="panel-heading">Fetch Product</div>
			<div className="panel-body">
				{showSuccessAlert &&
					(<div className="alert alert-success"><strong>Success!</strong>&nbsp;{message}</div>)
				}
				{showDangerAlert &&
					(<div className="alert alert-danger"><strong>Oops!</strong>&nbsp;{message}</div>)
				}
				<form className="form-horizontal" onSubmit={handleSubmit} noValidate>
					<div className="form-group">
						<div className="col col-xs-6">
							<label>Enter Product URL</label>
							{errors.url && (
								<label className="text-danger mb-4">{errors.url}</label>
							)}
							<input className="form-control" name="url" onChange={handleChange}
								value={values.url || ""}
								type="text" required />
						</div>
						<div className="col col-xs-6">
							<label>Select Provider</label>
							{errors.provider && (
								<label className="text-danger mb-4">{errors.provider}</label>
							)}
							<select className="form-select form-control"
								name='provider' onChange={handleChange} value={values.provider || ''}
								required>
								<option value="">Select Provider</option>
								<option value="Flipkart">Flipkart</option>
								<option value="Snapdeal">Snapdeal</option>
							</select>

						</div>
					</div>
					<div className="form-group text-center">
						<button className='btn btn-primary'>Import Product</button>
					</div>
				</form>
			</div >
		</section >
	)
}

export default TopBar;