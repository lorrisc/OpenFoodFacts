/*==============================================================*/
/* Nom de SGBD :  PostgreSQL 8                                  */
/* Date de création :  04/04/2023 14:49:14                      */
/*==============================================================*/


drop index if exists DIM_DISTRIBUTOR_PK CASCADE;

drop table if exists DIM_DISTRIBUTOR CASCADE;

drop index if exists DIM_PRODUCT_PK CASCADE;

drop table if exists DIM_PRODUCT CASCADE;

drop index if exists DIM_TIME_PK CASCADE;

drop table if exists DIM_TIME CASCADE;

drop index if exists COMPOSITION_PRODUCT_FK CASCADE;

drop table if exists FACT_COMPOSITION CASCADE;

drop index if exists SALES_DISTRIBUTOR_FK CASCADE;

drop index if exists SALES_PRODUCT_FK CASCADE;

drop index if exists SALES_TIME_FK CASCADE;

drop table if exists FACT_SALES CASCADE;

/*==============================================================*/
/* Table : DIM_DISTRIBUTOR                                      */
/*==============================================================*/
create table DIM_DISTRIBUTOR (
   "Id Distributor"       INT4                 not null,
   "Distributor Name"     VARCHAR(50)          null,
   constraint PK_DIM_DISTRIBUTOR primary key ("Id Distributor")
);

/*==============================================================*/
/* Index : DIM_DISTRIBUTOR_PK                                   */
/*==============================================================*/
create unique index DIM_DISTRIBUTOR_PK on DIM_DISTRIBUTOR (
"Id Distributor"
);

/*==============================================================*/
/* Table : DIM_PRODUCT                                          */
/*==============================================================*/
create table DIM_PRODUCT (
   "Id Dim Product"           SERIAL               not null,
   "Id Product"               INT4                 null,
   "Code"                     VARCHAR(19)          null,
   "Product Name"             VARCHAR(500)         null,
   "Category Name"            VARCHAR(50)          null,
   "Sub Category Name"        VARCHAR(50)          null,
   "Ecoscore"                 CHAR(1)              null,
   "Nutriscore"               CHAR(1)              null,
   "Nutriscore Score"         NUMERIC(10,5)        null,
   "Novagroup Value"          INT4                 null,
   "Novagroup Label"          VARCHAR(50)          null,
   "Country"                  VARCHAR(50)          null,
   "Image"                    VARCHAR(255)         null,
   "Creator"                  VARCHAR(100)         null,
   "Brand"                    VARCHAR(100)         null,
   "Energy for 100g"          NUMERIC(10,5)        null,
   "Energy kcal for 100g"     NUMERIC(10,5)        null,
   "Fat for 100g"             NUMERIC(10,5)        null,
   "Saturated fat for 100g"   NUMERIC(10,5)        null,
   "Sugars for 100g"          NUMERIC(10,5)        null,
   "Proteins for 100g"        NUMERIC(10,5)        null,
   "Carbohydrates for 100g"   NUMERIC(10,5)        null,
   constraint PK_DIM_PRODUCT primary key ("Id Dim Product")
);

/*==============================================================*/
/* Index : DIM_PRODUCT_PK                                       */
/*==============================================================*/
create unique index DIM_PRODUCT_PK on DIM_PRODUCT (
   "Id Dim Product"
);

/*==============================================================*/
/* Table : DIM_TIME                                             */
/*==============================================================*/
create table DIM_TIME (
   "Date"                 DATE                 not null,
   "Month"                INT4                 null,
   "Month Name"           VARCHAR(20)          null,
   "Quarter"              INT4                 null,
   "Year"                 INT4                 null,
   constraint PK_DIM_TIME primary key ("Date")
);

/*==============================================================*/
/* Index : DIM_TIME_PK                                          */
/*==============================================================*/
create unique index DIM_TIME_PK on DIM_TIME (
   "Date"
);

/*==============================================================*/
/* Table : FACT_COMPOSITION                                     */
/*==============================================================*/
create table FACT_COMPOSITION (
   "Id Dim Product"  INT4  not null,
   "Id Composition"  SERIAL   not null
);

/*==============================================================*/
/* Index : COMPOSITION_PRODUCT_FK                               */
/*==============================================================*/
create  index COMPOSITION_PRODUCT_FK on FACT_COMPOSITION (
   "Id Dim Product"
);

/*==============================================================*/
/* Table : FACT_SALES                                           */
/*==============================================================*/
create table FACT_SALES (
   "Date"                 DATE                 not null,
   "Id Dim Product"       INT4                 not null,
   "Id Distributor"       INT4                 not null,
   "Id Sale"              INT4                 null,
   "Quantity Sold"        INT4                 null
);

/*==============================================================*/
/* Index : SALES_TIME_FK                                        */
/*==============================================================*/
create  index SALES_TIME_FK on FACT_SALES (
   "Date"
);

/*==============================================================*/
/* Index : SALES_PRODUCT_FK                                     */
/*==============================================================*/
create  index SALES_PRODUCT_FK on FACT_SALES (
   "Id Dim Product"
);

/*==============================================================*/
/* Index : SALES_DISTRIBUTOR_FK                                 */
/*==============================================================*/
create  index SALES_DISTRIBUTOR_FK on FACT_SALES (
   "Id Distributor"
);

alter table FACT_COMPOSITION
   add constraint FK_FACT_COM_COMPOSITI_DIM_PROD foreign key ("Id Dim Product")
      references DIM_PRODUCT ("Id Dim Product")
      on delete restrict on update restrict;

alter table FACT_SALES
   add constraint FK_FACT_SAL_SALES_DIS_DIM_DIST foreign key ("Id Distributor")
      references DIM_DISTRIBUTOR ("Id Distributor")
      on delete restrict on update restrict;

alter table FACT_SALES
   add constraint FK_FACT_SAL_SALES_PRO_DIM_PROD foreign key ("Id Dim Product")
      references DIM_PRODUCT ("Id Dim Product")
      on delete restrict on update restrict;

alter table FACT_SALES
   add constraint FK_FACT_SAL_SALES_TIM_DIM_TIME foreign key ("Date")
      references DIM_TIME ("Date")
      on delete restrict on update restrict;

