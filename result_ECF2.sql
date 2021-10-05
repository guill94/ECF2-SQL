/*******3. MANIPULATIONS********/

/*******3.1 Interrogations - Requêtes********/


/*******(1)*******/
SHOW TABLE STATUS;

/*
Nombres d'enregistrements :

Customers : 122
Employees : 23
Offices : 7
Orders : 64
Payments : 273
Products : 110
*/



/*******(2)*******/
SELECT productName, quantityInStock 
FROM products
WHERE productName LIKE '%Harley%'
ORDER BY quantityInStock DESC;

/*
Résultat : 
+---------------------------------------+-----------------+
| productName                           | quantityInStock |
+---------------------------------------+-----------------+
| 1969 Harley Davidson Ultimate Chopper |            7931 |
| 2003 Harley-Davidson Eagle Drag Bike  |            7931 |
| 1936 Harley Davidson El Knucklehead   |            7931 |
+---------------------------------------+-----------------+
*/



/*******(3)*******/
SELECT contactFirstName FROM customers
WHERE contactFirstName LIKE '_a%'
ORDER BY contactFirstName ASC;

/*
Donne 33 prénoms, un extrait du résultat :
| contactFirstName |
+------------------+
| Carine           |
| Carmen           |
| Catherine        |
| Dan              |
| Daniel           |
| Daniel           |
*/



/*******(4)*******/
SELECT count(*) AS 'nombre de client avec _a'
FROM customers
WHERE contactFirstName LIKE '_a%';

/*
Il y en a 33 :
+--------------------------+
| nombre de client avec _a |
+--------------------------+
|                       33 |
+--------------------------+
*/




/*******(5)*******/
SELECT productName AS 'Les articles', buyPrice AS 'Les prix' 
FROM products
WHERE buyPrice BETWEEN 50 AND 65;

/*
+-----------------------------------------+----------+
| Les articles                            | Les prix |
+-----------------------------------------+----------+
| 1957 Chevy Pickup                       |    55.70 |
| 1969 Dodge Charger                      |    58.73 |
| 1940 Ford Pickup Truck                  |    58.33 |
| 1937 Lincoln Berline                    |    60.62 |
| 1948 Porsche 356-A Roadster             |    53.90 |
| 1932 Model A Ford J-Coupe               |    58.48 |
| 1999 Indy 500 Monte Carlo SS            |    56.76 |
| 1913 Ford Model T Speedster             |    60.78 |
| 1999 Yamaha Speed Boat                  |    51.61 |
| 18th Century Vintage Horse Carriage     |    60.74 |
| 1985 Toyota Supra                       |    57.01 |
| 1917 Maxwell Touring Car                |    57.54 |
| 1948 Porsche Type 356 Roadster          |    62.16 |
| 1941 Chevrolet Special Deluxe Cabriolet |    64.58 |
| 1904 Buick Runabout                     |    52.66 |
| 1997 BMW R 1100 S                       |    60.86 |
| 1962 Volkswagen Microbus                |    61.34 |
| 1969 Chevrolet Camaro Z28               |    50.51 |
| 2002 Chevy Corvette                     |    62.11 |
| 1936 Chrysler Airflow                   |    57.46 |
| 1980's GM Manhattan Express             |    53.93 |
| 1974 Ducati 350 Mk3 Desmo               |    56.13 |
| American Airlines: B767-300             |    51.15 |
| ATA: B757-300                           |    59.33 |
| F/A 18 Hornet 1/72                      |    54.40 |
| The Titanic                             |    51.09 |
| The Queen Mary                          |    53.63 |
+-----------------------------------------+----------+
*/



/*******(6)*******/
SELECT SUM(amount) AS 'Total [07/2004]'
FROM payments
WHERE amount > 2004-07-01;

/*
+-----------------+
| Total [07/2004] |
+-----------------+
|      8841825.22 |
+-----------------+
*/



/*******(7)*******/
SELECT * 
FROM orderDetails
WHERE quantityOrdered >= 50
ORDER BY orderNumber;

/*
Donne un tableau de 30 lignes, extrait de celui-ci : 
+-------------+-------------+-----------------+-----------+-----------------+
| orderNumber | productCode | quantityOrdered | priceEach | orderLineNumber |
+-------------+-------------+-----------------+-----------+-----------------+
|       10100 | S18_2248    |              50 |     55.09 |               2 |
|       10105 | S10_4757    |              50 |    127.84 |               2 |
|       10105 | S24_3816    |              50 |     75.47 |               1 |
|       10106 | S24_3949    |              50 |     55.96 |              11 |
|       10113 | S18_4668    |              50 |     43.27 |               3 |
|       10117 | S72_3212    |              50 |     52.42 |               2 |
|       10121 | S12_2823    |              50 |    126.52 |               4 |
|       10123 | S24_1628    |              50 |     43.27 |               1 |
|       10126 | S18_4600    |              50 |    102.92 |               5 |
|       10129 | S24_3816    |              50 |     76.31 |               1 |
|       10131 | S24_3949    |              50 |     54.59 |               3 |
|       10149 | S18_1342    |              50 |     87.33 |               4 |
|       10153 | S700_3505   |              50 |     87.15 |               2 |
*/



/*******(8)*******/
SELECT customers.customerName
FROM customers
LEFT JOIN orders ON customers.customerNumber = orders.customerNumber
WHERE orders.customerNumber IS NULL
ORDER BY customers.customerName ASC;

/*
Donne un tableau avec 72 lignes, extrait de celui-ci :
+------------------------------------+
| customerName                       |
+------------------------------------+
| American Souvenirs Inc             |
| Amica Models & Co.                 |
| ANG Resellers                      |
| Anton Designs, Ltd.                |
| Asian Shopping Network, Co         |
| Asian Treasures, Inc.              |
| Australian Collectables, Ltd       |
| Auto Associés & Cie.               |
| Auto Canal+ Petit                  |
| Bavarian Collectables Imports, Co. |
| BG&E Collectables                  |
| CAF Imports                        |
*/



/*******(9)*******/
SELECT lastName, firstName, employeeNumber, jobTitle FROM employees WHERE officeCode IS NULL;

/*
Résultat : Empty set (0.03 sec)
Tous les employés sont donc rattachés à un bureau.
*/

/*******(10)*******/
SELECT COUNT(DISTINCT city) AS 'Nombre de villes (customers)' FROM customers;

/*
Il y a 95 villes.
+------------------------------+
| Nombre de villes (customers) |
+------------------------------+
|                           95 |
+------------------------------+
*/


/*******(11)*******/
SELECT customers.customerName, SUM(amount) AS 'Somme totale'
FROM payments
LEFT JOIN customers ON payments.customerNumber = customers.customerNumber
GROUP BY payments.customerNumber 
ORDER BY SUM(amount) DESC;

SELECT customerNumber
FROM customers
WHERE customerName LIKE 'Euro+ Shopping Channel';

/*
Le client qui a payé le plus est Euro + Shopping Channel, et son numéro de client est le 141.
Extrait du tableau (98 résultats) :
+------------------------------------+--------------+
| customerName                       | Somme totale |
+------------------------------------+--------------+
| Euro+ Shopping Channel             |    715738.98 |
| Mini Gifts Distributors Ltd.       |    584188.24 |
| Australian Collectors, Co.         |    180585.07 |
| Muscle Machine Inc                 |    177913.95 |
| Dragon Souveniers, Ltd.            |    156251.03 |
| Down Under Souveniers, Inc         |    154622.08 |
| AV Stores, Co.                     |    148410.09 |
| Anna's Decorations, Ltd            |    137034.22 |
| Corporate Gift Ideas Co.           |    132340.78 |
| Saveley & Henriot, Co.             |    130305.35 |
| Rovelli Gifts                      |    127529.69 |

Pour le numéro :
+----------------+
| customerNumber |
+----------------+
|            141 |
+----------------+
*/



/*******(12)*******/
SELECT products.productCode, products.productLine, products.productName, SUM(quantityOrdered) AS 'Quantité commandée', SUM(quantityOrdered*priceEach) AS 'Somme totale ventes' 
FROM orderDetails
INNER JOIN orders ON orderDetails.orderNumber = orders.orderNumber
INNER JOIN products ON orderDetails.productCode = products.productCode
WHERE orders.orderDate > 2005-01-01
GROUP BY products.productCode
ORDER BY products.productLine, products.productCode;

/*
Extrait du tableau (109 résultats) :
+-------------+------------------+---------------------------------------------+--------------------+---------------------+
| productCode | productLine      | productName                                 | Quantité commandée | Somme totale ventes |
+-------------+------------------+---------------------------------------------+--------------------+---------------------+
| S10_1949    | Classic Cars     | 1952 Alpine Renault 1300                    |                196 |            38658.02 |
| S10_4757    | Classic Cars     | 1972 Alfa Romeo GTA                         |                210 |            26333.68 |
| S10_4962    | Classic Cars     | 1962 LanciaA Delta 16V                      |                141 |            17549.95 |
| S12_1099    | Classic Cars     | 1968 Ford Mustang                           |                206 |            34757.85 |
| S12_1108    | Classic Cars     | 2001 Ferrari Enzo                           |                173 |            33287.23 |
| S12_3148    | Classic Cars     | 1969 Corvair Monza                          |                198 |            27328.68 |
| S12_3380    | Classic Cars     | 1968 Dodge Charger                          |                207 |            21699.15 |
| S12_3891    | Classic Cars     | 1969 Ford Falcon                            |                205 |            33334.28 |
| S12_3990    | Classic Cars     | 1970 Plymouth Hemi Cuda                     |                140 |             9960.68 |
| S12_4675    | Classic Cars     | 1969 Dodge Charger                          |                168 |            16851.53 |
| S18_1129    | Classic Cars     | 1993 Mazda RX-7                             |                136 |            15934.69 |
| S18_1589    | Classic Cars     | 1965 Aston Martin DB5                       |                197 |            22080.66 |
| S18_1889    | Classic Cars     | 1948 Porsche 356-A Roadster                 |                193 |            13006.07 |
*/



/*******(13)*******/
SELECT `Numero de commande`, `Date achat / Code produit`, `Statut commande / Quantite achetee`, `Nom client / Produit` 
FROM (SELECT orders.orderNumber     AS 'ordre', 
          orders.orderNumber     AS 'Numero de commande', 
          orders.orderDate       AS 'Date achat / Code produit', 
          orders.status          AS 'Statut commande / Quantite achetee', 
          customers.customerName AS 'Nom client / Produit'
      FROM orders
      LEFT JOIN customers ON orders.customerNumber = customers.customerNumber
      UNION
      SELECT orderDetails.orderNumber, '-', orderDetails.productCode, orderDetails.quantityOrdered, products.productName 
      FROM orderDetails
      LEFT JOIN products ON orderDetails.productCode = products.productCode
     ) AS result 
     ORDER BY ordre;

/*
Extrait du résultat (1242 lignes) :
+--------------------+---------------------------+------------------------------------+---------------------------------------------+
| Numero de commande | Date achat / Code produit | Statut commande / Quantite achetee | Nom client / Produit                        |
+--------------------+---------------------------+------------------------------------+---------------------------------------------+
| -                  | S24_3969                  | 49                                 | 1936 Mercedes Benz 500k Roadster            |
| 10100              | 2003-01-06                | Shipped                            | Online Diecast Creations Co.                |
| -                  | S18_1749                  | 30                                 | 1917 Grand Touring Sedan                    |
| -                  | S18_2248                  | 50                                 | 1911 Ford Town Car                          |
| -                  | S18_4409                  | 22                                 | 1932 Alfa Romeo 8C2300 Spider Sport         |
| -                  | S24_1937                  | 45                                 | 1939 Chevrolet Deluxe Coupe                 |
| -                  | S24_2022                  | 46                                 | 1938 Cadillac V-16 Presidential Limousine   |
| -                  | S18_2325                  | 25                                 | 1932 Model A Ford J-Coupe                   |
| 10101              | 2003-01-09                | Shipped                            | Blauer See Auto, Co.                        |
| -                  | S18_2795                  | 26                                 | 1928 Mercedes-Benz SSK                      |
| -                  | S18_1342                  | 39                                 | 1937 Lincoln Berline                        |
| -                  | S18_1367                  | 41                                 | 1936 Mercedes-Benz 500K Special Roadster    |
| 10102              | 2003-01-10                | Shipped                            | Vitachrome Inc.                             |
| -                  | S18_4668                  | 41                                 | 1939 Cadillac Limousine                     |
| -                  | S18_1097                  | 35                                 | 1940 Ford Pickup Truck                      |
| -                  | S32_3522                  | 45                                 | 1996 Peterbilt 379 Stake Bed with Outrigger |
| -                  | S18_3136                  | 25                                 | 18th Century Vintage Horse Carriage         |
| -                  | S10_1949                  | 26                                 | 1952 Alpine Renault 1300                    |
*/



/*******(14)*******/
SELECT customers.customerNumber as tri, customers.customerName, offices.city, offices.country, employees.firstName, employees.lastName, employees.jobTitle FROM customers
LEFT JOIN employees ON customers.salesRepEmployeeNumber = employees.employeeNumber
LEFT JOIN offices ON employees.officeCode = offices.officeCode

UNION

SELECT orders.customerNumber, '-', '-', products.productName, SUM(orderDetails.quantityOrdered), products.productLine, products.buyPrice FROM orderDetails
LEFT JOIN orders ON orderDetails.orderNumber = orders.orderNumber
LEFT JOIN products ON orderDetails.productCode = products.productCode
GROUP BY orders.customerNumber, orderDetails.productCode;





| table_name   | GROUP_CONCAT(column_name ORDER BY ordinal_position)                                                                                                          

+---------------------------------------------------------------------------------------------------------------------------------------------------------------+
| customers    | customerNumber,customerName,contactLastName,contactFirstName,phone,addressLine1,addressLine2,city,state,postalCode,country,salesRepEmployeeNumbe, creditLimit
 |

| employees    | employeeNumber,lastName,firstName,extension,email,officeCode,reportsTo,jobTitle     
                                                                          |
| offices      | officeCode,city,phone,addressLine1,addressLine2,state,country,postalCode,territory

                                                                            |
| orderdetails | orderNumber,productCode,quantityOrdered,priceEach,orderLineNumber        

                                                                                     |
| orders       | orderNumber,orderDate,requiredDate,shippedDate,status,comments,customerNumber             
                                                                    |
| payments     | customerNumber,checkNumber,paymentDate amount    

                                                                                                |
| productlines | productLine,textDescription,htmlDescription,image    

                                                                                                         |
| products     | productCode,productName,productLine,productScale,productVendor,productDescription,quantityInStock,buyPrice,MSRP