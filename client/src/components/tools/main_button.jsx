import React, { useState } from 'react';
import axios from 'axios';
import { API_ENDPOINTS } from '../contexts/constants';
import { toast } from 'react-toastify';
function MainButton({ productId, specId, fetchProducts, productName }) {
    const [showModal, setShowModal] = useState(false);
    const [isUnpublished] = useState(false);

    const handleUnpublish = async () => {
        console.log(productId);

        try {
            await axios.put(`${API_ENDPOINTS.DOWN}/${productId}/${specId}`, { publish: 0 });

            // 使用 react-toastify 來顯示成功提示
            toast.success('商品已下架');

            fetchProducts(); // 刷新商品列表
        } catch (error) {
            console.error("Error in handleUnpublish:", error);

            // 使用 react-toastify 來顯示錯誤提示
            toast.error('下架失敗，請再試一次');
        }
        setShowModal(false);
    }


    if (isUnpublished) {
        return null; // 如果商品已經下架，不再顯示這個元件
    }

    return (
        <>
            <div className="delData1" onClick={() => setShowModal(true)}>下架</div>

            {showModal && (
                <div className="modal show d-block" tabIndex="-1" style={{ backgroundColor: 'rgba(0,0,0,0.7)' }}>
                    <div className="modal-dialog">
                        <div className="modal-content">
                            <div className="modal-header">
                                <h5 className="modal-title">下架商品</h5>
                                <button type="button" className="btn-close" onClick={() => setShowModal(false)} aria-label="Close"></button>
                            </div>
                            <div className="modal-body">
                                <h4>是否將商品<strong>『{productName}』</strong>下架？</h4>
                            </div>
                            <div className="modal-footer">
                                <button type="button" className="btn btn-primary" onClick={() => handleUnpublish(productId, specId)}>確定下架</button>
                                <button type="button" className="btn btn-secondary" onClick={() => setShowModal(false)}>取消</button>
                            </div>
                        </div>
                    </div>
                </div>
            )}
        </>
    );
}

export default MainButton;
