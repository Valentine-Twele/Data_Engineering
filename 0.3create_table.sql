-- ============================================================
--  Star Schema DDL  (retail analytics)
--  Order: dimension tables first, fact table last
-- ============================================================


-- Dimension: Location
CREATE table if not exists  dim_location (
    location_id       INT            PRIMARY KEY,
    continent         VARCHAR(100)   NOT NULL,
    country           VARCHAR(100)   NOT NULL,
    province_or_city  VARCHAR(100)
);


-- Dimension: Store
CREATE TABLE if not exists  dim_store (
    store_id    INT           PRIMARY KEY,
    store_name  VARCHAR(200)  NOT NULL,
    store_type  VARCHAR(50)
);


-- Dimension: Promotion
CREATE table if not exists  dim_promotion (
    promotion_id    INT           PRIMARY KEY,
    promotion_name  VARCHAR(200)  NOT NULL
);


-- Dimension: Date
CREATE TABLE if not exists  dim_date (
    date_id        INT      PRIMARY KEY,   -- surrogate key (YYYYMMDD works well)
    purchase_date  DATE     NOT NULL,
    ship_date      DATE,                   -- was VARCHAR — should be a DATE
    is_returned    BOOLEAN  NOT NULL DEFAULT FALSE
);


-- Dimension: Product
CREATE TABLE if not exists  dim_product (
    product_id    INT           PRIMARY KEY,
    sku           VARCHAR(50)   NOT NULL,  
    product_name  VARCHAR(200)  NOT NULL,
    category      VARCHAR(100),
    subcategory   VARCHAR(100),
    brand         VARCHAR(100)
);


-- Dimension: Salesperson
CREATE TABLE if not exists  dim_salesperson (
    salesperson_id          INT           PRIMARY KEY,
    salesperson_name        VARCHAR(200),
    salesperson_department  VARCHAR(100)
);


-- Dimension: Customer
CREATE TABLE if not exists dim_customer (
    customer_id      INT           PRIMARY KEY,
    customer_segment VARCHAR(100),
    loyalty_tier     VARCHAR(50)
);

-- Fact: Retail Sales
CREATE TABLE if not exists fact_retail_sales (
    order_id         INT              PRIMARY KEY,
    -- foreign keys (dimension references)
    location_id      INT              NOT NULL REFERENCES dim_location(location_id),
    store_id         INT              NOT NULL REFERENCES dim_store(store_id),
    promotion_id     INT                       REFERENCES dim_promotion(promotion_id),
    customer_id      INT              NOT NULL REFERENCES dim_customer(customer_id),
    salesperson_id   INT              NOT NULL REFERENCES dim_salesperson(salesperson_id),
    product_id       INT              NOT NULL REFERENCES dim_product(product_id),
    date_id          INT              NOT NULL REFERENCES dim_date(date_id),

    -- measures (use NUMERIC for money, not INT or VARCHAR)
    quantity         INT              NOT NULL DEFAULT 1,
    unit_cost        NUMERIC(12, 2)   NOT NULL,
    unit_price       NUMERIC(12, 2)   NOT NULL,
    discount_amount  NUMERIC(12, 2)   NOT NULL DEFAULT 0,
    tax_amount       NUMERIC(12, 2)   NOT NULL DEFAULT 0,
    shipping_cost    NUMERIC(12, 2)   NOT NULL DEFAULT 0,

    -- derived measures (consider computing these in a view instead)
    gross_sales      NUMERIC(12, 2),
    net_sales        NUMERIC(12, 2),
    cogs             NUMERIC(12, 2),
    gross_profit     NUMERIC(12, 2)
);