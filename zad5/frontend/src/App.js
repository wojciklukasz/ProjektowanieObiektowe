import React from "react";
import { Link } from "react-router-dom";

export default function App() {
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
                <Link to="/order/">Zamówienia</Link>
            </nav>
            <h1>
                <center>
                    Aplikacja na Projektowanie Obiektowe
                </center>
            </h1>
        </div>
    );
}
