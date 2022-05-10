import React, {useContext} from "react";
import ShopContextProvider from "../contexts/ShopContext";
import {Link} from "react-router-dom";

export const Services = () => {
    const { services, addService } = useContext(ShopContextProvider);

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
            <div className="services">
                <pre>   Usługa | Cena</pre>
                <ul>
                    { services.map((service) => (
                        <li key={service.ID}>
                            <pre>
                                {service.Name} | {service.Price} |{" "}
                                <button onClick={() => addService(service)}>Dodaj do zamówienia</button>
                            </pre>
                        </li>
                    ))}
                </ul>
            </div>
        </div>
    );
}
