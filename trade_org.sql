--
-- PostgreSQL database dump
--

-- Dumped from database version 13.20
-- Dumped by pg_dump version 13.20

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: trade_org; Type: SCHEMA; Schema: -; Owner: trade_org
--

CREATE SCHEMA trade_org;


ALTER SCHEMA trade_org OWNER TO trade_org;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: categories; Type: TABLE; Schema: trade_org; Owner: trade_org
--

CREATE TABLE trade_org.categories (
    category_id integer NOT NULL,
    category_name character varying(255) NOT NULL
);


ALTER TABLE trade_org.categories OWNER TO trade_org;

--
-- Name: categories_category_id_seq; Type: SEQUENCE; Schema: trade_org; Owner: trade_org
--

CREATE SEQUENCE trade_org.categories_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE trade_org.categories_category_id_seq OWNER TO trade_org;

--
-- Name: categories_category_id_seq; Type: SEQUENCE OWNED BY; Schema: trade_org; Owner: trade_org
--

ALTER SEQUENCE trade_org.categories_category_id_seq OWNED BY trade_org.categories.category_id;


--
-- Name: customers; Type: TABLE; Schema: trade_org; Owner: trade_org
--

CREATE TABLE trade_org.customers (
    customer_id integer NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    email character varying(255) NOT NULL,
    phone character varying(20),
    address text
);


ALTER TABLE trade_org.customers OWNER TO trade_org;

--
-- Name: customers_customer_id_seq; Type: SEQUENCE; Schema: trade_org; Owner: trade_org
--

CREATE SEQUENCE trade_org.customers_customer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE trade_org.customers_customer_id_seq OWNER TO trade_org;

--
-- Name: customers_customer_id_seq; Type: SEQUENCE OWNED BY; Schema: trade_org; Owner: trade_org
--

ALTER SEQUENCE trade_org.customers_customer_id_seq OWNED BY trade_org.customers.customer_id;


--
-- Name: employees; Type: TABLE; Schema: trade_org; Owner: trade_org
--

CREATE TABLE trade_org.employees (
    employee_id integer NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    "position" character varying(100),
    hire_date date NOT NULL,
    salary numeric(10,2),
    CONSTRAINT employees_salary_check CHECK ((salary >= (0)::numeric))
);


ALTER TABLE trade_org.employees OWNER TO trade_org;

--
-- Name: employees_employee_id_seq; Type: SEQUENCE; Schema: trade_org; Owner: trade_org
--

CREATE SEQUENCE trade_org.employees_employee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE trade_org.employees_employee_id_seq OWNER TO trade_org;

--
-- Name: employees_employee_id_seq; Type: SEQUENCE OWNED BY; Schema: trade_org; Owner: trade_org
--

ALTER SEQUENCE trade_org.employees_employee_id_seq OWNED BY trade_org.employees.employee_id;


--
-- Name: inventory; Type: TABLE; Schema: trade_org; Owner: trade_org
--

CREATE TABLE trade_org.inventory (
    inventory_id integer NOT NULL,
    product_id integer,
    warehouse_id integer,
    quantity integer NOT NULL,
    CONSTRAINT inventory_quantity_check CHECK ((quantity >= 0))
);


ALTER TABLE trade_org.inventory OWNER TO trade_org;

--
-- Name: inventory_inventory_id_seq; Type: SEQUENCE; Schema: trade_org; Owner: trade_org
--

CREATE SEQUENCE trade_org.inventory_inventory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE trade_org.inventory_inventory_id_seq OWNER TO trade_org;

--
-- Name: inventory_inventory_id_seq; Type: SEQUENCE OWNED BY; Schema: trade_org; Owner: trade_org
--

ALTER SEQUENCE trade_org.inventory_inventory_id_seq OWNED BY trade_org.inventory.inventory_id;


--
-- Name: order_details; Type: TABLE; Schema: trade_org; Owner: trade_org
--

CREATE TABLE trade_org.order_details (
    order_detail_id integer NOT NULL,
    order_id integer,
    product_id integer,
    quantity integer NOT NULL,
    unit_price numeric(10,2) NOT NULL,
    CONSTRAINT order_details_quantity_check CHECK ((quantity > 0)),
    CONSTRAINT order_details_unit_price_check CHECK ((unit_price >= (0)::numeric))
);


ALTER TABLE trade_org.order_details OWNER TO trade_org;

--
-- Name: order_details_order_detail_id_seq; Type: SEQUENCE; Schema: trade_org; Owner: trade_org
--

CREATE SEQUENCE trade_org.order_details_order_detail_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE trade_org.order_details_order_detail_id_seq OWNER TO trade_org;

--
-- Name: order_details_order_detail_id_seq; Type: SEQUENCE OWNED BY; Schema: trade_org; Owner: trade_org
--

ALTER SEQUENCE trade_org.order_details_order_detail_id_seq OWNED BY trade_org.order_details.order_detail_id;


--
-- Name: orders; Type: TABLE; Schema: trade_org; Owner: trade_org
--

CREATE TABLE trade_org.orders (
    order_id integer NOT NULL,
    customer_id integer,
    employee_id integer,
    order_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    total_amount numeric(10,2) NOT NULL,
    CONSTRAINT orders_total_amount_check CHECK ((total_amount >= (0)::numeric))
);


ALTER TABLE trade_org.orders OWNER TO trade_org;

--
-- Name: orders_order_id_seq; Type: SEQUENCE; Schema: trade_org; Owner: trade_org
--

CREATE SEQUENCE trade_org.orders_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE trade_org.orders_order_id_seq OWNER TO trade_org;

--
-- Name: orders_order_id_seq; Type: SEQUENCE OWNED BY; Schema: trade_org; Owner: trade_org
--

ALTER SEQUENCE trade_org.orders_order_id_seq OWNED BY trade_org.orders.order_id;


--
-- Name: products; Type: TABLE; Schema: trade_org; Owner: trade_org
--

CREATE TABLE trade_org.products (
    product_id integer NOT NULL,
    product_name character varying(255) NOT NULL,
    category_id integer,
    supplier_id integer,
    unit_price numeric(10,2) NOT NULL,
    units_in_stock integer NOT NULL,
    description text,
    CONSTRAINT products_unit_price_check CHECK ((unit_price >= (0)::numeric)),
    CONSTRAINT products_units_in_stock_check CHECK ((units_in_stock >= 0))
);


ALTER TABLE trade_org.products OWNER TO trade_org;

--
-- Name: products_product_id_seq; Type: SEQUENCE; Schema: trade_org; Owner: trade_org
--

CREATE SEQUENCE trade_org.products_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE trade_org.products_product_id_seq OWNER TO trade_org;

--
-- Name: products_product_id_seq; Type: SEQUENCE OWNED BY; Schema: trade_org; Owner: trade_org
--

ALTER SEQUENCE trade_org.products_product_id_seq OWNED BY trade_org.products.product_id;


--
-- Name: suppliers; Type: TABLE; Schema: trade_org; Owner: trade_org
--

CREATE TABLE trade_org.suppliers (
    supplier_id integer NOT NULL,
    supplier_name character varying(255) NOT NULL,
    contact_name character varying(255),
    address text,
    phone character varying(20),
    email character varying(255)
);


ALTER TABLE trade_org.suppliers OWNER TO trade_org;

--
-- Name: suppliers_supplier_id_seq; Type: SEQUENCE; Schema: trade_org; Owner: trade_org
--

CREATE SEQUENCE trade_org.suppliers_supplier_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE trade_org.suppliers_supplier_id_seq OWNER TO trade_org;

--
-- Name: suppliers_supplier_id_seq; Type: SEQUENCE OWNED BY; Schema: trade_org; Owner: trade_org
--

ALTER SEQUENCE trade_org.suppliers_supplier_id_seq OWNED BY trade_org.suppliers.supplier_id;


--
-- Name: users; Type: TABLE; Schema: trade_org; Owner: trade_org
--

CREATE TABLE trade_org.users (
    user_id integer NOT NULL,
    username character varying(100) NOT NULL,
    password text NOT NULL,
    role character varying(50) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT users_role_check CHECK (((role)::text = ANY ((ARRAY['admin'::character varying, 'manager'::character varying, 'accountant'::character varying, 'warehouse'::character varying, 'sales'::character varying])::text[])))
);


ALTER TABLE trade_org.users OWNER TO trade_org;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: trade_org; Owner: trade_org
--

CREATE SEQUENCE trade_org.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE trade_org.users_user_id_seq OWNER TO trade_org;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: trade_org; Owner: trade_org
--

ALTER SEQUENCE trade_org.users_user_id_seq OWNED BY trade_org.users.user_id;


--
-- Name: warehouses; Type: TABLE; Schema: trade_org; Owner: trade_org
--

CREATE TABLE trade_org.warehouses (
    warehouse_id integer NOT NULL,
    warehouse_name character varying(255) NOT NULL,
    address text NOT NULL
);


ALTER TABLE trade_org.warehouses OWNER TO trade_org;

--
-- Name: warehouses_warehouse_id_seq; Type: SEQUENCE; Schema: trade_org; Owner: trade_org
--

CREATE SEQUENCE trade_org.warehouses_warehouse_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE trade_org.warehouses_warehouse_id_seq OWNER TO trade_org;

--
-- Name: warehouses_warehouse_id_seq; Type: SEQUENCE OWNED BY; Schema: trade_org; Owner: trade_org
--

ALTER SEQUENCE trade_org.warehouses_warehouse_id_seq OWNED BY trade_org.warehouses.warehouse_id;


--
-- Name: categories category_id; Type: DEFAULT; Schema: trade_org; Owner: trade_org
--

ALTER TABLE ONLY trade_org.categories ALTER COLUMN category_id SET DEFAULT nextval('trade_org.categories_category_id_seq'::regclass);


--
-- Name: customers customer_id; Type: DEFAULT; Schema: trade_org; Owner: trade_org
--

ALTER TABLE ONLY trade_org.customers ALTER COLUMN customer_id SET DEFAULT nextval('trade_org.customers_customer_id_seq'::regclass);


--
-- Name: employees employee_id; Type: DEFAULT; Schema: trade_org; Owner: trade_org
--

ALTER TABLE ONLY trade_org.employees ALTER COLUMN employee_id SET DEFAULT nextval('trade_org.employees_employee_id_seq'::regclass);


--
-- Name: inventory inventory_id; Type: DEFAULT; Schema: trade_org; Owner: trade_org
--

ALTER TABLE ONLY trade_org.inventory ALTER COLUMN inventory_id SET DEFAULT nextval('trade_org.inventory_inventory_id_seq'::regclass);


--
-- Name: order_details order_detail_id; Type: DEFAULT; Schema: trade_org; Owner: trade_org
--

ALTER TABLE ONLY trade_org.order_details ALTER COLUMN order_detail_id SET DEFAULT nextval('trade_org.order_details_order_detail_id_seq'::regclass);


--
-- Name: orders order_id; Type: DEFAULT; Schema: trade_org; Owner: trade_org
--

ALTER TABLE ONLY trade_org.orders ALTER COLUMN order_id SET DEFAULT nextval('trade_org.orders_order_id_seq'::regclass);


--
-- Name: products product_id; Type: DEFAULT; Schema: trade_org; Owner: trade_org
--

ALTER TABLE ONLY trade_org.products ALTER COLUMN product_id SET DEFAULT nextval('trade_org.products_product_id_seq'::regclass);


--
-- Name: suppliers supplier_id; Type: DEFAULT; Schema: trade_org; Owner: trade_org
--

ALTER TABLE ONLY trade_org.suppliers ALTER COLUMN supplier_id SET DEFAULT nextval('trade_org.suppliers_supplier_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: trade_org; Owner: trade_org
--

ALTER TABLE ONLY trade_org.users ALTER COLUMN user_id SET DEFAULT nextval('trade_org.users_user_id_seq'::regclass);


--
-- Name: warehouses warehouse_id; Type: DEFAULT; Schema: trade_org; Owner: trade_org
--

ALTER TABLE ONLY trade_org.warehouses ALTER COLUMN warehouse_id SET DEFAULT nextval('trade_org.warehouses_warehouse_id_seq'::regclass);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: trade_org; Owner: trade_org
--

COPY trade_org.categories (category_id, category_name) FROM stdin;
1	Электроника
2	Бытовая техника
3	Одежда
4	Канцелярия
5	Мебель
6	Продукты питания
7	Спорттовары
8	Автозапчасти
9	Игрушки
10	Косметика
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: trade_org; Owner: trade_org
--

COPY trade_org.customers (customer_id, first_name, last_name, email, phone, address) FROM stdin;
1	Алексей	Смирнов	alexey.smirnov@example.com	+7 915 123-45-67	Москва, ул. Тверская, 10
2	Ольга	Иванова	olga.ivanova@example.com	+7 916 234-56-78	Санкт-Петербург, ул. Краснопрудная, 7
3	Дмитрий	Кузнецов	dmitry.kuznetsov@example.com	+7 917 345-67-89	Новосибирск, ул. Красная, 23
4	Елена	Соколова	elena.sokolova@example.com	+7 918 456-78-90	Екатеринбург, ул. Ленина, 5
5	Сергей	Федоров	sergey.fedorov@example.com	+7 919 567-89-01	Казань, ул. Баумана, 33
\.


--
-- Data for Name: employees; Type: TABLE DATA; Schema: trade_org; Owner: trade_org
--

COPY trade_org.employees (employee_id, first_name, last_name, "position", hire_date, salary) FROM stdin;
1	Дмитрий	Петров	Менеджер	2021-05-10	60000.00
2	Светлана	Кузнецова	Продавец	2022-08-15	45000.00
3	Артем	Сидоров	Менеджер	2020-07-19	65000.00
4	Татьяна	Морозова	Продавец	2019-04-21	48000.00
5	Максим	Васильев	Кассир	2023-03-02	40000.00
\.


--
-- Data for Name: inventory; Type: TABLE DATA; Schema: trade_org; Owner: trade_org
--

COPY trade_org.inventory (inventory_id, product_id, warehouse_id, quantity) FROM stdin;
1	1	1	10
2	2	1	20
3	3	2	5
4	4	2	15
5	5	1	25
6	6	3	10
7	7	4	50
8	8	5	8
9	9	3	12
10	10	2	40
\.


--
-- Data for Name: order_details; Type: TABLE DATA; Schema: trade_org; Owner: trade_org
--

COPY trade_org.order_details (order_detail_id, order_id, product_id, quantity, unit_price) FROM stdin;
1	1	1	1	75000.00
2	1	2	2	65000.00
3	2	3	1	120000.00
4	2	5	2	1500.00
5	3	4	1	55000.00
6	3	6	3	8000.00
7	3	7	2	500.00
8	4	8	1	25000.00
9	4	9	1	15000.00
10	4	10	3	1200.00
11	5	5	2	1500.00
12	5	7	4	500.00
13	6	3	1	120000.00
14	6	6	2	8000.00
15	7	2	1	65000.00
16	7	4	1	55000.00
17	8	1	1	75000.00
18	8	9	2	15000.00
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: trade_org; Owner: trade_org
--

COPY trade_org.orders (order_id, customer_id, employee_id, order_date, total_amount) FROM stdin;
1	1	1	2024-03-01 14:30:00	140000.00
2	2	2	2024-03-02 16:15:00	123000.00
3	3	3	2024-03-03 11:00:00	178000.00
4	4	4	2024-03-04 12:45:00	86000.00
5	5	5	2024-03-05 15:30:00	2700.00
6	1	3	2024-03-06 10:20:00	65500.00
7	3	2	2024-03-07 18:10:00	45000.00
8	2	4	2024-03-08 13:40:00	98000.00
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: trade_org; Owner: trade_org
--

COPY trade_org.products (product_id, product_name, category_id, supplier_id, unit_price, units_in_stock, description) FROM stdin;
1	Ноутбук HP Pavilion	1	1	75000.00	15	Ноутбук с Intel i5 и 16 ГБ ОЗУ
2	Смартфон Samsung Galaxy S21	1	1	65000.00	30	Флагманский смартфон Samsung
3	Телевизор Sony Bravia	1	1	120000.00	5	4K телевизор с HDR
4	Холодильник LG	2	1	55000.00	10	Двухкамерный холодильник с No Frost
5	Футболка мужская	3	2	1500.00	50	100% хлопок, размер M
6	Кроссовки Nike	7	2	8000.00	20	Беговые кроссовки
7	Ручка Parker	4	3	500.00	100	Металлическая шариковая ручка Parker
8	Шкаф IKEA	5	3	25000.00	8	Деревянный шкаф для одежды
9	Фары для Toyota Camry	8	5	15000.00	12	Оригинальные передние фары
10	Игрушечная машинка Hot Wheels	9	4	1200.00	40	Коллекционная модель
\.


--
-- Data for Name: suppliers; Type: TABLE DATA; Schema: trade_org; Owner: trade_org
--

COPY trade_org.suppliers (supplier_id, supplier_name, contact_name, address, phone, email) FROM stdin;
1	ООО ЭлектроТех	Иван Петров	Москва, ул. Электрозаводская, 8	+7 495 123-45-67	info@electrotech.ru
2	ЗАО ОдеждаСтиль	Мария Иванова	Санкт-Петербург, пр. Ленина, 10	+7 812 987-65-43	contact@styleclothes.ru
3	ООО КанцМаркет	Олег Смирнов	Новосибирск, ул. Чкалова, 15	+7 383 456-78-90	contact@kanctorg.ru
4	ИП Иванов	Иван Иванов	Казань, ул. Пушкина, 1	+7 843 987-23-45	ivanov@ip.ru
5	ООО АвтоДетали	Сергей Кузнецов	Екатеринбург, пр. Автозаводская, 14	+7 343 567-45-67	autodetail@info.ru
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: trade_org; Owner: trade_org
--

COPY trade_org.users (user_id, username, password, role, created_at) FROM stdin;
1	admin	$2y$12$StETkFrqQUocBWDaOfGRc.AZ4Di3lDUdSScf9JajyPjBPIl3aJk4G	admin	2025-03-13 15:26:52.019968
2	manager	$2y$12$XkZqGaeDuo.r1H/ka4bRUe5qYkYLBmV0dOb41d/e9pw1O5kMqCspK	manager	2025-03-13 15:26:52.392212
3	accountant	$2y$12$ysyV0PljUGVpckE8iOPuSeunUHxM.hBNZl/rTajhvI/zn1BlInr8q	accountant	2025-03-13 15:26:52.759411
4	warehouse	$2y$12$NToCglkDdtLC8h7g82oY9ObKV0ZdgGXbso0H/OcTUO0fMMm11wP/y	warehouse	2025-03-13 15:26:53.150624
5	sales	$2y$12$HSRvLOioPO0PSd5yoWBwTOTrWVuO5YjXapd0m1SjVTb/0v0Kvub5W	sales	2025-03-13 15:26:53.563667
\.


--
-- Data for Name: warehouses; Type: TABLE DATA; Schema: trade_org; Owner: trade_org
--

COPY trade_org.warehouses (warehouse_id, warehouse_name, address) FROM stdin;
1	Склад Москва	Москва, ул. Ленина, 5
2	Склад Санкт-Петербург	Санкт-Петербург, ул. Невская, 12
3	Склад Новосибирск	Новосибирск, ул. Советская, 22
4	Склад Екатеринбург	Екатеринбург, пр. Мира, 18
5	Склад Казань	Казань, ул. Баумана, 33
\.


--
-- Name: categories_category_id_seq; Type: SEQUENCE SET; Schema: trade_org; Owner: trade_org
--

SELECT pg_catalog.setval('trade_org.categories_category_id_seq', 10, true);


--
-- Name: customers_customer_id_seq; Type: SEQUENCE SET; Schema: trade_org; Owner: trade_org
--

SELECT pg_catalog.setval('trade_org.customers_customer_id_seq', 5, true);


--
-- Name: employees_employee_id_seq; Type: SEQUENCE SET; Schema: trade_org; Owner: trade_org
--

SELECT pg_catalog.setval('trade_org.employees_employee_id_seq', 5, true);


--
-- Name: inventory_inventory_id_seq; Type: SEQUENCE SET; Schema: trade_org; Owner: trade_org
--

SELECT pg_catalog.setval('trade_org.inventory_inventory_id_seq', 10, true);


--
-- Name: order_details_order_detail_id_seq; Type: SEQUENCE SET; Schema: trade_org; Owner: trade_org
--

SELECT pg_catalog.setval('trade_org.order_details_order_detail_id_seq', 18, true);


--
-- Name: orders_order_id_seq; Type: SEQUENCE SET; Schema: trade_org; Owner: trade_org
--

SELECT pg_catalog.setval('trade_org.orders_order_id_seq', 8, true);


--
-- Name: products_product_id_seq; Type: SEQUENCE SET; Schema: trade_org; Owner: trade_org
--

SELECT pg_catalog.setval('trade_org.products_product_id_seq', 10, true);


--
-- Name: suppliers_supplier_id_seq; Type: SEQUENCE SET; Schema: trade_org; Owner: trade_org
--

SELECT pg_catalog.setval('trade_org.suppliers_supplier_id_seq', 5, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: trade_org; Owner: trade_org
--

SELECT pg_catalog.setval('trade_org.users_user_id_seq', 5, true);


--
-- Name: warehouses_warehouse_id_seq; Type: SEQUENCE SET; Schema: trade_org; Owner: trade_org
--

SELECT pg_catalog.setval('trade_org.warehouses_warehouse_id_seq', 5, true);


--
-- Name: categories categories_category_name_key; Type: CONSTRAINT; Schema: trade_org; Owner: trade_org
--

ALTER TABLE ONLY trade_org.categories
    ADD CONSTRAINT categories_category_name_key UNIQUE (category_name);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: trade_org; Owner: trade_org
--

ALTER TABLE ONLY trade_org.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (category_id);


--
-- Name: customers customers_email_key; Type: CONSTRAINT; Schema: trade_org; Owner: trade_org
--

ALTER TABLE ONLY trade_org.customers
    ADD CONSTRAINT customers_email_key UNIQUE (email);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: trade_org; Owner: trade_org
--

ALTER TABLE ONLY trade_org.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (customer_id);


--
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: trade_org; Owner: trade_org
--

ALTER TABLE ONLY trade_org.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (employee_id);


--
-- Name: inventory inventory_pkey; Type: CONSTRAINT; Schema: trade_org; Owner: trade_org
--

ALTER TABLE ONLY trade_org.inventory
    ADD CONSTRAINT inventory_pkey PRIMARY KEY (inventory_id);


--
-- Name: order_details order_details_pkey; Type: CONSTRAINT; Schema: trade_org; Owner: trade_org
--

ALTER TABLE ONLY trade_org.order_details
    ADD CONSTRAINT order_details_pkey PRIMARY KEY (order_detail_id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: trade_org; Owner: trade_org
--

ALTER TABLE ONLY trade_org.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: trade_org; Owner: trade_org
--

ALTER TABLE ONLY trade_org.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);


--
-- Name: suppliers suppliers_email_key; Type: CONSTRAINT; Schema: trade_org; Owner: trade_org
--

ALTER TABLE ONLY trade_org.suppliers
    ADD CONSTRAINT suppliers_email_key UNIQUE (email);


--
-- Name: suppliers suppliers_pkey; Type: CONSTRAINT; Schema: trade_org; Owner: trade_org
--

ALTER TABLE ONLY trade_org.suppliers
    ADD CONSTRAINT suppliers_pkey PRIMARY KEY (supplier_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: trade_org; Owner: trade_org
--

ALTER TABLE ONLY trade_org.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: trade_org; Owner: trade_org
--

ALTER TABLE ONLY trade_org.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: warehouses warehouses_pkey; Type: CONSTRAINT; Schema: trade_org; Owner: trade_org
--

ALTER TABLE ONLY trade_org.warehouses
    ADD CONSTRAINT warehouses_pkey PRIMARY KEY (warehouse_id);


--
-- Name: warehouses warehouses_warehouse_name_key; Type: CONSTRAINT; Schema: trade_org; Owner: trade_org
--

ALTER TABLE ONLY trade_org.warehouses
    ADD CONSTRAINT warehouses_warehouse_name_key UNIQUE (warehouse_name);


--
-- Name: inventory inventory_product_id_fkey; Type: FK CONSTRAINT; Schema: trade_org; Owner: trade_org
--

ALTER TABLE ONLY trade_org.inventory
    ADD CONSTRAINT inventory_product_id_fkey FOREIGN KEY (product_id) REFERENCES trade_org.products(product_id) ON DELETE CASCADE;


--
-- Name: inventory inventory_warehouse_id_fkey; Type: FK CONSTRAINT; Schema: trade_org; Owner: trade_org
--

ALTER TABLE ONLY trade_org.inventory
    ADD CONSTRAINT inventory_warehouse_id_fkey FOREIGN KEY (warehouse_id) REFERENCES trade_org.warehouses(warehouse_id) ON DELETE CASCADE;


--
-- Name: order_details order_details_order_id_fkey; Type: FK CONSTRAINT; Schema: trade_org; Owner: trade_org
--

ALTER TABLE ONLY trade_org.order_details
    ADD CONSTRAINT order_details_order_id_fkey FOREIGN KEY (order_id) REFERENCES trade_org.orders(order_id) ON DELETE CASCADE;


--
-- Name: order_details order_details_product_id_fkey; Type: FK CONSTRAINT; Schema: trade_org; Owner: trade_org
--

ALTER TABLE ONLY trade_org.order_details
    ADD CONSTRAINT order_details_product_id_fkey FOREIGN KEY (product_id) REFERENCES trade_org.products(product_id) ON DELETE CASCADE;


--
-- Name: orders orders_customer_id_fkey; Type: FK CONSTRAINT; Schema: trade_org; Owner: trade_org
--

ALTER TABLE ONLY trade_org.orders
    ADD CONSTRAINT orders_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES trade_org.customers(customer_id) ON DELETE SET NULL;


--
-- Name: orders orders_employee_id_fkey; Type: FK CONSTRAINT; Schema: trade_org; Owner: trade_org
--

ALTER TABLE ONLY trade_org.orders
    ADD CONSTRAINT orders_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES trade_org.employees(employee_id) ON DELETE SET NULL;


--
-- Name: products products_category_id_fkey; Type: FK CONSTRAINT; Schema: trade_org; Owner: trade_org
--

ALTER TABLE ONLY trade_org.products
    ADD CONSTRAINT products_category_id_fkey FOREIGN KEY (category_id) REFERENCES trade_org.categories(category_id) ON DELETE SET NULL;


--
-- Name: products products_supplier_id_fkey; Type: FK CONSTRAINT; Schema: trade_org; Owner: trade_org
--

ALTER TABLE ONLY trade_org.products
    ADD CONSTRAINT products_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES trade_org.suppliers(supplier_id) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

