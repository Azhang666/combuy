import React, { useState } from 'react';
import FileUploader from '../tools/FileUploader';
import CategoryMenu from '../tools/CategoryMenu';
import CheckboxGroup from '../tools/CheckboxGroup';
import LaptopSpecifications from '../tools/LaptopSpecifications';
import ProductContent from '../tools/ProductContent';
import axios from 'axios';

function AddProduct() {
    const [productName, setProductName] = useState('');
    const [file, setFile] = useState(null);
    const [brandId, setBrandId] = useState('');  // Brand state
    const [categoryId, setCategoryId] = useState('');  // Category state
    const [payment, setPayment] = useState([]);
    const [transport, setTransport] = useState([]);

    const handleSaveAndPublish = async () => {
        try {
            const formData = new FormData();

            // Append product data to formData
            formData.append('productData[user_id]', 1);
            formData.append('productData[prod_name]', productName);
            formData.append('productData[brand_id]', brandId);
            formData.append('productData[category_id]', categoryId);
            formData.append('productData[transport]', transport);
            formData.append('productData[payment]', payment);

            if (file) {
                formData.append('productImage', file);
            }

            const response = await axios.post('http://localhost:2407/createProduct', formData);

            if (response.data.success) {
                alert('商品儲存並上架成功！');
            } else {
                alert('操作失敗，請再試一次。');
            }
        } catch (error) {
            console.error("Error while saving and publishing product:", error);
            alert('操作失敗，請再試一次。');
        }
    }

    const handleFileSelect = (file) => {
        setFile(file);
    };
    const handleCheckboxGroupChange = (name, values) => {
        if (name === "payment") {
            if (values === "2") {
                setPayment(["0", "1"]); // "銀行或郵局轉帳"的值為"0"，"信用卡(一次付清)"的值為"1"
            } else {
                setPayment(values);
            }
        } else if (name === "transport") {
            if (values === "2") {
                setTransport(["0", "1"]); // "郵寄寄送"的值為"0"，"宅配/快遞"的值為"1"
            } else {
                setTransport(values);
            }
        }
    };

    const saveCheck = async () => {
        console.log(file);
    
        const formData = new FormData(); // 創建一個 FormData 物件
        

        
        // 將商品數據加入到 FormData 中
        formData.append('user_id', 1); // 可能需要動態設定此值
        formData.append('prod_name', productName);
        formData.append('brand_id', brandId);
        formData.append('category_id', categoryId);
        formData.append('transport', transport.join(', ')); 
        formData.append('payment', payment.join(', '));
        
        // 將文件加入到 FormData 中
        formData.append('productImage', file);
    
        // 發送請求
        try {
            const response = await axios.post('http://localhost:2407/createProduct', formData, {
                headers: {
                    'Content-Type': 'multipart/form-data' // 這是必須的，確保伺服器知道這是一個文件上傳請求
                }
            });
    
            if (response.data.success) {
                alert('商品儲存並上架成功！');
            } else {
                alert('操作失敗，請再試一次。');
            }
        } catch (error) {
            console.error("儲存和發佈商品時出現錯誤:", error);
            alert('操作失敗，請再試一次。');
        }
    }
    
    

    // const handleBrandIdUpdate = (brandId) => {
    //     console.log("Received brand ID in AddProduct component:", brandId);
    //     setBrandId(brandId);
    // };



    return (
        <div>
            {/* ... (Keep the other parts unchanged) */}

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

                <FileUploader onFileSelect={handleFileSelect} />

                
                {/* 商品類別 */}
                <div className="row align-items-center mt-5">
                    <label className="col-1">商品類別</label>
                    <div className="menu col">
                        <CategoryMenu
                            // onCategorySelect={(categoryName, categoryId) => setCategoryId(categoryId)}  // Fixed
                            onCategorySelect={(categoryName, categoryId) => setCategoryId(categoryId)}

                            onBrandSelect={(brandId, brandName) => setBrandId(brandId)}
                        // Fixed

                        />
                    </div>
                </div>

                {/* 若商品類別為筆電，則渲染規格輸入框 */}
                <LaptopSpecifications isVisible={categoryId === 1} />

                {/* 商品描述 */}
                <div className="row mt-5">
                    <label className="col-1 align-self-start titlerow">商品描述</label>
                    <div className="col">
                        <div className="gray3 incontentText titlerow top2-r10px ps-2">描述內容</div>
                        <textarea className="form-control txtara" rows={4} defaultValue={""} />
                    </div>
                </div>

                {/* 庫存與規格 */}
                <ProductContent />

                {/* 付款和運送方式*/}
                <>
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
                            { id: "courier_delivery", label: "宅配/快遞", value: "1" },

                        ]}
                        onChange={handleCheckboxGroupChange}
                    />

                </>


                {/* ... (Keep the other parts unchanged) */}
            </div>
            <nav className="gray2 conarae d-flex justify-content-end align-items-center ">
                <button style={{ marginRight: '16px' }} className="btn btn-danger mt-1">取消</button>
                <button style={{ marginRight: '16px' }} className="btn btn-info mt-1" onClick={saveCheck}>儲存</button>

                <button className="btn btn-success mt-1" onClick={handleSaveAndPublish}>儲存並上架</button>
            </nav>
            {/* ... (Keep the other parts unchanged) */}
        </div>
    );
}

export default AddProduct;
