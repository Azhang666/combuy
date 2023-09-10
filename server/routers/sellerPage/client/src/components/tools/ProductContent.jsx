// ProductContent.jsx

import React from 'react';

function ProductContent() {
    return (
        <div className="row mt-5">
            <label className="col-1 align-self-start titlerow">商品內容</label>
            <div className="col">
                <div className="gray3 incontentText titlerow top2-r10px ps-2">庫存與規格</div>
                <div className="container">
                    <div className="row txtara ">
                        <div className="col-md-3 ">
                            <div className='m-2'>
                                <label htmlFor="spec">規格</label>
                                <input type="text" name="spec" id="spec" className="form-control ms-1 input-right-placeholder " placeholder="例如:紅色" />
                            </div>
                        </div>
                        <div className="col-md-3">
                            <div className='m-2'>
                                <label htmlFor="option">選項</label>
                                <input type="text" name="option" id="option" className="form-control ms-1 input-right-placeholder" placeholder="例如:紅色" />
                            </div>
                        </div>
                        <div className="col-md-3">
                            <div className='m-2'>
                                <label htmlFor="quantity">數量</label>
                                <input type="number" name="quantity" id="quantity" className="form-control ms-1" min={"1"} />
                            </div>
                        </div>
                        <div className="col-md-3">
                            <div className='m-2'>
                                <label htmlFor="price">價格</label>
                                <input type="text" name="price" id="price" className="form-control ms-1" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
}

export default ProductContent;
