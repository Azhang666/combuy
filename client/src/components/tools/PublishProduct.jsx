import React, { useState } from 'react';
import axios from 'axios';
import { API_ENDPOINTS } from '../contexts/constants';
import { toast } from 'react-toastify';

function PublishProduct({ productId, specId, fetchProducts, productName }) {
    const [showModal, setShowModal] = useState(false);

    const handlePublish = async (prod_id, spec_id) => {
        try {
            const response = await axios.put(`${API_ENDPOINTS.DOWN}/${productId}/${spec_id}`, { publish: 1 });
            if (response.status === 200) {
                toast.success('商品已上架');
                fetchProducts(); // 刷新商品列表
            } else {
                throw new Error('Server responded with a non-200 status code');
            }
        } catch (error) {
            console.error("在handlePublish中出現錯誤:", error);
            toast.error('上架失敗，請再試一次');
        }
        setShowModal(false);
    }


    return (
        <>
            <div className="publishProduct" onClick={() => setShowModal(true)}>上架</div>
            {showModal && (
                <div className="modal show d-block" tabIndex="-1" style={{ backgroundColor: 'rgba(0,0,0,0.7)' }}>
                    <div className="modal-dialog">
                        <div className="modal-content">
                            <div className="modal-header">
                                <h5 className="modal-title">上架商品</h5>
                                <button type="button" className="btn-close" onClick={() => setShowModal(false)} aria-label="Close"></button>
                            </div>
                            <div className="modal-body">
                                <h4>是否將商品<strong>『{productName}』</strong>上架？</h4>
                            </div>
                            <div className="modal-footer">
                                <button type="button" className="btn btn-primary" onClick={() => handlePublish(productId, specId)}>確定上架</button>
                                <button type="button" className="btn btn-secondary" onClick={() => setShowModal(false)}>取消</button>
                            </div>
                        </div>
                    </div>
                </div>
            )}
        </>
    );
}

export default PublishProduct;
