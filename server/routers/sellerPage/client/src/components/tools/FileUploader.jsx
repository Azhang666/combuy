import React, { useState, useRef } from 'react';


function FileUploader({ onFilesSelect }) {
    const [fileNames, setFileNames] = useState([]);
    const [fileInputs, setFileInputs] = useState([{}]);
    const fileInputRefs = useRef([]);

    const handleFileChange = (index, event) => {
        const file = event.target.files[0];
        const updatedFiles = [...fileInputs];
        const updatedFileNames = [...fileNames];

        // 檢查文件名的正則表達式
        const filenameRegex = /^[a-zA-Z0-9_-]+(\.[a-z]+)?$/;

        if (file && !filenameRegex.test(file.name)) {
            alert('文件名只能包含英文字母、數字、底線。請重新選擇一個有效的文件。');
            event.target.value = '';
            return;
        }

        // 檢查文件類型
        if (file && !file.type.startsWith("image/")) {
            alert('請上傳一個圖片檔。');
            event.target.value = '';
            return;
        }

        if (file) {
            updatedFiles[index] = file;
            updatedFileNames[index] = file.name;  // 更新檔名陣列
            setFileInputs(updatedFiles);
            setFileNames(updatedFileNames);  // 設定更新後的檔名陣列

            if (typeof onFilesSelect === "function") {
                onFilesSelect(updatedFiles.filter(f => f));  // 使用filter確保我們沒有undefined的項目
            }
        }
    };

    const removeFileInput = (indexToRemove) => {
        const updatedFileInputs = fileInputs.filter((_, index) => index !== indexToRemove);
        const updatedFileNames = fileNames.filter((_, index) => index !== indexToRemove);


        console.log('removeFileInput - fileInputs:', updatedFileInputs); // 追踪這裡
        console.log('removeFileInput - fileNames:', updatedFileNames);   // 追踪這裡
        // 重置對應的輸入值
        if (fileInputRefs.current[indexToRemove]) {
            fileInputRefs.current[indexToRemove].value = '';
        }

        setFileInputs(updatedFileInputs);
        setFileNames(updatedFileNames);

        if (typeof onFilesSelect === "function") {
            onFilesSelect(updatedFileInputs.filter(f => f));
        }
    };




    const addNewFileInput = (event) => {
        event.preventDefault(); // 加上這行

        if (fileInputs.length >= 5) {
            alert('最多只能上傳5張圖片！');
            return;
        }
        console.log('addNewFileInput - fileInputs:', [...fileInputs, {}]); // 追踪這裡
        setFileInputs([...fileInputs, {}]);
    };


    return (
        <div className="row align-items-center mt-5">
            <label className="col-1 col-form-label">圖片</label>
            <div className="col">
                {fileInputs.map((_, index) => (
                    <div className="input-group m-1" key={index}>
                        <div className="custom-file">
                            <input
                                type="file"
                                className="custom-file-input"
                                id={`inputGroupFile${index + 1}`}
                                onChange={(e) => handleFileChange(index, e)}
                                accept="image/*"
                                name="productImage"
                                ref={(el) => fileInputRefs.current[index] = el}
                            />

                            <label className="custom-file-label" htmlFor={`inputGroupFile${index + 1}`}>
                                {fileNames[index] || '選擇檔案'}
                            </label>
                        </div>
                        <div className="input-group-append">
                            <button className="btn btn-danger ms-1" type="button" onClick={() => removeFileInput(index)}>取消</button>
                        </div>
                    </div>
                ))}
                {fileInputs.length < 6 && (
                    <button type="button" onClick={(e) => addNewFileInput(e)} className="btn btn-secondary m-1">新增更多圖片</button>

                )}

                <span className="col ms-3">已上傳的圖片數量：{fileNames.length}</span>
            </div>
        </div>
    );
}

export default FileUploader;