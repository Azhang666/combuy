import React, { useState, useEffect } from 'react';
import Swal from 'sweetalert2';
import { Triangle as Loader } from 'react-loader-spinner';


function AuthLoader({ onAuthenticated }) {
    const [isAuthenticated, setIsAuthenticated] = useState(false);
    const [isLoading, setIsLoading] = useState(true);
    const [apiCallCompleted, setApiCallCompleted] = useState(false);
    const [navigatingToLogin, setNavigatingToLogin] = useState(false);
    useEffect(() => {
        const timer = setTimeout(() => {
            if (apiCallCompleted) {
                setIsLoading(false);
            }
        }, 2000);
        return () => clearTimeout(timer);
    }, [apiCallCompleted]);

    useEffect(() => {
        // 模擬API呼叫以檢查身份驗證
        fetch('/api/current-user')
            .then(response => {
                if (response.ok) {
                    setIsAuthenticated(true);
                } else if (response.status === 401) {
                    setIsAuthenticated(false);
                    Swal.fire({
                        title: '未授權!',
                        text: '請先登入才能訪問此頁面。',
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: '去登入',
                        cancelButtonText: '取消'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            setNavigatingToLogin(true);
                            setTimeout(() => {
                                window.location.href = 'http://localhost:2407/login';
                            }, 2000);
                        }
                    });
                }
                setApiCallCompleted(true);
            })
            .catch(error => {
                console.error('Error checking authentication:', error);
                setApiCallCompleted(true);
            });

    }, []);

    useEffect(() => {
        if (apiCallCompleted && !isLoading) {
            setIsLoading(false);
        }
    }, [apiCallCompleted, isLoading]);

    if (isLoading) {
        return (
            <div style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '100vh' }}>
                <Loader type="Puff" color="#00BFFF" height={100} width={100} />
            </div>
        );
    }
    if (navigatingToLogin) {
        return (
            <div style={{ display: 'flex', flexDirection: 'column', justifyContent: 'center', alignItems: 'center', height: '100vh' }}>
                <Loader type="Puff" color="#00BFFF" height={100} width={100} />
                <b style={{ marginTop: '20px' }}>跳轉頁面中</b>
            </div>
        );
    }


    if (!isAuthenticated) {
        // 如果不希望在這裡立即重定向，您可以僅顯示提示或其他內容。
        return null;
    }

    onAuthenticated();

    return null;

}

export default AuthLoader;