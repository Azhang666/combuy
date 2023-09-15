// LaptopSpecifications.jsx

import React from 'react';
import { CSSTransition } from 'react-transition-group';

function LaptopSpecifications({ isVisible }) {
    return (
        isVisible && (
            <CSSTransition
                in={isVisible}
                timeout={3000}
                classNames="fade"
                unmountOnExit
            >
                <div className="row mt-5 ">
                    <label className="col-1 align-self-start titlerow">商品規格</label>

                    <div className="col">
                        <div className="gray3 incontentText titlerow top2-r10px ps-2">庫存與規格</div>
                        <div className="txtara">
                            <div className="container">
                                <div className="row">
                                    <div className="col-md-4">
                                        <div>
                                            <label className='mt-3'>處理器 (CPU):</label>
                                            <input type="text" name="cpu" placeholder="輸入處理器規格" className="form-control " />
                                        </div>
                                        <div>
                                            <label className='mt-3'>顯示卡 (GPU):</label>
                                            <input type="text" name="gpu" placeholder="輸入顯示卡規格" className="form-control " />
                                        </div>
                                        <div>
                                            <label className='mt-3'>記憶體 (RAM):</label>
                                            <input type="text" name="ram" placeholder="輸入記憶體規格" className="form-control" />
                                        </div>
                                    </div>
                                    <div className="col-md-4">
                                        <div>
                                            <label className='mt-3'>作業系統 (OS):</label>
                                            <input type="text" name="os" placeholder="輸入作業系統版本" className="form-control" />
                                        </div>
                                        <div>
                                            <label className='mt-3'>螢幕 (Screen):</label>
                                            <input type="text" name="screen" placeholder="輸入螢幕規格" className="form-control" />
                                        </div>
                                        <div>
                                            <label className='mt-3'>電池 (Battery):</label>
                                            <input type="text" name="battery" placeholder="輸入電池資訊" className="form-control" />
                                        </div>
                                    </div>
                                    <div className="col-md-4">
                                        <div>
                                            <label className='mt-3'>保固期 (Warranty):</label>
                                            <input type="text" name="warranty" placeholder="輸入保固期資訊" className="form-control" />
                                        </div>
                                        <div>
                                            <label className='mt-3'>尺寸 (Size):</label>
                                            <input type="text" name="size" placeholder="輸入尺寸資訊" className="form-control" />
                                        </div>
                                        <div>
                                            <label className='mt-3'>重量 (Weight):</label>
                                            <input type="text" name="weight" placeholder="輸入重量資訊" className="form-control" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>

                </div>
            </CSSTransition>
        )
    );
}

export default LaptopSpecifications;
