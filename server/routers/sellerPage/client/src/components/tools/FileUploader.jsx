import React, { useState } from 'react';

function FileUploader({ onFilesSelect }) {
    const [fileNames, setFileNames] = useState([]);
    const [fileInputs, setFileInputs] = useState([{}]);

    const handleFileChange = (index, event) => {
        const file = event.target.files[0];
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
            updatedFileNames[index] = file.name;
            setFileNames(updatedFileNames);
    
            if (typeof onFilesSelect === "function") {
                onFilesSelect(file);
            }
        }
    };
    
    const removeFileInput = (indexToRemove) => {
        const updatedFileInputs = fileInputs.filter((_, index) => index !== indexToRemove);
        const updatedFileNames = fileNames.filter((_, index) => index !== indexToRemove);
        
        setFileInputs(updatedFileInputs);
        setFileNames(updatedFileNames);
    };


    const addNewFileInput = () => {
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
                <button onClick={addNewFileInput} className="btn btn-secondary m-1">新增更多圖片</button>
                <span className="col ms-3">已上傳的圖片數量：{fileNames.length}</span>

            </div>
        </div>
    );
}

export default FileUploader;
