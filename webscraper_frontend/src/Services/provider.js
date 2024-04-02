import axios from "axios";

const provider = axios.create({
  baseURL: process.env.REACT_APP_APP_BASE_URL,
});


const responseHandler = (response) => {
  if (response.status === 401 || response.status === 409) {
  }
  return response;
};

const errorHandler = (error) => {
  return Promise.reject(error);
};

provider.interceptors.response.use(
  (response) => responseHandler(response),
  (error) => errorHandler(error)
);

export default provider;
