PGDMP     +    3                }         	   trade_org    13.20    13.20 X    0           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            1           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            2           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            3           1262    16395 	   trade_org    DATABASE     X   CREATE DATABASE trade_org WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'ru-RU';
    DROP DATABASE trade_org;
             	   trade_org    false                        2615    16532 	   trade_org    SCHEMA        CREATE SCHEMA trade_org;
    DROP SCHEMA trade_org;
             	   trade_org    false            �            1259    16535 
   categories    TABLE     {   CREATE TABLE trade_org.categories (
    category_id integer NOT NULL,
    category_name character varying(255) NOT NULL
);
 !   DROP TABLE trade_org.categories;
    	   trade_org         heap 	   trade_org    false    4            �            1259    16533    categories_category_id_seq    SEQUENCE     �   CREATE SEQUENCE trade_org.categories_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE trade_org.categories_category_id_seq;
    	   trade_org       	   trade_org    false    202    4            4           0    0    categories_category_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE trade_org.categories_category_id_seq OWNED BY trade_org.categories.category_id;
       	   trade_org       	   trade_org    false    201            �            1259    16613 	   customers    TABLE       CREATE TABLE trade_org.customers (
    customer_id integer NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    email character varying(255) NOT NULL,
    phone character varying(20),
    address text
);
     DROP TABLE trade_org.customers;
    	   trade_org         heap 	   trade_org    false    4            �            1259    16611    customers_customer_id_seq    SEQUENCE     �   CREATE SEQUENCE trade_org.customers_customer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE trade_org.customers_customer_id_seq;
    	   trade_org       	   trade_org    false    4    212            5           0    0    customers_customer_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE trade_org.customers_customer_id_seq OWNED BY trade_org.customers.customer_id;
       	   trade_org       	   trade_org    false    211            �            1259    16626 	   employees    TABLE     L  CREATE TABLE trade_org.employees (
    employee_id integer NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    "position" character varying(100),
    hire_date date NOT NULL,
    salary numeric(10,2),
    CONSTRAINT employees_salary_check CHECK ((salary >= (0)::numeric))
);
     DROP TABLE trade_org.employees;
    	   trade_org         heap 	   trade_org    false    4            �            1259    16624    employees_employee_id_seq    SEQUENCE     �   CREATE SEQUENCE trade_org.employees_employee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE trade_org.employees_employee_id_seq;
    	   trade_org       	   trade_org    false    214    4            6           0    0    employees_employee_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE trade_org.employees_employee_id_seq OWNED BY trade_org.employees.employee_id;
       	   trade_org       	   trade_org    false    213            �            1259    16594 	   inventory    TABLE     �   CREATE TABLE trade_org.inventory (
    inventory_id integer NOT NULL,
    product_id integer,
    warehouse_id integer,
    quantity integer NOT NULL,
    CONSTRAINT inventory_quantity_check CHECK ((quantity >= 0))
);
     DROP TABLE trade_org.inventory;
    	   trade_org         heap 	   trade_org    false    4            �            1259    16592    inventory_inventory_id_seq    SEQUENCE     �   CREATE SEQUENCE trade_org.inventory_inventory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE trade_org.inventory_inventory_id_seq;
    	   trade_org       	   trade_org    false    210    4            7           0    0    inventory_inventory_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE trade_org.inventory_inventory_id_seq OWNED BY trade_org.inventory.inventory_id;
       	   trade_org       	   trade_org    false    209            �            1259    16655    order_details    TABLE     [  CREATE TABLE trade_org.order_details (
    order_detail_id integer NOT NULL,
    order_id integer,
    product_id integer,
    quantity integer NOT NULL,
    unit_price numeric(10,2) NOT NULL,
    CONSTRAINT order_details_quantity_check CHECK ((quantity > 0)),
    CONSTRAINT order_details_unit_price_check CHECK ((unit_price >= (0)::numeric))
);
 $   DROP TABLE trade_org.order_details;
    	   trade_org         heap 	   trade_org    false    4            �            1259    16653 !   order_details_order_detail_id_seq    SEQUENCE     �   CREATE SEQUENCE trade_org.order_details_order_detail_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ;   DROP SEQUENCE trade_org.order_details_order_detail_id_seq;
    	   trade_org       	   trade_org    false    4    218            8           0    0 !   order_details_order_detail_id_seq    SEQUENCE OWNED BY     m   ALTER SEQUENCE trade_org.order_details_order_detail_id_seq OWNED BY trade_org.order_details.order_detail_id;
       	   trade_org       	   trade_org    false    217            �            1259    16635    orders    TABLE     3  CREATE TABLE trade_org.orders (
    order_id integer NOT NULL,
    customer_id integer,
    employee_id integer,
    order_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    total_amount numeric(10,2) NOT NULL,
    CONSTRAINT orders_total_amount_check CHECK ((total_amount >= (0)::numeric))
);
    DROP TABLE trade_org.orders;
    	   trade_org         heap 	   trade_org    false    4            �            1259    16633    orders_order_id_seq    SEQUENCE     �   CREATE SEQUENCE trade_org.orders_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE trade_org.orders_order_id_seq;
    	   trade_org       	   trade_org    false    216    4            9           0    0    orders_order_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE trade_org.orders_order_id_seq OWNED BY trade_org.orders.order_id;
       	   trade_org       	   trade_org    false    215            �            1259    16571    products    TABLE     �  CREATE TABLE trade_org.products (
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
    DROP TABLE trade_org.products;
    	   trade_org         heap 	   trade_org    false    4            �            1259    16569    products_product_id_seq    SEQUENCE     �   CREATE SEQUENCE trade_org.products_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE trade_org.products_product_id_seq;
    	   trade_org       	   trade_org    false    208    4            :           0    0    products_product_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE trade_org.products_product_id_seq OWNED BY trade_org.products.product_id;
       	   trade_org       	   trade_org    false    207            �            1259    16545 	   suppliers    TABLE     �   CREATE TABLE trade_org.suppliers (
    supplier_id integer NOT NULL,
    supplier_name character varying(255) NOT NULL,
    contact_name character varying(255),
    address text,
    phone character varying(20),
    email character varying(255)
);
     DROP TABLE trade_org.suppliers;
    	   trade_org         heap 	   trade_org    false    4            �            1259    16543    suppliers_supplier_id_seq    SEQUENCE     �   CREATE SEQUENCE trade_org.suppliers_supplier_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE trade_org.suppliers_supplier_id_seq;
    	   trade_org       	   trade_org    false    4    204            ;           0    0    suppliers_supplier_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE trade_org.suppliers_supplier_id_seq OWNED BY trade_org.suppliers.supplier_id;
       	   trade_org       	   trade_org    false    203            �            1259    16675    users    TABLE     �  CREATE TABLE trade_org.users (
    user_id integer NOT NULL,
    username character varying(100) NOT NULL,
    password text NOT NULL,
    role character varying(50) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT users_role_check CHECK (((role)::text = ANY ((ARRAY['admin'::character varying, 'manager'::character varying, 'accountant'::character varying, 'warehouse'::character varying, 'sales'::character varying])::text[])))
);
    DROP TABLE trade_org.users;
    	   trade_org         heap 	   trade_org    false    4            �            1259    16673    users_user_id_seq    SEQUENCE     �   CREATE SEQUENCE trade_org.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE trade_org.users_user_id_seq;
    	   trade_org       	   trade_org    false    4    220            <           0    0    users_user_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE trade_org.users_user_id_seq OWNED BY trade_org.users.user_id;
       	   trade_org       	   trade_org    false    219            �            1259    16558 
   warehouses    TABLE     �   CREATE TABLE trade_org.warehouses (
    warehouse_id integer NOT NULL,
    warehouse_name character varying(255) NOT NULL,
    address text NOT NULL
);
 !   DROP TABLE trade_org.warehouses;
    	   trade_org         heap 	   trade_org    false    4            �            1259    16556    warehouses_warehouse_id_seq    SEQUENCE     �   CREATE SEQUENCE trade_org.warehouses_warehouse_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE trade_org.warehouses_warehouse_id_seq;
    	   trade_org       	   trade_org    false    4    206            =           0    0    warehouses_warehouse_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE trade_org.warehouses_warehouse_id_seq OWNED BY trade_org.warehouses.warehouse_id;
       	   trade_org       	   trade_org    false    205            ^           2604    16538    categories category_id    DEFAULT     �   ALTER TABLE ONLY trade_org.categories ALTER COLUMN category_id SET DEFAULT nextval('trade_org.categories_category_id_seq'::regclass);
 H   ALTER TABLE trade_org.categories ALTER COLUMN category_id DROP DEFAULT;
    	   trade_org       	   trade_org    false    202    201    202            f           2604    16616    customers customer_id    DEFAULT     �   ALTER TABLE ONLY trade_org.customers ALTER COLUMN customer_id SET DEFAULT nextval('trade_org.customers_customer_id_seq'::regclass);
 G   ALTER TABLE trade_org.customers ALTER COLUMN customer_id DROP DEFAULT;
    	   trade_org       	   trade_org    false    212    211    212            g           2604    16629    employees employee_id    DEFAULT     �   ALTER TABLE ONLY trade_org.employees ALTER COLUMN employee_id SET DEFAULT nextval('trade_org.employees_employee_id_seq'::regclass);
 G   ALTER TABLE trade_org.employees ALTER COLUMN employee_id DROP DEFAULT;
    	   trade_org       	   trade_org    false    213    214    214            d           2604    16597    inventory inventory_id    DEFAULT     �   ALTER TABLE ONLY trade_org.inventory ALTER COLUMN inventory_id SET DEFAULT nextval('trade_org.inventory_inventory_id_seq'::regclass);
 H   ALTER TABLE trade_org.inventory ALTER COLUMN inventory_id DROP DEFAULT;
    	   trade_org       	   trade_org    false    209    210    210            l           2604    16658    order_details order_detail_id    DEFAULT     �   ALTER TABLE ONLY trade_org.order_details ALTER COLUMN order_detail_id SET DEFAULT nextval('trade_org.order_details_order_detail_id_seq'::regclass);
 O   ALTER TABLE trade_org.order_details ALTER COLUMN order_detail_id DROP DEFAULT;
    	   trade_org       	   trade_org    false    218    217    218            i           2604    16638    orders order_id    DEFAULT     x   ALTER TABLE ONLY trade_org.orders ALTER COLUMN order_id SET DEFAULT nextval('trade_org.orders_order_id_seq'::regclass);
 A   ALTER TABLE trade_org.orders ALTER COLUMN order_id DROP DEFAULT;
    	   trade_org       	   trade_org    false    216    215    216            a           2604    16574    products product_id    DEFAULT     �   ALTER TABLE ONLY trade_org.products ALTER COLUMN product_id SET DEFAULT nextval('trade_org.products_product_id_seq'::regclass);
 E   ALTER TABLE trade_org.products ALTER COLUMN product_id DROP DEFAULT;
    	   trade_org       	   trade_org    false    208    207    208            _           2604    16548    suppliers supplier_id    DEFAULT     �   ALTER TABLE ONLY trade_org.suppliers ALTER COLUMN supplier_id SET DEFAULT nextval('trade_org.suppliers_supplier_id_seq'::regclass);
 G   ALTER TABLE trade_org.suppliers ALTER COLUMN supplier_id DROP DEFAULT;
    	   trade_org       	   trade_org    false    203    204    204            o           2604    16678    users user_id    DEFAULT     t   ALTER TABLE ONLY trade_org.users ALTER COLUMN user_id SET DEFAULT nextval('trade_org.users_user_id_seq'::regclass);
 ?   ALTER TABLE trade_org.users ALTER COLUMN user_id DROP DEFAULT;
    	   trade_org       	   trade_org    false    219    220    220            `           2604    16561    warehouses warehouse_id    DEFAULT     �   ALTER TABLE ONLY trade_org.warehouses ALTER COLUMN warehouse_id SET DEFAULT nextval('trade_org.warehouses_warehouse_id_seq'::regclass);
 I   ALTER TABLE trade_org.warehouses ALTER COLUMN warehouse_id DROP DEFAULT;
    	   trade_org       	   trade_org    false    206    205    206                      0    16535 
   categories 
   TABLE DATA           C   COPY trade_org.categories (category_id, category_name) FROM stdin;
 	   trade_org       	   trade_org    false    202   �p       %          0    16613 	   customers 
   TABLE DATA           a   COPY trade_org.customers (customer_id, first_name, last_name, email, phone, address) FROM stdin;
 	   trade_org       	   trade_org    false    212   �q       '          0    16626 	   employees 
   TABLE DATA           i   COPY trade_org.employees (employee_id, first_name, last_name, "position", hire_date, salary) FROM stdin;
 	   trade_org       	   trade_org    false    214   8s       #          0    16594 	   inventory 
   TABLE DATA           X   COPY trade_org.inventory (inventory_id, product_id, warehouse_id, quantity) FROM stdin;
 	   trade_org       	   trade_org    false    210   t       +          0    16655    order_details 
   TABLE DATA           g   COPY trade_org.order_details (order_detail_id, order_id, product_id, quantity, unit_price) FROM stdin;
 	   trade_org       	   trade_org    false    218   lt       )          0    16635    orders 
   TABLE DATA           a   COPY trade_org.orders (order_id, customer_id, employee_id, order_date, total_amount) FROM stdin;
 	   trade_org       	   trade_org    false    216   u       !          0    16571    products 
   TABLE DATA           �   COPY trade_org.products (product_id, product_name, category_id, supplier_id, unit_price, units_in_stock, description) FROM stdin;
 	   trade_org       	   trade_org    false    208   �u                 0    16545 	   suppliers 
   TABLE DATA           g   COPY trade_org.suppliers (supplier_id, supplier_name, contact_name, address, phone, email) FROM stdin;
 	   trade_org       	   trade_org    false    204   �w       -          0    16675    users 
   TABLE DATA           Q   COPY trade_org.users (user_id, username, password, role, created_at) FROM stdin;
 	   trade_org       	   trade_org    false    220   �y                 0    16558 
   warehouses 
   TABLE DATA           N   COPY trade_org.warehouses (warehouse_id, warehouse_name, address) FROM stdin;
 	   trade_org       	   trade_org    false    206   �z       >           0    0    categories_category_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('trade_org.categories_category_id_seq', 10, true);
       	   trade_org       	   trade_org    false    201            ?           0    0    customers_customer_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('trade_org.customers_customer_id_seq', 5, true);
       	   trade_org       	   trade_org    false    211            @           0    0    employees_employee_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('trade_org.employees_employee_id_seq', 5, true);
       	   trade_org       	   trade_org    false    213            A           0    0    inventory_inventory_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('trade_org.inventory_inventory_id_seq', 10, true);
       	   trade_org       	   trade_org    false    209            B           0    0 !   order_details_order_detail_id_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('trade_org.order_details_order_detail_id_seq', 18, true);
       	   trade_org       	   trade_org    false    217            C           0    0    orders_order_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('trade_org.orders_order_id_seq', 8, true);
       	   trade_org       	   trade_org    false    215            D           0    0    products_product_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('trade_org.products_product_id_seq', 10, true);
       	   trade_org       	   trade_org    false    207            E           0    0    suppliers_supplier_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('trade_org.suppliers_supplier_id_seq', 5, true);
       	   trade_org       	   trade_org    false    203            F           0    0    users_user_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('trade_org.users_user_id_seq', 5, true);
       	   trade_org       	   trade_org    false    219            G           0    0    warehouses_warehouse_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('trade_org.warehouses_warehouse_id_seq', 5, true);
       	   trade_org       	   trade_org    false    205            s           2606    16542 '   categories categories_category_name_key 
   CONSTRAINT     n   ALTER TABLE ONLY trade_org.categories
    ADD CONSTRAINT categories_category_name_key UNIQUE (category_name);
 T   ALTER TABLE ONLY trade_org.categories DROP CONSTRAINT categories_category_name_key;
    	   trade_org         	   trade_org    false    202            u           2606    16540    categories categories_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY trade_org.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (category_id);
 G   ALTER TABLE ONLY trade_org.categories DROP CONSTRAINT categories_pkey;
    	   trade_org         	   trade_org    false    202            �           2606    16623    customers customers_email_key 
   CONSTRAINT     \   ALTER TABLE ONLY trade_org.customers
    ADD CONSTRAINT customers_email_key UNIQUE (email);
 J   ALTER TABLE ONLY trade_org.customers DROP CONSTRAINT customers_email_key;
    	   trade_org         	   trade_org    false    212            �           2606    16621    customers customers_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY trade_org.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (customer_id);
 E   ALTER TABLE ONLY trade_org.customers DROP CONSTRAINT customers_pkey;
    	   trade_org         	   trade_org    false    212            �           2606    16632    employees employees_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY trade_org.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (employee_id);
 E   ALTER TABLE ONLY trade_org.employees DROP CONSTRAINT employees_pkey;
    	   trade_org         	   trade_org    false    214            �           2606    16600    inventory inventory_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY trade_org.inventory
    ADD CONSTRAINT inventory_pkey PRIMARY KEY (inventory_id);
 E   ALTER TABLE ONLY trade_org.inventory DROP CONSTRAINT inventory_pkey;
    	   trade_org         	   trade_org    false    210            �           2606    16662     order_details order_details_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY trade_org.order_details
    ADD CONSTRAINT order_details_pkey PRIMARY KEY (order_detail_id);
 M   ALTER TABLE ONLY trade_org.order_details DROP CONSTRAINT order_details_pkey;
    	   trade_org         	   trade_org    false    218            �           2606    16642    orders orders_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY trade_org.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);
 ?   ALTER TABLE ONLY trade_org.orders DROP CONSTRAINT orders_pkey;
    	   trade_org         	   trade_org    false    216                       2606    16581    products products_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY trade_org.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);
 C   ALTER TABLE ONLY trade_org.products DROP CONSTRAINT products_pkey;
    	   trade_org         	   trade_org    false    208            w           2606    16555    suppliers suppliers_email_key 
   CONSTRAINT     \   ALTER TABLE ONLY trade_org.suppliers
    ADD CONSTRAINT suppliers_email_key UNIQUE (email);
 J   ALTER TABLE ONLY trade_org.suppliers DROP CONSTRAINT suppliers_email_key;
    	   trade_org         	   trade_org    false    204            y           2606    16553    suppliers suppliers_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY trade_org.suppliers
    ADD CONSTRAINT suppliers_pkey PRIMARY KEY (supplier_id);
 E   ALTER TABLE ONLY trade_org.suppliers DROP CONSTRAINT suppliers_pkey;
    	   trade_org         	   trade_org    false    204            �           2606    16685    users users_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY trade_org.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 =   ALTER TABLE ONLY trade_org.users DROP CONSTRAINT users_pkey;
    	   trade_org         	   trade_org    false    220            �           2606    16687    users users_username_key 
   CONSTRAINT     Z   ALTER TABLE ONLY trade_org.users
    ADD CONSTRAINT users_username_key UNIQUE (username);
 E   ALTER TABLE ONLY trade_org.users DROP CONSTRAINT users_username_key;
    	   trade_org         	   trade_org    false    220            {           2606    16566    warehouses warehouses_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY trade_org.warehouses
    ADD CONSTRAINT warehouses_pkey PRIMARY KEY (warehouse_id);
 G   ALTER TABLE ONLY trade_org.warehouses DROP CONSTRAINT warehouses_pkey;
    	   trade_org         	   trade_org    false    206            }           2606    16568 (   warehouses warehouses_warehouse_name_key 
   CONSTRAINT     p   ALTER TABLE ONLY trade_org.warehouses
    ADD CONSTRAINT warehouses_warehouse_name_key UNIQUE (warehouse_name);
 U   ALTER TABLE ONLY trade_org.warehouses DROP CONSTRAINT warehouses_warehouse_name_key;
    	   trade_org         	   trade_org    false    206            �           2606    16601 #   inventory inventory_product_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY trade_org.inventory
    ADD CONSTRAINT inventory_product_id_fkey FOREIGN KEY (product_id) REFERENCES trade_org.products(product_id) ON DELETE CASCADE;
 P   ALTER TABLE ONLY trade_org.inventory DROP CONSTRAINT inventory_product_id_fkey;
    	   trade_org       	   trade_org    false    210    2943    208            �           2606    16606 %   inventory inventory_warehouse_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY trade_org.inventory
    ADD CONSTRAINT inventory_warehouse_id_fkey FOREIGN KEY (warehouse_id) REFERENCES trade_org.warehouses(warehouse_id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY trade_org.inventory DROP CONSTRAINT inventory_warehouse_id_fkey;
    	   trade_org       	   trade_org    false    206    2939    210            �           2606    16663 )   order_details order_details_order_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY trade_org.order_details
    ADD CONSTRAINT order_details_order_id_fkey FOREIGN KEY (order_id) REFERENCES trade_org.orders(order_id) ON DELETE CASCADE;
 V   ALTER TABLE ONLY trade_org.order_details DROP CONSTRAINT order_details_order_id_fkey;
    	   trade_org       	   trade_org    false    216    218    2953            �           2606    16668 +   order_details order_details_product_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY trade_org.order_details
    ADD CONSTRAINT order_details_product_id_fkey FOREIGN KEY (product_id) REFERENCES trade_org.products(product_id) ON DELETE CASCADE;
 X   ALTER TABLE ONLY trade_org.order_details DROP CONSTRAINT order_details_product_id_fkey;
    	   trade_org       	   trade_org    false    208    2943    218            �           2606    16643    orders orders_customer_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY trade_org.orders
    ADD CONSTRAINT orders_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES trade_org.customers(customer_id) ON DELETE SET NULL;
 K   ALTER TABLE ONLY trade_org.orders DROP CONSTRAINT orders_customer_id_fkey;
    	   trade_org       	   trade_org    false    216    212    2949            �           2606    16648    orders orders_employee_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY trade_org.orders
    ADD CONSTRAINT orders_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES trade_org.employees(employee_id) ON DELETE SET NULL;
 K   ALTER TABLE ONLY trade_org.orders DROP CONSTRAINT orders_employee_id_fkey;
    	   trade_org       	   trade_org    false    2951    216    214            �           2606    16582 "   products products_category_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY trade_org.products
    ADD CONSTRAINT products_category_id_fkey FOREIGN KEY (category_id) REFERENCES trade_org.categories(category_id) ON DELETE SET NULL;
 O   ALTER TABLE ONLY trade_org.products DROP CONSTRAINT products_category_id_fkey;
    	   trade_org       	   trade_org    false    2933    208    202            �           2606    16587 "   products products_supplier_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY trade_org.products
    ADD CONSTRAINT products_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES trade_org.suppliers(supplier_id) ON DELETE SET NULL;
 O   ALTER TABLE ONLY trade_org.products DROP CONSTRAINT products_supplier_id_fkey;
    	   trade_org       	   trade_org    false    204    2937    208               �   x�=���@��w��#�ۋ��L�7c��LA/ ��lG.��r������*(�H�5,J�< �%�(C*���B�}H8#��SϔG�#RԲRTI�YIxL8)�;��	��Zr�\c�U��.0%\5��+$�a�̡��[Y����p�C]�lt�e�߭i$�[7���E��?�՗
      %     x�m��N�@��ӧ����7Jw>��FFBh�i��+��+5���-��Bm_��yfjXh�δg�����	�B���������$�φl��A'ꅃc6�s�i�a@���6�S�l��x�=v�a	i��
��;�6|,����F��bx��Oa)�GQ_��1�۞�x����kPôT��:M�T\��D�7ԘX���A���E�o����҉���e�	Ve"��X���2+����ֽ��~\E�����6]/2����B`�+�H}�T,�N�������Y�����4�Ԓ(T�.��%����$U����BNԮʱ�k���2v̢6����¨*�Km�X������Ӄ�zImZꙦr�)����@�      '   �   x�}�M
�0��ӻ�LbZ�.�*�q%��	J�Z�z��9�֥��Ǜ��8�/�qsԸ���G��p@�������;���P&�"�'�P��(�^�q��Mƥ�,:�̋6��4�g�K)�=jH��\A^F����q��	e_@ �Q��*�;�C���p���Q����
<�L�d�L�>�J�eo�E�ǐE������ I���z      #   F   x��� 1�7s�F�K���p�0,:|��0.,�b"�*j���e�a-l^ܑ��\oi|�>Y      +   �   x�U�a� �?cVd������"����n��8�"r��JQyz���vO�M��B�V�oth�t�ck��В���1��#@|�xn݄�?��F[�y�D#��Ш����c��ݎ?�A2wt��*��b�.p      )   �   x�M���0гT����Z�������a	#�b�� �+;s��9K�<F�Qn�i�%`�0�oci�#�[��u��f)4z�iK�1�UT	����H��O�;�X�=}�הNP� �g���9� i{0�      !   '  x�mRKkQ^��+Φ�f�Q��3��Aj��lf1���Rwj�F�B-!}���4:������~�:Ӆ��2p�9��W�^�}3��f��T�꿩7�aS��J��8k��\o���i��	T�����?�	�9�:��_sdzf`x�s��{��͗��7��]��\KQ�(���q�c���s�S��ۡt^�w���%*�@`�ja�K�[��[7��*l�v�J��3]P��3�	�f�=��O�Ɇ����~�K�q��Ŧ�#�zx+(�Cz�
��(/�A�R _#�+k82�*/|^*Z��;,�78�]_������S\-LXCp�]�T	P�Tw�O�|,%P'�]���+�Y]U���T���;@�@;���)J�L9��J,[@{�[��eſl�mn=����pnY��<1!s���\�i���&�O�H���Ȃ����a7�����ku��8����V�g..dJ�8nR�[L�7�e�yl�Qt$�"Csh��`%�ЋWA�h�u�&�'�t��a��%�b-�X���������         �  x�m��N�@���S�]J(mi�� ^�Z�H����B4H����O&�� ���9��F�i�f���}���tq���`)۲x���f����0�q<1x����%ͥ���*s�|��"|O��쥹Îln,��ʹ�����Ӡ�W|O��{�L���1x�>`�?��H�a+٥�#��wt!�� ���݂���s���#[���5�XkM�z��=����-�4�T��b]\"Y%%�N`Fb�r�͖dIQ4G��p��F�V���Uё��i��$������.u�x�ক�lG+d�s�ꉠvF,&uf�'�O����\w��!:���%�4��Vn�ՠY,_P���j����K��N�'��/t�s,;C?*�^�?���cW�����Yy{{d܆N|�+E:=�w�I�R�~�g      -   f  x�m��r�0  �3|E^�$oE,(L/aqa�lZ���hǙ��A��Ź��@4�۩�}�է�"}gPr0�����Y�7���-h�[�n�s�.2ټ <�Jo��2�H P��G\AKzL�ǳςʤ��1��31�r�u\�����$�a,&��	��դ�,��W��!/q4�XW��lY�����5�K�M�3�:;�Jw��N�&��ڡ��:J���V�g��7!/s7Z''�5ɣ�8lr�3#nW�4:���	�⣹f"����z]@x������I�@A2����I�f���"gf`�1��N�9ĩw^G����%�S�	Ep�k�ݝx�`ER��%�<�/h��         �   x�}�A�0E��)z $�H�a<��ĸp�� %�9�I���h'3Ӿ�g"�=T�)�1ц���'��C�pB��%R{�K#z�����O��r���o���7V��]�"-cO���~��5:J�[�젥�����\z����M����@�IihV�rf�J&���n����'�מ�9v/�c���/C��y     