import {useState} from "react";

const useOrder = () => {
    const [order, setOrder] = useState([]);
    const [total, setTotal] = useState(0);

    const addService = (service) => {
        const filtered = order.filter(item => item.ID === service.ID);

        if(filtered.length > 0) {
            alert("Limit 1 na osobę");
        } else {
            setOrder([
                ...order,
                service
            ]);

            setTotal(total + service.Price);
        }
    }

    const removeService = (id) => {
        const filteredService = order.filter(service => service.ID === id);
        const filteredBasket = order.filter(service => service.ID !== id);
        setOrder([...filteredBasket]);

        setTotal(total - filteredService[0].Price);
    }

    return {
        order,
        setOrder,
        addService,
        removeService,
        total,
        setTotal
    };
}

export default useOrder;
