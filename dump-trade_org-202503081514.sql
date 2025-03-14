PGDMP     ;                    }         	   trade_org    12.22    12.22 Z    w           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            x           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            y           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            z           1262    16489 	   trade_org    DATABASE     �   CREATE DATABASE trade_org WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Russian_Russia.1251' LC_CTYPE = 'Russian_Russia.1251';
    DROP DATABASE trade_org;
             	   trade_org    false                        2615    16616    tradeorg    SCHEMA        CREATE SCHEMA tradeorg;
    DROP SCHEMA tradeorg;
             	   trade_org    false            �            1259    16619 
   categories    TABLE     z   CREATE TABLE tradeorg.categories (
    category_id integer NOT NULL,
    category_name character varying(100) NOT NULL
);
     DROP TABLE tradeorg.categories;
       tradeorg         heap 	   trade_org    false    8            �            1259    16617    categories_category_id_seq    SEQUENCE     �   CREATE SEQUENCE tradeorg.categories_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE tradeorg.categories_category_id_seq;
       tradeorg       	   trade_org    false    8    204            {           0    0    categories_category_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE tradeorg.categories_category_id_seq OWNED BY tradeorg.categories.category_id;
          tradeorg       	   trade_org    false    203            �            1259    16660 	   customers    TABLE     �   CREATE TABLE tradeorg.customers (
    customer_id integer NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    email character varying(100),
    phone character varying(20),
    address text
);
    DROP TABLE tradeorg.customers;
       tradeorg         heap 	   trade_org    false    8            |           0    0    TABLE customers    ACL     �   GRANT SELECT,INSERT,UPDATE ON TABLE tradeorg.customers TO manager;
GRANT SELECT,INSERT,UPDATE ON TABLE tradeorg.customers TO sales;
          tradeorg       	   trade_org    false    210            �            1259    16658    customers_customer_id_seq    SEQUENCE     �   CREATE SEQUENCE tradeorg.customers_customer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE tradeorg.customers_customer_id_seq;
       tradeorg       	   trade_org    false    210    8            }           0    0    customers_customer_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE tradeorg.customers_customer_id_seq OWNED BY tradeorg.customers.customer_id;
          tradeorg       	   trade_org    false    209            �            1259    16671 	   employees    TABLE       CREATE TABLE tradeorg.employees (
    employee_id integer NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    "position" character varying(100) NOT NULL,
    hire_date date NOT NULL,
    salary numeric(10,2) NOT NULL
);
    DROP TABLE tradeorg.employees;
       tradeorg         heap 	   trade_org    false    8            �            1259    16669    employees_employee_id_seq    SEQUENCE     �   CREATE SEQUENCE tradeorg.employees_employee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE tradeorg.employees_employee_id_seq;
       tradeorg       	   trade_org    false    8    212            ~           0    0    employees_employee_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE tradeorg.employees_employee_id_seq OWNED BY tradeorg.employees.employee_id;
          tradeorg       	   trade_org    false    211            �            1259    16726 	   inventory    TABLE     �   CREATE TABLE tradeorg.inventory (
    inventory_id integer NOT NULL,
    product_id integer,
    warehouse_id integer,
    quantity integer NOT NULL
);
    DROP TABLE tradeorg.inventory;
       tradeorg         heap 	   trade_org    false    8                       0    0    TABLE inventory    ACL     E   GRANT SELECT,INSERT,UPDATE ON TABLE tradeorg.inventory TO warehouse;
          tradeorg       	   trade_org    false    220            �            1259    16724    inventory_inventory_id_seq    SEQUENCE     �   CREATE SEQUENCE tradeorg.inventory_inventory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE tradeorg.inventory_inventory_id_seq;
       tradeorg       	   trade_org    false    220    8            �           0    0    inventory_inventory_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE tradeorg.inventory_inventory_id_seq OWNED BY tradeorg.inventory.inventory_id;
          tradeorg       	   trade_org    false    219            �            1259    16697    order_details    TABLE     �   CREATE TABLE tradeorg.order_details (
    order_detail_id integer NOT NULL,
    order_id integer,
    product_id integer,
    quantity integer NOT NULL,
    unit_price numeric(10,2) NOT NULL
);
 #   DROP TABLE tradeorg.order_details;
       tradeorg         heap 	   trade_org    false    8            �           0    0    TABLE order_details    ACL     �   GRANT SELECT,INSERT,UPDATE ON TABLE tradeorg.order_details TO manager;
GRANT SELECT ON TABLE tradeorg.order_details TO accountant;
GRANT SELECT,INSERT,UPDATE ON TABLE tradeorg.order_details TO sales;
          tradeorg       	   trade_org    false    216            �            1259    16695 !   order_details_order_detail_id_seq    SEQUENCE     �   CREATE SEQUENCE tradeorg.order_details_order_detail_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE tradeorg.order_details_order_detail_id_seq;
       tradeorg       	   trade_org    false    8    216            �           0    0 !   order_details_order_detail_id_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE tradeorg.order_details_order_detail_id_seq OWNED BY tradeorg.order_details.order_detail_id;
          tradeorg       	   trade_org    false    215            �            1259    16679    orders    TABLE     �   CREATE TABLE tradeorg.orders (
    order_id integer NOT NULL,
    customer_id integer,
    employee_id integer,
    order_date date NOT NULL,
    total_amount numeric(10,2) NOT NULL
);
    DROP TABLE tradeorg.orders;
       tradeorg         heap 	   trade_org    false    8            �           0    0    TABLE orders    ACL     �   GRANT SELECT,INSERT,UPDATE ON TABLE tradeorg.orders TO manager;
GRANT SELECT ON TABLE tradeorg.orders TO accountant;
GRANT SELECT,INSERT,UPDATE ON TABLE tradeorg.orders TO sales;
          tradeorg       	   trade_org    false    214            �            1259    16677    orders_order_id_seq    SEQUENCE     �   CREATE SEQUENCE tradeorg.orders_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE tradeorg.orders_order_id_seq;
       tradeorg       	   trade_org    false    8    214            �           0    0    orders_order_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE tradeorg.orders_order_id_seq OWNED BY tradeorg.orders.order_id;
          tradeorg       	   trade_org    false    213            �            1259    16639    products    TABLE     
  CREATE TABLE tradeorg.products (
    product_id integer NOT NULL,
    product_name character varying(100) NOT NULL,
    category_id integer,
    supplier_id integer,
    unit_price numeric(10,2) NOT NULL,
    units_in_stock integer NOT NULL,
    description text
);
    DROP TABLE tradeorg.products;
       tradeorg         heap 	   trade_org    false    8            �           0    0    TABLE products    ACL     B   GRANT SELECT,INSERT,UPDATE ON TABLE tradeorg.products TO manager;
          tradeorg       	   trade_org    false    208            �            1259    16637    products_product_id_seq    SEQUENCE     �   CREATE SEQUENCE tradeorg.products_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE tradeorg.products_product_id_seq;
       tradeorg       	   trade_org    false    208    8            �           0    0    products_product_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE tradeorg.products_product_id_seq OWNED BY tradeorg.products.product_id;
          tradeorg       	   trade_org    false    207            �            1259    16627 	   suppliers    TABLE     �   CREATE TABLE tradeorg.suppliers (
    supplier_id integer NOT NULL,
    supplier_name character varying(100) NOT NULL,
    contact_name character varying(100),
    address text,
    phone character varying(20),
    email character varying(100)
);
    DROP TABLE tradeorg.suppliers;
       tradeorg         heap 	   trade_org    false    8            �            1259    16625    suppliers_supplier_id_seq    SEQUENCE     �   CREATE SEQUENCE tradeorg.suppliers_supplier_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE tradeorg.suppliers_supplier_id_seq;
       tradeorg       	   trade_org    false    206    8            �           0    0    suppliers_supplier_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE tradeorg.suppliers_supplier_id_seq OWNED BY tradeorg.suppliers.supplier_id;
          tradeorg       	   trade_org    false    205            �            1259    16819    users    TABLE       CREATE TABLE tradeorg.users (
    user_id integer NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(50) NOT NULL,
    role character varying(50) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE tradeorg.users;
       tradeorg         heap 	   trade_org    false    8            �            1259    16817    users_user_id_seq    SEQUENCE     �   CREATE SEQUENCE tradeorg.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE tradeorg.users_user_id_seq;
       tradeorg       	   trade_org    false    8    222            �           0    0    users_user_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE tradeorg.users_user_id_seq OWNED BY tradeorg.users.user_id;
          tradeorg       	   trade_org    false    221            �            1259    16715 
   warehouses    TABLE     �   CREATE TABLE tradeorg.warehouses (
    warehouse_id integer NOT NULL,
    warehouse_name character varying(100) NOT NULL,
    address text
);
     DROP TABLE tradeorg.warehouses;
       tradeorg         heap 	   trade_org    false    8            �           0    0    TABLE warehouses    ACL     F   GRANT SELECT,INSERT,UPDATE ON TABLE tradeorg.warehouses TO warehouse;
          tradeorg       	   trade_org    false    218            �            1259    16713    warehouses_warehouse_id_seq    SEQUENCE     �   CREATE SEQUENCE tradeorg.warehouses_warehouse_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE tradeorg.warehouses_warehouse_id_seq;
       tradeorg       	   trade_org    false    8    218            �           0    0    warehouses_warehouse_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE tradeorg.warehouses_warehouse_id_seq OWNED BY tradeorg.warehouses.warehouse_id;
          tradeorg       	   trade_org    false    217            �
           2604    16622    categories category_id    DEFAULT     �   ALTER TABLE ONLY tradeorg.categories ALTER COLUMN category_id SET DEFAULT nextval('tradeorg.categories_category_id_seq'::regclass);
 G   ALTER TABLE tradeorg.categories ALTER COLUMN category_id DROP DEFAULT;
       tradeorg       	   trade_org    false    204    203    204            �
           2604    16663    customers customer_id    DEFAULT     �   ALTER TABLE ONLY tradeorg.customers ALTER COLUMN customer_id SET DEFAULT nextval('tradeorg.customers_customer_id_seq'::regclass);
 F   ALTER TABLE tradeorg.customers ALTER COLUMN customer_id DROP DEFAULT;
       tradeorg       	   trade_org    false    210    209    210            �
           2604    16674    employees employee_id    DEFAULT     �   ALTER TABLE ONLY tradeorg.employees ALTER COLUMN employee_id SET DEFAULT nextval('tradeorg.employees_employee_id_seq'::regclass);
 F   ALTER TABLE tradeorg.employees ALTER COLUMN employee_id DROP DEFAULT;
       tradeorg       	   trade_org    false    211    212    212            �
           2604    16729    inventory inventory_id    DEFAULT     �   ALTER TABLE ONLY tradeorg.inventory ALTER COLUMN inventory_id SET DEFAULT nextval('tradeorg.inventory_inventory_id_seq'::regclass);
 G   ALTER TABLE tradeorg.inventory ALTER COLUMN inventory_id DROP DEFAULT;
       tradeorg       	   trade_org    false    220    219    220            �
           2604    16700    order_details order_detail_id    DEFAULT     �   ALTER TABLE ONLY tradeorg.order_details ALTER COLUMN order_detail_id SET DEFAULT nextval('tradeorg.order_details_order_detail_id_seq'::regclass);
 N   ALTER TABLE tradeorg.order_details ALTER COLUMN order_detail_id DROP DEFAULT;
       tradeorg       	   trade_org    false    215    216    216            �
           2604    16682    orders order_id    DEFAULT     v   ALTER TABLE ONLY tradeorg.orders ALTER COLUMN order_id SET DEFAULT nextval('tradeorg.orders_order_id_seq'::regclass);
 @   ALTER TABLE tradeorg.orders ALTER COLUMN order_id DROP DEFAULT;
       tradeorg       	   trade_org    false    214    213    214            �
           2604    16642    products product_id    DEFAULT     ~   ALTER TABLE ONLY tradeorg.products ALTER COLUMN product_id SET DEFAULT nextval('tradeorg.products_product_id_seq'::regclass);
 D   ALTER TABLE tradeorg.products ALTER COLUMN product_id DROP DEFAULT;
       tradeorg       	   trade_org    false    207    208    208            �
           2604    16630    suppliers supplier_id    DEFAULT     �   ALTER TABLE ONLY tradeorg.suppliers ALTER COLUMN supplier_id SET DEFAULT nextval('tradeorg.suppliers_supplier_id_seq'::regclass);
 F   ALTER TABLE tradeorg.suppliers ALTER COLUMN supplier_id DROP DEFAULT;
       tradeorg       	   trade_org    false    205    206    206            �
           2604    16822    users user_id    DEFAULT     r   ALTER TABLE ONLY tradeorg.users ALTER COLUMN user_id SET DEFAULT nextval('tradeorg.users_user_id_seq'::regclass);
 >   ALTER TABLE tradeorg.users ALTER COLUMN user_id DROP DEFAULT;
       tradeorg       	   trade_org    false    221    222    222            �
           2604    16718    warehouses warehouse_id    DEFAULT     �   ALTER TABLE ONLY tradeorg.warehouses ALTER COLUMN warehouse_id SET DEFAULT nextval('tradeorg.warehouses_warehouse_id_seq'::regclass);
 H   ALTER TABLE tradeorg.warehouses ALTER COLUMN warehouse_id DROP DEFAULT;
       tradeorg       	   trade_org    false    218    217    218            b          0    16619 
   categories 
   TABLE DATA           B   COPY tradeorg.categories (category_id, category_name) FROM stdin;
    tradeorg       	   trade_org    false    204   m       h          0    16660 	   customers 
   TABLE DATA           `   COPY tradeorg.customers (customer_id, first_name, last_name, email, phone, address) FROM stdin;
    tradeorg       	   trade_org    false    210   �m       j          0    16671 	   employees 
   TABLE DATA           h   COPY tradeorg.employees (employee_id, first_name, last_name, "position", hire_date, salary) FROM stdin;
    tradeorg       	   trade_org    false    212   �n       r          0    16726 	   inventory 
   TABLE DATA           W   COPY tradeorg.inventory (inventory_id, product_id, warehouse_id, quantity) FROM stdin;
    tradeorg       	   trade_org    false    220   �o       n          0    16697    order_details 
   TABLE DATA           f   COPY tradeorg.order_details (order_detail_id, order_id, product_id, quantity, unit_price) FROM stdin;
    tradeorg       	   trade_org    false    216   �o       l          0    16679    orders 
   TABLE DATA           `   COPY tradeorg.orders (order_id, customer_id, employee_id, order_date, total_amount) FROM stdin;
    tradeorg       	   trade_org    false    214   Vp       f          0    16639    products 
   TABLE DATA           �   COPY tradeorg.products (product_id, product_name, category_id, supplier_id, unit_price, units_in_stock, description) FROM stdin;
    tradeorg       	   trade_org    false    208   �p       d          0    16627 	   suppliers 
   TABLE DATA           f   COPY tradeorg.suppliers (supplier_id, supplier_name, contact_name, address, phone, email) FROM stdin;
    tradeorg       	   trade_org    false    206   dr       t          0    16819    users 
   TABLE DATA           P   COPY tradeorg.users (user_id, username, password, role, created_at) FROM stdin;
    tradeorg       	   trade_org    false    222   �s       p          0    16715 
   warehouses 
   TABLE DATA           M   COPY tradeorg.warehouses (warehouse_id, warehouse_name, address) FROM stdin;
    tradeorg       	   trade_org    false    218   ot       �           0    0    categories_category_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('tradeorg.categories_category_id_seq', 5, true);
          tradeorg       	   trade_org    false    203            �           0    0    customers_customer_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('tradeorg.customers_customer_id_seq', 5, true);
          tradeorg       	   trade_org    false    209            �           0    0    employees_employee_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('tradeorg.employees_employee_id_seq', 5, true);
          tradeorg       	   trade_org    false    211            �           0    0    inventory_inventory_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('tradeorg.inventory_inventory_id_seq', 10, true);
          tradeorg       	   trade_org    false    219            �           0    0 !   order_details_order_detail_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('tradeorg.order_details_order_detail_id_seq', 7, true);
          tradeorg       	   trade_org    false    215            �           0    0    orders_order_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('tradeorg.orders_order_id_seq', 5, true);
          tradeorg       	   trade_org    false    213            �           0    0    products_product_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('tradeorg.products_product_id_seq', 10, true);
          tradeorg       	   trade_org    false    207            �           0    0    suppliers_supplier_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('tradeorg.suppliers_supplier_id_seq', 5, true);
          tradeorg       	   trade_org    false    205            �           0    0    users_user_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('tradeorg.users_user_id_seq', 5, true);
          tradeorg       	   trade_org    false    221            �           0    0    warehouses_warehouse_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('tradeorg.warehouses_warehouse_id_seq', 3, true);
          tradeorg       	   trade_org    false    217            �
           2606    16624    categories categories_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY tradeorg.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (category_id);
 F   ALTER TABLE ONLY tradeorg.categories DROP CONSTRAINT categories_pkey;
       tradeorg         	   trade_org    false    204            �
           2606    16668    customers customers_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY tradeorg.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (customer_id);
 D   ALTER TABLE ONLY tradeorg.customers DROP CONSTRAINT customers_pkey;
       tradeorg         	   trade_org    false    210            �
           2606    16676    employees employees_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY tradeorg.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (employee_id);
 D   ALTER TABLE ONLY tradeorg.employees DROP CONSTRAINT employees_pkey;
       tradeorg         	   trade_org    false    212            �
           2606    16731    inventory inventory_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY tradeorg.inventory
    ADD CONSTRAINT inventory_pkey PRIMARY KEY (inventory_id);
 D   ALTER TABLE ONLY tradeorg.inventory DROP CONSTRAINT inventory_pkey;
       tradeorg         	   trade_org    false    220            �
           2606    16702     order_details order_details_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY tradeorg.order_details
    ADD CONSTRAINT order_details_pkey PRIMARY KEY (order_detail_id);
 L   ALTER TABLE ONLY tradeorg.order_details DROP CONSTRAINT order_details_pkey;
       tradeorg         	   trade_org    false    216            �
           2606    16684    orders orders_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY tradeorg.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);
 >   ALTER TABLE ONLY tradeorg.orders DROP CONSTRAINT orders_pkey;
       tradeorg         	   trade_org    false    214            �
           2606    16647    products products_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY tradeorg.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);
 B   ALTER TABLE ONLY tradeorg.products DROP CONSTRAINT products_pkey;
       tradeorg         	   trade_org    false    208            �
           2606    16635    suppliers suppliers_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY tradeorg.suppliers
    ADD CONSTRAINT suppliers_pkey PRIMARY KEY (supplier_id);
 D   ALTER TABLE ONLY tradeorg.suppliers DROP CONSTRAINT suppliers_pkey;
       tradeorg         	   trade_org    false    206            �
           2606    16825    users users_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY tradeorg.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 <   ALTER TABLE ONLY tradeorg.users DROP CONSTRAINT users_pkey;
       tradeorg         	   trade_org    false    222            �
           2606    16827    users users_username_key 
   CONSTRAINT     Y   ALTER TABLE ONLY tradeorg.users
    ADD CONSTRAINT users_username_key UNIQUE (username);
 D   ALTER TABLE ONLY tradeorg.users DROP CONSTRAINT users_username_key;
       tradeorg         	   trade_org    false    222            �
           2606    16723    warehouses warehouses_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY tradeorg.warehouses
    ADD CONSTRAINT warehouses_pkey PRIMARY KEY (warehouse_id);
 F   ALTER TABLE ONLY tradeorg.warehouses DROP CONSTRAINT warehouses_pkey;
       tradeorg         	   trade_org    false    218            �
           2606    16732 #   inventory inventory_product_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY tradeorg.inventory
    ADD CONSTRAINT inventory_product_id_fkey FOREIGN KEY (product_id) REFERENCES tradeorg.products(product_id);
 O   ALTER TABLE ONLY tradeorg.inventory DROP CONSTRAINT inventory_product_id_fkey;
       tradeorg       	   trade_org    false    2762    208    220            �
           2606    16737 %   inventory inventory_warehouse_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY tradeorg.inventory
    ADD CONSTRAINT inventory_warehouse_id_fkey FOREIGN KEY (warehouse_id) REFERENCES tradeorg.warehouses(warehouse_id);
 Q   ALTER TABLE ONLY tradeorg.inventory DROP CONSTRAINT inventory_warehouse_id_fkey;
       tradeorg       	   trade_org    false    2772    220    218            �
           2606    16703 )   order_details order_details_order_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY tradeorg.order_details
    ADD CONSTRAINT order_details_order_id_fkey FOREIGN KEY (order_id) REFERENCES tradeorg.orders(order_id);
 U   ALTER TABLE ONLY tradeorg.order_details DROP CONSTRAINT order_details_order_id_fkey;
       tradeorg       	   trade_org    false    214    216    2768            �
           2606    16708 +   order_details order_details_product_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY tradeorg.order_details
    ADD CONSTRAINT order_details_product_id_fkey FOREIGN KEY (product_id) REFERENCES tradeorg.products(product_id);
 W   ALTER TABLE ONLY tradeorg.order_details DROP CONSTRAINT order_details_product_id_fkey;
       tradeorg       	   trade_org    false    2762    208    216            �
           2606    16685    orders orders_customer_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY tradeorg.orders
    ADD CONSTRAINT orders_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES tradeorg.customers(customer_id);
 J   ALTER TABLE ONLY tradeorg.orders DROP CONSTRAINT orders_customer_id_fkey;
       tradeorg       	   trade_org    false    214    210    2764            �
           2606    16690    orders orders_employee_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY tradeorg.orders
    ADD CONSTRAINT orders_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES tradeorg.employees(employee_id);
 J   ALTER TABLE ONLY tradeorg.orders DROP CONSTRAINT orders_employee_id_fkey;
       tradeorg       	   trade_org    false    2766    212    214            �
           2606    16648 "   products products_category_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY tradeorg.products
    ADD CONSTRAINT products_category_id_fkey FOREIGN KEY (category_id) REFERENCES tradeorg.categories(category_id);
 N   ALTER TABLE ONLY tradeorg.products DROP CONSTRAINT products_category_id_fkey;
       tradeorg       	   trade_org    false    204    2758    208            �
           2606    16653 "   products products_supplier_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY tradeorg.products
    ADD CONSTRAINT products_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES tradeorg.suppliers(supplier_id);
 N   ALTER TABLE ONLY tradeorg.products DROP CONSTRAINT products_supplier_id_fkey;
       tradeorg       	   trade_org    false    208    2760    206            b   k   x���	�@E�3U����v�b��уw��DâhZx�Qƽ|>��*����j�;���7a`v��Mz��g{���#[$��uZ}�?dm���a���ٛ���UU�V	H�      h     x�]��J�@��3O��%dn�|�nL+�*��ą����X��������y&%�v1g���9��5J,ݘ�o�9~P�VXc�l�\�m���9;�E$�Ҧ37Ex�_+Tt�N �OX�p�Di�X�� �LN�0�Ӂ�%�]��-y��P-;�ᱱ�4d��Q�/��q?�W�Hc��J���� �Q���ݭo��+|b�A��Yv�g���Rl-ߚey��f;(���(�t׍]za{�B��9~}.��"ٹ�N`x/��<���      j   �   x�E�aJ�0�O�e�6�w�0�a�U��(��J��]c{�77��b �	y�|/�aDo�Ohm�#�my�	^y��=�0X#����;$(�J�(�mlk|ܦ��n�℈	]�zg�����`w	�VΫ���S��M~��L�6�vC�e����_9�T�X0����!����ﱣ�/�#�tn�9�<Z����IΨ@�(��?b�'�9��������s� Ղ�^E�`̽J      r   H   x�%���0�0L�;qv��s���s.��a��Xb")�]H\X�7��5�jŃ����F��C�k��      n   H   x�M���0�f�4�.���$��_w6؊+���z����r��1����'El����`� ���&"/��      l   H   x�M�� 1B�q�6(u����zwi�^������ӓ���>�+B�,�b?)�y"�W	��4�_��      f   �  x�e��J�P���<�Pp[�4��R�wpi�����E��KA]yCE��K%mm|�����Tl�CINf曙Nhp�O��֮ �Ԅ�(�&	��vDO0�6RL��S��D�14ǫ�n�kO�x����@k��C��\1Ԏv����խ�֦,o�dc���4:'#5-L
p�?����E';a�уr��.��S�:�ڬ�FP�	�'���2���<��x	r����tWv���haA���+�9�ں����s��(�p�Ϲ$�&��H��N����<f�&�
�<�9d�E0�bb�L�:�wNT�7��;}��G��l������ĿWb��r�z瓰[^�����f�C�/��u�z��Ih�L�8(��'�s���Օ%Y�����o�ې��<Ç,�yT87g�+�[�]�Zk��I��      d   q  x�U�KN�0���)���j'ia���1$����� eׇ��@*,P��8 R��r���!�Md�3��ߘ��$��C݇�����|�RZ���l�^���0�PV#�#Vc�v�z��W��Qp+�{UuiqS�_@��aE�@�{���9r�zLaI�%j�G��%��Y���؜��P��{ʶ!�;̈����3�(�"�X������˩%�	K��\�b�u]�ql��(�yM)��P���A;&�V�MآW���15)L���E���ל�R���6m��1"�3�Hyq-U��K0��Ɍz[�i���sFf�3�,�����.��vz\���2�9���0V7^�#U��8P�{\�,�"�,�      t   z   x�}�A@0E��)\@�-�,6$T�����Zu���?y3��_&�x#JԹ,rYg�Y7DYB��#[��`�oz��}�����d��}~�E�b'mf\g��x��f�f�z*��
��>L      p   Y   x�3估�®�/l��E���b��z
f_�za�@�AG�Ȁ�Y�L����;��Pu��\���a�&��/l�� 7є+F��� T�C�     