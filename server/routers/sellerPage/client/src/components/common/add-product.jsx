import React, { useState } from 'react';
import FileUploader from '../tools/FileUploader';
import CategoryMenu from '../tools/CategoryMenu';
import CheckboxGroup from '../tools/CheckboxGroup';
import LaptopSpecifications from '../tools/LaptopSpecifications';
import ProductContent from '../tools/ProductContent';
import axios from 'axios';

function AddProduct() {
    const [productName, setProductName] = useState('');
    
    const [files, setFiles] = useState([]);
    const [brandId, setBrandId] = useState('');
    const [categoryId, setCategoryId] = useState('');
    const [payment, setPayment] = useState([]);
    const [transport, setTransport] = useState([]);

    const handleSaveProduct = async (publish = false) => {
        try {
            const formData = new FormData();
            files.forEach((f) => {
                formData.append('productImage', f);
             });

            // Append product data to formData
            formData.append('productData[user_id]', 1);
            formData.append('productData[prod_name]', productName);
            formData.append('productData[brand_id]', brandId);
            formData.append('productData[category_id]', categoryId);
            formData.append('productData[transport]', transport.join(', '));
            formData.append('productData[payment]', payment.join(', '));

            console.log(productName);
            console.log(brandId);
            console.log(categoryId);
            console.log(transport.join(', '));
            console.log(payment.join(', '));
            console.log(files);
            
            
            const response = await axios.post('http://localhost:2407/createProduct', formData);


            if (response.data.success) {
                alert(publish ? '商品儲存並上架成功！' : '商品儲存成功！');
            } else {
                alert('操作失敗，請再試一次。');
            }
        } catch (error) {
            console.error("Error while saving the product:", error);
            alert('操作失敗，請再試一次。');
        }
    };

    const handleCancel = () => {
        window.location.href = 'http://localhost:3000/';
    };

    const handleFilesSelect = (selectedFiles) => {
        setFiles(selectedFiles);
    };

    const handleCheckboxGroupChange = (name, values) => {
        if (name === "payment") {
            setPayment(values === "2" ? ["0", "1"] : values);
        } else if (name === "transport") {
            setTransport(values === "2" ? ["0", "1"] : values);
        }
    };

    const handleFormSubmit = (e) => {
        e.preventDefault();
        handleSaveProduct();
    };

    return (
        <div>
            <form onSubmit={handleFormSubmit}>
                <div className="top2 incontentText p-4">
                    <div className="row align-items-center mt-2">
                        <label className="col-1">商品名稱</label>
                        <div className="col">
                            <input
                                type="text"
                                className="form-control inputS"
                                value={productName}
                                onChange={(e) => setProductName(e.target.value)}
                                name='productName'
                            />
                        </div>
                    </div>
                    <FileUploader onFilesSelect={handleFilesSelect} />
                    <div className="row align-items-center mt-5">
                        <label className="col-1">商品類別</label>
                        <div className="menu col">
                            <CategoryMenu
                                onCategorySelect={(categoryName, categoryId) => setCategoryId(categoryId)}
                                onBrandSelect={(brandId, brandName) => setBrandId(brandId)}
                            />
                        </div>
                    </div>
                    <LaptopSpecifications isVisible={categoryId === '1'} />
                    <div className="row mt-5">
                        <label className="col-1 align-self-start titlerow">商品描述</label>
                        <div className="col">
                            <div className="gray3 incontentText titlerow top2-r10px ps-2">描述內容</div>
                            <textarea className="form-control txtara" rows={4} defaultValue={""} />
                        </div>
                    </div>
                    <ProductContent />
                    <CheckboxGroup
                        title="收款方式"
                        name="payment"
                        options={[
                            { id: "bank_transfer", label: "銀行或郵局轉帳", value: "0" },
                            { id: "credit_card", label: "信用卡(一次付清)", value: "1" }
                        ]}
                        onChange={handleCheckboxGroupChange}
                    />
                    <CheckboxGroup
                        title="運送方式"
                        name="transport"
                        options={[
                            { id: "postal_delivery", label: "郵寄寄送", value: "0" },
                            { id: "courier_delivery", label: "宅配/快遞", value: "1" }
                        ]}
                        onChange={handleCheckboxGroupChange}
                    />
                </div>
                <nav className="gray2 conarae d-flex justify-content-end align-items-center ">
                    <button style={{ marginRight: '16px' }} className="btn btn-danger mt-1" onClick={handleCancel}>取消</button>
                    <button className="btn btn-success mt-1" type="submit">儲存</button>
                    <button type='button' style={{ marginLeft: '16px' }} className="btn btn-primary mt-1" onClick={() => handleSaveProduct(true)}>儲存並上架</button>
                </nav>
            </form>
        </div>
    );
}

export default AddProduct;
