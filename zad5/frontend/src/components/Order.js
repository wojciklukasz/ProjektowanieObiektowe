import React, {useContext} from "react";
import {Link} from "react-router-dom";
import ShopContextProvider from "../contexts/ShopContext";

export const Order = () => {
    const { order, removeService, total } = useContext(ShopContextProvider)

    return (
        <div>
            <nav
                style={{
                    borderBottom: "solid 1px",
                    paddingBottom: "1rem",
                }}
            >
                <Link to="/">Strona główna</Link> |{" "}
                <Link to="/services/">Usługi</Link> |{" "}
                <Link to="/order/">Zamówienie</Link>
            </nav>
            <div className="service">
                <pre>   Usługa | Cena</pre>
                <ul>
                    { order.map((service) => (
                        <li key={service.ID}>
                            <pre>
                                {service.Name} | {service.Price} |{" "}
                                <button onClick={() => removeService(service.ID)}>Usuń z zamówienia</button>
                            </pre>
                        </li>
                    ))}
                </ul>
                <pre>   Do zapłaty: {total}</pre>
                <Link to="/payment/">Do kasy</Link>
            </div>
        </div>
    );
}
