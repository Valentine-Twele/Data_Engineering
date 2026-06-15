--dim location

SELECT distinct "Continent", "City" ,"Country" 
FROM public.retail_sales_original;

--dim store

SELECT distinct "Store ID", "Store Name", "Store Type" 
FROM public.retail_sales_original;

--dim promotion

SELECT distinct "Promotion ID", "Promotion Name" 
FROM public.retail_sales_original;

--dim customer

SELECT distinct "Customer ID", "Customer Segment", "Loyalty Tier"  
FROM public.retail_sales_original;

--dim salesperson

SELECT distinct "Salesperson ID", "Salesperson Department" 
FROM public.retail_sales_original;

--dim product

SELECT distinct "Product ID", "SKU", "Product Name", "Category", "Subcategory", "Brand" 
FROM public.retail_sales_original;

--dim purchase_date

SELECT distinct "Purchase Date" 
FROM public.retail_sales_original;

--dim ship date


SELECT distinct "Ship Date" 
FROM public.retail_sales_original;

--dim returned

SELECT distinct "Returned",  
FROM public.retail_sales_original;

--fact retail sales

SELECT distinct "Order ID", "Quantity", "Unit Cost", "Unit Price", "Discount Amount", "Tax Amount", "Shipping Cost", "Gross Sales", "Net Sales", "COGS", "Gross Profit" 
FROM public.retail_sales_original;