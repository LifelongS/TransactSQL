--Выбрать через JOIN поставщиков, у которых не было сделано ни одного заказа.
SELECT PS.*
FROM Purchasing.Suppliers AS PS
LEFT JOIN Purchasing.PurchaseOrders AS PPO ON PS.SupplierID=PPO.SupplierID
WHERE PPO.PurchaseOrderID IS NULL