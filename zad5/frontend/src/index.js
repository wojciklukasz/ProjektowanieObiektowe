import React from "react";
import ReactDOM from "react-dom/client";
import {BrowserRouter, Routes, Route} from "react-router-dom";
import App from "./App";
import {ShopContextProvider} from "./contexts/ShopContext";
import {Services} from "./components/Services";
import {Order} from "./components/Order"
import {Payment} from "./components/Payment";

const root = ReactDOM.createRoot(
    document.getElementById("root")
);
root.render(
    <ShopContextProvider>
        <BrowserRouter>
            <Routes>
                <Route path="/" element={<App />} />
                <Route path="services" element={<Services />} />
                <Route path="order" element={<Order />} />
                <Route path="payment" element={<Payment />} />
            </Routes>
        </BrowserRouter>
    </ShopContextProvider>
);
