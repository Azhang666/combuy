// import React, { useState, useCallback } from 'react';
// import { useNavigate } from 'react-router-dom';


// import FileUploader from '../tools/FileUploader';
// import CategoryMenu from '../tools/CategoryMenu';
// import CheckboxGroup from '../tools/CheckboxGroup';
// import LaptopSpecifications from '../tools/LaptopSpecifications';
// import ProductContent from '../tools/ProductContent';
// import axios from 'axios';
// import { API_ENDPOINTS, PAYMENT_OPTIONS, TRANSPORT_OPTIONS, FAILSTEXT, USER_ID } from '../contexts/constants';

// function AddProduct() {
//     // 產品資訊
//     const [productName, setProductName] = useState('');
//     const [mainImageIdx, setMainImageIndex] = useState('0');
//     const [files, setFiles] = useState([]);
//     const [brandId, setBrandId] = useState('');
//     const [categoryId, setCategoryId] = useState('');
//     const [payment, setPayment] = useState([]);
//     const [transport, setTransport] = useState([]);

//     const handleLaptopSpecsUpdate = (updatedForm) => {
//         setLaptopSpecs(prevSpecs => ({
//             ...prevSpecs,
//             ...updatedForm
//         }));
//     };
//     // 產品規格
//     const [laptopSpecs, setLaptopSpecs] = useState({
//         cpu: '',
//         gpu: '',
//         ram: '',
//         os: '',
//         screen: '',
//         battery: '',
//         warranty: '',
//         size: '',
//         weight: '',
//         price: '',
//         description: ''
//     });


//     // 這個函數用來建立和填充FormData
//     const createFormData = (publishValue) => {
//         const formData = new FormData();

//         // Append files
//         files.forEach((f) => {
//             formData.append('productImage', f);
//         });

//         // Append laptop specifications
//         Object.keys(laptopSpecs).forEach(key => {
//             formData.append(`productData[${key}]`, laptopSpecs[key]);
//         });

//         // Append other product data
//         formData.append('productData[user_id]', USER_ID);
//         formData.append('productData[prod_name]', productName);
//         formData.append('productData[brand_id]', brandId);
//         formData.append('productData[category_id]', categoryId);
//         formData.append('productData[transport]', transport.join(', '));
//         formData.append('productData[payment]', payment.join(', '));
//         formData.append('mainImageIdx', mainImageIdx);
//         formData.append('productData[publish]', publishValue);
//         return formData;
//     };

//     const handleSaveProduct = async (shouldPublish) => {
//         const publishValue = shouldPublish ? 1 : 0;
//         console.log("Laptop Specs:", laptopSpecs);
//         console.log(productName, brandId, categoryId, transport.join(', '), payment.join(', '), files);
//         console.log('---------------------');
//         console.log('---------------------');
//         console.log('---------------------');

//         console.log(publishValue);

//         try {
//             const formData = createFormData(publishValue);
//             const response = await axios.post(API_ENDPOINTS.CREATE_PRODUCT, formData);

//             if (response.data.success) {
//                 alert(publishValue ? '商品儲存並上架成功！' : '商品儲存成功！');
//             } else {
//                 alert(FAILSTEXT);
//             }
//         } catch (error) {
//             console.error("Error while saving the product:", error);
//             alert(FAILSTEXT);
//         }
//     };


//     const navigate = useNavigate();

//     const handleCancel = () => {
//         navigate('/');
//     };

//     const handleFilesSelect = useCallback((selectedFiles) => {
//         setFiles(selectedFiles);
//     }, []);


//     const handleCheckboxGroupChange = useCallback((name, values) => {
//         if (name === "payment") {
//             setPayment(values === "2" ? ["0", "1"] : values);
//         } else if (name === "transport") {
//             setTransport(values === "2" ? ["0", "1"] : values);
//         }
//     }, []);

//     const handleFormSubmit = (e) => {
//         e.preventDefault();
//         handleSaveProduct();
//     };

//     return (
//         <div>
//             <form onSubmit={handleFormSubmit}>
//                 <div className="top2 incontentText p-4">
//                     <div className="row align-items-center mt-2">
//                         <label className="col-1 ms-1">商品名稱</label>
//                         <div className="col">
//                             <input
//                                 type="text"
//                                 className="form-control inputS"
//                                 value={productName}
//                                 onChange={(e) => setProductName(e.target.value)}
//                                 name='productName'
//                             />
//                         </div>
//                     </div>
//                     <FileUploader
//                         onFilesSelect={handleFilesSelect}
//                         mainImageIndex={mainImageIdx}
//                         onMainImageChange={index => setMainImageIndex(index)}
//                     />



//                     <CategoryMenu
//                         onCategorySelect={(categoryName, categoryId) => setCategoryId(categoryId)}
//                         onBrandSelect={(brandId, brandName) => setBrandId(brandId)}
//                     />

//                     <LaptopSpecifications
//                         isVisible={categoryId === 1}
//                         onSpecificationsChange={setLaptopSpecs}
//                     />

//                     <ProductContent
//                         onUpdateForm={handleLaptopSpecsUpdate}
//                     />
//                     <CheckboxGroup
//                         title="收款方式"
//                         name="payment"
//                         options={PAYMENT_OPTIONS}
//                         onChange={handleCheckboxGroupChange}
//                     />

//                     <CheckboxGroup
//                         title="運送方式"
//                         name="transport"
//                         options={TRANSPORT_OPTIONS}
//                     />

//                 </div>
//                 <nav className="gray2 conarae d-flex justify-content-end align-items-center ">
//                     <button style={{ marginRight: '16px' }} className="btn btn-danger mt-1" onClick={handleCancel}>取消</button>
//                     <button
//                         className="btn btn-success mt-1"
//                         onClick={() => handleSaveProduct(false)}
//                         type="button">
//                         儲存
//                     </button>
//                     <button type='button' style={{ marginLeft: '16px' }} className="btn btn-primary mt-1"
//                         onClick={() => handleSaveProduct(true)}>
//                         儲存並上架
//                     </button>
//                 </nav>
//             </form>
//         </div>
//     );
// }

// export default AddProduct;
