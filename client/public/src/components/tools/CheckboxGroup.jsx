// CheckboxGroup.jsx

import React, { useState, useEffect } from 'react';
function CheckboxGroup({ title, name, options, onChange }) {
    const [selected, setSelected] = useState([]);
    const [selectAll, setSelectAll] = useState(false);
    const [prevSelected, setPrevSelected] = useState([]);
    const handleCheckboxChange = (value) => {
        let newSelected;

        if (selected.includes(value)) {
            newSelected = selected.filter(item => item !== value);
        } else {
            newSelected = [...selected, value];
        }

        setSelected(newSelected);

        if (newSelected.length === options.length) {
            setSelectAll(true);
        } else {
            setSelectAll(false);
        }
    };

    const handleSelectAllChange = () => {
        if (selectAll) {
            setSelected([]);
            setSelectAll(false);
        } else {
            setSelected(options.map(option => option.value)); // Set all values
            setSelectAll(true);
        }
    };

    useEffect(() => {
        if (JSON.stringify(prevSelected) !== JSON.stringify(selected)) {
            if (selectAll) {
                onChange(name, ["2"]);
            } else {
                onChange(name, selected);
            }
            setPrevSelected(selected);
        }
    }, [selected, onChange, name, selectAll, prevSelected]);

    return (
        <div className="row mt-5 mb-5">
            <label className="col-1 align-self-start titlerow">{title}</label>
            <div className="col">
                <div className="gray3 incontentText titlerow top2-r10px ps-2">方式</div>
                <div className="txtara">
                    <div className="p-3 row">
                        {/* 全選選項 */}
                        <div className="ms-3 col form-check">
                            <input
                                type="checkbox"
                                className="form-check-input"
                                id={`all_${name}`}
                                checked={selectAll}
                                onChange={handleSelectAllChange}
                            />
                            <label className="form-check-label" htmlFor={`all_${name}`}>
                                全選
                            </label>
                        </div>

                        {/* 其他選項 */}
                        {options.map((option, index) => (
                            <div key={index} className="ms-3 col form-check">
                                <input
                                    type="checkbox"
                                    className="form-check-input"
                                    id={option.id}
                                    value={option.value}
                                    checked={selected.includes(option.value)}
                                    onChange={() => handleCheckboxChange(option.value)}
                                />
                                <label className="form-check-label" htmlFor={option.id}>
                                    {option.label}
                                </label>
                            </div>
                        ))}
                    </div>
                </div>
            </div>
        </div>
    );
}



export default CheckboxGroup;
