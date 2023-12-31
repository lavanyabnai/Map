-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "email" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "Password" (
    "hash" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    CONSTRAINT "Password_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Note" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "title" TEXT NOT NULL,
    "body" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "userId" TEXT NOT NULL,
    CONSTRAINT "Note_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "attribute_master" (
    "attribute_code" TEXT NOT NULL,
    "site_level_id" INTEGER,
    "column_name" TEXT,
    "attribute_description" TEXT,
    "column_mapping" TEXT,
    "seller_level_id" INTEGER NOT NULL,
    "product_level_id" INTEGER NOT NULL,
    "dimensionality" INTEGER,
    "nav_tree" TEXT,
    "layout" INTEGER,
    "sys_nc_type" TEXT,
    "level_id" INTEGER,

    PRIMARY KEY ("attribute_code", "seller_level_id", "product_level_id")
);

-- CreateTable
CREATE TABLE "ccy_conversion_master" (
    "bkt" INTEGER NOT NULL,
    "ccy_code" TEXT NOT NULL,
    "exchange_rate" REAL,

    PRIMARY KEY ("bkt", "ccy_code")
);

-- CreateTable
CREATE TABLE "currency_conversion" (
    "bkt" INTEGER NOT NULL,
    "currency_code" TEXT NOT NULL,
    "exchange_rate" REAL,

    PRIMARY KEY ("bkt", "currency_code")
);

-- CreateTable
CREATE TABLE "customer_master" (
    "scenario_name" TEXT NOT NULL,
    "customer" TEXT NOT NULL,
    "customer_desc" TEXT,
    "all_sales" TEXT,
    "all_sales_desc" TEXT,
    "region" TEXT,
    "region_desc" TEXT,
    "country" TEXT,
    "country_desc" TEXT,
    "customer_priority" TEXT,
    "customer_type" TEXT,

    PRIMARY KEY ("scenario_name", "customer")
);

-- CreateTable
CREATE TABLE "demand_cube" (
    "customer" TEXT NOT NULL,
    "site" TEXT NOT NULL,
    "sku" TEXT NOT NULL,
    "bucket" INTEGER NOT NULL,
    "edit" INTEGER,
    "lifecycle_code" TEXT,
    "order_id" TEXT,
    "booking_id" TEXT,
    "invoice_id" TEXT,
    "selling_price" REAL,
    "mkt_fcst_qty" INTEGER,
    "cons_fcst_qty" INTEGER,
    "cust_fcst_qty" INTEGER,
    "fin_fcst_qty" INTEGER,
    "mnth2_sales_fcst_qty" INTEGER,
    "mnth3_sales_fcst_qty" INTEGER,
    "fcst_accuracy" REAL,
    "order_date" DATETIME,
    "order_status" TEXT,
    "order_return" INTEGER,
    "order_cancel" INTEGER,
    "order_open" INTEGER,
    "order_past_due" INTEGER,
    "order_discount" INTEGER,
    "ord_invoice_cycle_time" REAL,
    "ship_date" DATETIME,
    "ship_chnl_type" TEXT,
    "ship_chnl_qty" REAL,
    "deliv_date" DATETIME,
    "late_ship" INTEGER,
    "ontime_ship" INTEGER,
    "perfect_order" INTEGER,
    "sales_qty" INTEGER,
    "gross_sales" REAL,
    "mape" REAL,
    "ontime_infull" REAL,
    "backlog" INTEGER,

    PRIMARY KEY ("customer", "site", "sku", "bucket")
);

-- CreateTable
CREATE TABLE "dimension_master" (
    "dimension_id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "dimension_code" TEXT,
    "description" TEXT,
    "leaf_column_name" TEXT,
    "status" TEXT
);

-- CreateTable
CREATE TABLE "dimension_member_relationship" (
    "scenario_name" TEXT NOT NULL,
    "site" TEXT NOT NULL,
    "customer" TEXT NOT NULL,
    "product" TEXT NOT NULL,

    PRIMARY KEY ("scenario_name", "site", "customer", "product")
);

-- CreateTable
CREATE TABLE "hierarchy_master" (
    "hierarchy_id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "hierarchy_code" TEXT NOT NULL,
    "hierarchy_description" TEXT,
    "dimension_id" INTEGER
);

-- CreateTable
CREATE TABLE "integrated_dim_measure" (
    "customer" TEXT NOT NULL,
    "site" TEXT NOT NULL,
    "sku" TEXT NOT NULL,
    "bucket" INTEGER NOT NULL,
    "edit" INTEGER,
    "lifecycle_code" TEXT,
    "plan_ccf" REAL,
    "actual_ccf" REAL,
    "plan_mar" REAL,
    "actual_mar" REAL,
    "mkt_fcst_qty" INTEGER,
    "cons_fcst_qty" INTEGER,
    "cust_fcst_qty" INTEGER,
    "fin_fcst_qty" INTEGER,
    "eoh_w" INTEGER,
    "on_hand" INTEGER,
    "prev_sales_fcst_qty" INTEGER,
    "sales_fcst_qty" INTEGER,
    "sell_in_qty" INTEGER,
    "sell_th_qty" INTEGER,
    "gross_sales" INTEGER,
    "mnth2_sales_fcst_qty" INTEGER,
    "mnth3_sales_fcst_qty" INTEGER,
    "fin_dep_amort_cost" REAL,
    "internal_exp" REAL,
    "market_exp" REAL,
    "other_inc_exp" INTEGER,
    "pos_qty" INTEGER,
    "prod_cost" REAL,
    "salary_cost" REAL,
    "sales_allow" REAL,
    "ship_cost" REAL,
    "transp_cost" REAL,
    "selling_price" REAL,
    "target_plan" INTEGER,
    "tax" REAL,
    "te_cost" REAL,

    PRIMARY KEY ("customer", "site", "sku", "bucket")
);

-- CreateTable
CREATE TABLE "level_master" (
    "level_id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "level_code" TEXT,
    "column_name" TEXT NOT NULL,
    "level_description" TEXT,
    "dimension_id" INTEGER,
    "link_data_table" TEXT,
    "hierarchy_id" INTEGER,
    "child_level_id" INTEGER
);

-- CreateTable
CREATE TABLE "level_relationship" (
    "hierarchy_id" INTEGER NOT NULL,
    "child_level_id" INTEGER NOT NULL,
    "parent_level_id" INTEGER NOT NULL,

    PRIMARY KEY ("hierarchy_id", "child_level_id")
);

-- CreateTable
CREATE TABLE "measure_master" (
    "measure_id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "measure_code" TEXT,
    "measure_description" TEXT,
    "measure_type" TEXT,
    "number_format" TEXT,
    "column_name" TEXT,
    "rw_flag" TEXT,
    "computation_type" TEXT,
    "expression" TEXT,
    "site_io_level_id" INTEGER,
    "seller_io_level_id" INTEGER,
    "product_io_level_id" INTEGER,
    "time_io_level_id" INTEGER,
    "category1" TEXT,
    "category2" TEXT,
    "ccy_base" TEXT,
    "data_tbl_name" TEXT,
    "aggregation" TEXT,
    "disaggregation" TEXT,
    "copy_to_archive" INTEGER,
    "copy_to_history" INTEGER,
    "waterfall" INTEGER
);

-- CreateTable
CREATE TABLE "product_customer" (
    "scenario_name" TEXT NOT NULL,
    "sku" TEXT NOT NULL,
    "customer" TEXT NOT NULL,

    PRIMARY KEY ("scenario_name", "sku", "customer")
);

-- CreateTable
CREATE TABLE "product_master" (
    "scenario_name" TEXT NOT NULL,
    "sku" TEXT NOT NULL,
    "unit_price" INTEGER,
    "category" TEXT,
    "all_products" TEXT,
    "all_products_desc" TEXT,
    "product_group" TEXT,
    "product_group_desc" TEXT,
    "product_family" TEXT,
    "product_family_desc" TEXT,
    "calendar_pref" INTEGER,
    "product_color" TEXT,

    PRIMARY KEY ("scenario_name", "sku")
);

-- CreateTable
CREATE TABLE "product_site_customer" (
    "scenario_name" TEXT NOT NULL,
    "sku" TEXT NOT NULL,
    "site" TEXT NOT NULL,
    "customer" TEXT NOT NULL,

    PRIMARY KEY ("scenario_name", "sku", "site", "customer")
);

-- CreateTable
CREATE TABLE "product_site_master" (
    "scenario_name" TEXT NOT NULL,
    "sku" TEXT NOT NULL,
    "site" TEXT NOT NULL,
    "replenish_policy" TEXT,
    "is_flexible" INTEGER,
    "rank" INTEGER,
    "default_min_on_hand" INTEGER,
    "default_max_on_hand" INTEGER,
    "column_name" INTEGER,
    "default_days_of_coverage" INTEGER,
    "default_max_days_coverage" INTEGER,

    PRIMARY KEY ("scenario_name", "sku", "site")
);

-- CreateTable
CREATE TABLE "site_master" (
    "scenario_name" TEXT NOT NULL,
    "site" TEXT NOT NULL,
    "site_desc" TEXT,
    "site_type" TEXT,
    "all_sites" TEXT,
    "all_sites_desc" TEXT,
    "local_currency" TEXT,

    PRIMARY KEY ("scenario_name", "site")
);

-- CreateTable
CREATE TABLE "time_master" (
    "time_bucket_id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "bucket_date" TEXT,
    "bucket_date_desc" TEXT,
    "all_cal_time" REAL,
    "all_cal_time_desc" TEXT,
    "cal_year" INTEGER,
    "cal_year_desc" TEXT,
    "cal_qtr" INTEGER,
    "cal_qtr_desc" TEXT,
    "cal_month" INTEGER,
    "cal_month_desc" TEXT,
    "all_fsc_time" REAL,
    "all_fsc_time_desc" TEXT,
    "fsc_year" INTEGER,
    "fsc_year_desc" TEXT,
    "fsc_qtr" INTEGER,
    "fsc_qtr_desc" TEXT,
    "fsc_month" INTEGER,
    "fsc_month_desc" TEXT
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Password_userId_key" ON "Password"("userId");

-- CreateIndex
CREATE INDEX "attribute_master_site_level_id_index" ON "attribute_master"("site_level_id");

-- CreateIndex
CREATE INDEX "attribute_master_seller_level_id_index" ON "attribute_master"("seller_level_id");

-- CreateIndex
CREATE INDEX "attribute_master_product_level_id_index" ON "attribute_master"("product_level_id");

-- CreateIndex
CREATE INDEX "hierarchy_master_dimension_id_index" ON "hierarchy_master"("dimension_id");

-- CreateIndex
CREATE INDEX "level_master_dimension_id_index" ON "level_master"("dimension_id");

-- CreateIndex
CREATE INDEX "level_relationship_parent_level_id_index" ON "level_relationship"("parent_level_id");

-- CreateIndex
CREATE INDEX "level_relationship_parent_level_id_child_level_id_index" ON "level_relationship"("parent_level_id", "child_level_id");

-- CreateIndex
CREATE INDEX "level_relationship_hierarchy_id_index" ON "level_relationship"("hierarchy_id");

-- CreateIndex
CREATE INDEX "level_relationship_child_level_id_index" ON "level_relationship"("child_level_id");

