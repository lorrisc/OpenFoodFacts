/*==============================================================*/
/* Nom de SGBD :  PostgreSQL 8                                  */
/* Date de cr�ation :  12/03/2023 16:17:49                      */
/*==============================================================*/


drop index if exists ADDITIVE_PK cascade;

drop table if exists ADDITIVE cascade;

drop index if exists BRAND_PK cascade;

drop table if exists BRAND cascade;

drop index if exists BRAND_PRODUCT2_FK cascade;

drop index if exists BRAND_PRODUCT_FK cascade;

drop index if exists BRAND_PRODUCT_PK cascade;

drop table if exists BRAND_PRODUCT cascade;

drop index if exists CATEGORY_LINK_FK cascade;

drop index if exists CATEGORY_PK cascade;

drop table if exists CATEGORY cascade;

drop index if exists COUNTRY_PK cascade;

drop table if exists COUNTRY cascade;

drop index if exists CREATOR_PK cascade;

drop table if exists CREATOR cascade;

drop index if exists DEFINE_ADDITIVE2_FK cascade;

drop index if exists DEFINE_ADDITIVE_FK cascade;

drop index if exists DEFINE_ADDITIVE_PK cascade;

drop table if exists DEFINE_ADDITIVE cascade;

drop index if exists DEFINE_INGREDIENT2_FK cascade;

drop index if exists DEFINE_INGREDIENT_FK cascade;

drop index if exists DEFINE_INGREDIENT_PK cascade;

drop table if exists DEFINE_INGREDIENT cascade;

drop index if exists DISTRIBUTOR_PK cascade;

drop table if exists DISTRIBUTOR cascade;

drop index if exists ECOSCORE_PK cascade;

drop table if exists ECOSCORE cascade;

drop index if exists TYPING_IMAGE_FK cascade;

drop index if exists REPRESENT_FK cascade;

drop index if exists IMAGE_PK cascade;

drop table if exists IMAGE cascade;

drop index if exists INGREDIENT_PK cascade;

drop table if exists INGREDIENT cascade;

drop index if exists NOVA_GROUP_PK cascade;

drop table if exists NOVA_GROUP cascade;

drop index if exists NUTRITIONALGRADE_PK cascade;

drop table if exists NUTRITIONALGRADE cascade;

drop index if exists CATEGORISE_FK cascade;

drop index if exists LOCATE_FK cascade;

drop index if exists DEFINE_NOVA_GROUP_FK cascade;

drop index if exists DEFINE_ECOSCORE_FK cascade;

drop index if exists DEFINE_NUTRITIONALE_GRADE_FK cascade;

drop index if exists CREATE_FK cascade;

drop index if exists PRODUCT_PK cascade;

drop table if exists PRODUCT cascade;

drop index if exists ASSOCIATION_17_FK cascade;

drop index if exists ASSOCIATION_16_FK cascade;

drop index if exists SALES_PK cascade;

drop table if exists SALES cascade;

drop index if exists TYPEIMAGE_PK cascade;

drop table if exists TYPEIMAGE cascade;

/*==============================================================*/
/* Table : ADDITIVE                                             */
/*==============================================================*/
create table ADDITIVE (
   IDADDITIVE           SERIAL               not null,
   CODE_ADDITIVE        VARCHAR(10)          null,
   NAME_ADDITIVE        VARCHAR(100)         null,
   constraint PK_ADDITIVE primary key (IDADDITIVE)
);

/*==============================================================*/
/* Index : ADDITIVE_PK                                          */
/*==============================================================*/
create unique index ADDITIVE_PK on ADDITIVE (
IDADDITIVE
);

/*==============================================================*/
/* Table : BRAND                                                */
/*==============================================================*/
create table BRAND (
   IDBRAND              SERIAL               not null,
   BRAND_NAME           VARCHAR(100)         not null,
   constraint PK_BRAND primary key (IDBRAND)
);

/*==============================================================*/
/* Index : BRAND_PK                                             */
/*==============================================================*/
create unique index BRAND_PK on BRAND (
IDBRAND
);

/*==============================================================*/
/* Table : BRAND_PRODUCT                                        */
/*==============================================================*/
create table BRAND_PRODUCT (
   IDPRODUCT            INT4                 not null,
   IDBRAND              INT4                 not null,
   constraint PK_BRAND_PRODUCT primary key (IDPRODUCT, IDBRAND)
);

/*==============================================================*/
/* Index : BRAND_PRODUCT_PK                                     */
/*==============================================================*/
create unique index BRAND_PRODUCT_PK on BRAND_PRODUCT (
IDPRODUCT,
IDBRAND
);

/*==============================================================*/
/* Index : BRAND_PRODUCT_FK                                     */
/*==============================================================*/
create  index BRAND_PRODUCT_FK on BRAND_PRODUCT (
IDPRODUCT
);

/*==============================================================*/
/* Index : BRAND_PRODUCT2_FK                                    */
/*==============================================================*/
create  index BRAND_PRODUCT2_FK on BRAND_PRODUCT (
IDBRAND
);

/*==============================================================*/
/* Table : CATEGORY                                             */
/*==============================================================*/
create table CATEGORY (
   IDCATEGORY           SERIAL               not null,
   CAT_IDCATEGORY       INT4                 null,
   CATEGORY_NAME        VARCHAR(50)          not null,
   constraint PK_CATEGORY primary key (IDCATEGORY)
);

/*==============================================================*/
/* Index : CATEGORY_PK                                          */
/*==============================================================*/
create unique index CATEGORY_PK on CATEGORY (
IDCATEGORY
);

/*==============================================================*/
/* Index : CATEGORY_LINK_FK                                     */
/*==============================================================*/
create  index CATEGORY_LINK_FK on CATEGORY (
CAT_IDCATEGORY
);

/*==============================================================*/
/* Table : COUNTRY                                              */
/*==============================================================*/
create table COUNTRY (
   IDCOUNTRY            SERIAL               not null,
   COUNTRY_NAME         VARCHAR(50)          not null,
   constraint PK_COUNTRY primary key (IDCOUNTRY)
);

/*==============================================================*/
/* Index : COUNTRY_PK                                           */
/*==============================================================*/
create unique index COUNTRY_PK on COUNTRY (
IDCOUNTRY
);

/*==============================================================*/
/* Table : CREATOR                                              */
/*==============================================================*/
create table CREATOR (
   IDCREATOR            SERIAL               not null,
   CREATOR_NAME         VARCHAR(100)         not null,
   constraint PK_CREATOR primary key (IDCREATOR)
);

/*==============================================================*/
/* Index : CREATOR_PK                                           */
/*==============================================================*/
create unique index CREATOR_PK on CREATOR (
IDCREATOR
);

/*==============================================================*/
/* Table : DEFINE_ADDITIVE                                      */
/*==============================================================*/
create table DEFINE_ADDITIVE (
   IDPRODUCT            INT4                 not null,
   IDADDITIVE           INT4                 not null,
   constraint PK_DEFINE_ADDITIVE primary key (IDPRODUCT, IDADDITIVE)
);

/*==============================================================*/
/* Index : DEFINE_ADDITIVE_PK                                   */
/*==============================================================*/
create unique index DEFINE_ADDITIVE_PK on DEFINE_ADDITIVE (
IDPRODUCT,
IDADDITIVE
);

/*==============================================================*/
/* Index : DEFINE_ADDITIVE_FK                                   */
/*==============================================================*/
create  index DEFINE_ADDITIVE_FK on DEFINE_ADDITIVE (
IDPRODUCT
);

/*==============================================================*/
/* Index : DEFINE_ADDITIVE2_FK                                  */
/*==============================================================*/
create  index DEFINE_ADDITIVE2_FK on DEFINE_ADDITIVE (
IDADDITIVE
);

/*==============================================================*/
/* Table : DEFINE_INGREDIENT                                    */
/*==============================================================*/
create table DEFINE_INGREDIENT (
   IDINGREDIENT         INT4                 not null,
   IDPRODUCT            INT4                 not null,
   constraint PK_DEFINE_INGREDIENT primary key (IDINGREDIENT, IDPRODUCT)
);

/*==============================================================*/
/* Index : DEFINE_INGREDIENT_PK                                 */
/*==============================================================*/
create unique index DEFINE_INGREDIENT_PK on DEFINE_INGREDIENT (
IDINGREDIENT,
IDPRODUCT
);

/*==============================================================*/
/* Index : DEFINE_INGREDIENT_FK                                 */
/*==============================================================*/
create  index DEFINE_INGREDIENT_FK on DEFINE_INGREDIENT (
IDINGREDIENT
);

/*==============================================================*/
/* Index : DEFINE_INGREDIENT2_FK                                */
/*==============================================================*/
create  index DEFINE_INGREDIENT2_FK on DEFINE_INGREDIENT (
IDPRODUCT
);

/*==============================================================*/
/* Table : DISTRIBUTOR                                          */
/*==============================================================*/
create table DISTRIBUTOR (
   IDDISTRIBUTOR        SERIAL               not null,
   NAME_DISTRIBUTOR     VARCHAR(50)          not null,
   constraint PK_DISTRIBUTOR primary key (IDDISTRIBUTOR)
);

/*==============================================================*/
/* Index : DISTRIBUTOR_PK                                       */
/*==============================================================*/
create unique index DISTRIBUTOR_PK on DISTRIBUTOR (
IDDISTRIBUTOR
);

/*==============================================================*/
/* Table : ECOSCORE                                             */
/*==============================================================*/
create table ECOSCORE (
   IDECOSCORE           SERIAL               not null,
   GRADE                CHAR(1)              not null,
   constraint PK_ECOSCORE primary key (IDECOSCORE)
);

/*==============================================================*/
/* Index : ECOSCORE_PK                                          */
/*==============================================================*/
create unique index ECOSCORE_PK on ECOSCORE (
IDECOSCORE
);

/*==============================================================*/
/* Table : IMAGE                                                */
/*==============================================================*/
create table IMAGE (
   IDIMAGE              SERIAL               not null,
   IDTYPEIMAGE          INT4                 not null,
   IDPRODUCT            INT4                 not null,
   URL_IMAGE            VARCHAR(255)         null,
   DATE_IMAGE           timestamp            null,
   constraint PK_IMAGE primary key (IDIMAGE)
);

/*==============================================================*/
/* Index : IMAGE_PK                                             */
/*==============================================================*/
create unique index IMAGE_PK on IMAGE (
IDIMAGE
);

/*==============================================================*/
/* Index : REPRESENT_FK                                         */
/*==============================================================*/
create  index REPRESENT_FK on IMAGE (
IDPRODUCT
);

/*==============================================================*/
/* Index : TYPING_IMAGE_FK                                      */
/*==============================================================*/
create  index TYPING_IMAGE_FK on IMAGE (
IDTYPEIMAGE
);

/*==============================================================*/
/* Table : INGREDIENT                                           */
/*==============================================================*/
create table INGREDIENT (
   IDINGREDIENT         SERIAL               not null,
   NAME_INGREDIENT      VARCHAR(150)         not null,
   constraint PK_INGREDIENT primary key (IDINGREDIENT)
);

/*==============================================================*/
/* Index : INGREDIENT_PK                                        */
/*==============================================================*/
create unique index INGREDIENT_PK on INGREDIENT (
IDINGREDIENT
);

/*==============================================================*/
/* Table : NOVA_GROUP                                           */
/*==============================================================*/
create table NOVA_GROUP (
   IDNOVAGROUP          SERIAL               not null,
   VALUE_NOVA_GROUP     INT2                 not null,
   LABEL_NOVA_GROUP     VARCHAR(50)          not null,
   constraint PK_NOVA_GROUP primary key (IDNOVAGROUP)
);

/*==============================================================*/
/* Index : NOVA_GROUP_PK                                        */
/*==============================================================*/
create unique index NOVA_GROUP_PK on NOVA_GROUP (
IDNOVAGROUP
);

/*==============================================================*/
/* Table : NUTRITIONALGRADE                                     */
/*==============================================================*/
create table NUTRITIONALGRADE (
   IDNUTRITIONALGRADE   SERIAL               not null,
   GRADE_LABEL          CHAR(1)              not null,
   constraint PK_NUTRITIONALGRADE primary key (IDNUTRITIONALGRADE)
);

/*==============================================================*/
/* Index : NUTRITIONALGRADE_PK                                  */
/*==============================================================*/
create unique index NUTRITIONALGRADE_PK on NUTRITIONALGRADE (
IDNUTRITIONALGRADE
);

/*==============================================================*/
/* Table : PRODUCT                                              */
/*==============================================================*/
create table PRODUCT (
   IDPRODUCT            INT4                 not null,
   IDNOVAGROUP          INT4                 null,
   IDECOSCORE           INT4                 null,
   IDNUTRITIONALGRADE   INT4                 null,
   IDCREATOR            INT4                 null,
   IDCATEGORY           INT4                 null,
   IDCOUNTRY            INT4                 null,
   CODE                 VARCHAR(19)          null,
   URL                  VARCHAR(500)         not null,
   CREATION_DATE        timestamp            not null,
   LAST_UPDATE_DATE     timestamp            null,
   PRODUCT_NAME         VARCHAR(500)         null,
   COMPLETNESS          NUMERIC(10,5)        not null,
   ENERGY100G           NUMERIC(10,5)        null,
   FAT100G              NUMERIC(10,5)        null,
   SATURATEDFAT100G     NUMERIC(10,5)        null,
   CARBOHYDRATES100G    NUMERIC(10,5)        null,
   SUGARS100G           NUMERIC(10,5)        null,
   PROTEINS100G         NUMERIC(10,5)        null,
   NUTRITIONSCORFR100G  NUMERIC(10,5)        null,
   ENERGYKCAL100G       NUMERIC(10,5)        null,
   ECOSCORE_VALUE       INT2                 null,
   constraint PK_PRODUCT primary key (IDPRODUCT)
);

/*==============================================================*/
/* Index : PRODUCT_PK                                           */
/*==============================================================*/
create unique index PRODUCT_PK on PRODUCT (
IDPRODUCT
);

/*==============================================================*/
/* Index : CREATE_FK                                            */
/*==============================================================*/
create  index CREATE_FK on PRODUCT (
IDCREATOR
);

/*==============================================================*/
/* Index : DEFINE_NUTRITIONALE_GRADE_FK                         */
/*==============================================================*/
create  index DEFINE_NUTRITIONALE_GRADE_FK on PRODUCT (
IDNUTRITIONALGRADE
);

/*==============================================================*/
/* Index : DEFINE_ECOSCORE_FK                                   */
/*==============================================================*/
create  index DEFINE_ECOSCORE_FK on PRODUCT (
IDECOSCORE
);

/*==============================================================*/
/* Index : DEFINE_NOVA_GROUP_FK                                 */
/*==============================================================*/
create  index DEFINE_NOVA_GROUP_FK on PRODUCT (
IDNOVAGROUP
);

/*==============================================================*/
/* Index : LOCATE_FK                                            */
/*==============================================================*/
create  index LOCATE_FK on PRODUCT (
IDCOUNTRY
);

/*==============================================================*/
/* Index : CATEGORISE_FK                                        */
/*==============================================================*/
create  index CATEGORISE_FK on PRODUCT (
IDCATEGORY
);

/*==============================================================*/
/* Table : SALES                                                */
/*==============================================================*/
create table SALES (
   IDSALE               SERIAL               not null,
   IDDISTRIBUTOR        INT4                 not null,
   IDPRODUCT            INT4                 not null,
   QUANTITY             INT4                 not null,
   DATESALE             DATE                 not null,
   constraint PK_SALES primary key (IDSALE)
);

/*==============================================================*/
/* Index : SALES_PK                                             */
/*==============================================================*/
create unique index SALES_PK on SALES (
IDSALE
);

/*==============================================================*/
/* Index : ASSOCIATION_16_FK                                    */
/*==============================================================*/
create  index ASSOCIATION_16_FK on SALES (
IDPRODUCT
);

/*==============================================================*/
/* Index : ASSOCIATION_17_FK                                    */
/*==============================================================*/
create  index ASSOCIATION_17_FK on SALES (
IDDISTRIBUTOR
);

/*==============================================================*/
/* Table : TYPEIMAGE                                            */
/*==============================================================*/
create table TYPEIMAGE (
   IDTYPEIMAGE          SERIAL               not null,
   NAME_TYPE_IMAGE      VARCHAR(20)          not null,
   constraint PK_TYPEIMAGE primary key (IDTYPEIMAGE)
);

/*==============================================================*/
/* Index : TYPEIMAGE_PK                                         */
/*==============================================================*/
create unique index TYPEIMAGE_PK on TYPEIMAGE (
IDTYPEIMAGE
);

alter table BRAND_PRODUCT
   add constraint FK_BRAND_PR_BRAND_PRO_PRODUCT foreign key (IDPRODUCT)
      references PRODUCT (IDPRODUCT)
      on delete restrict on update restrict;

alter table BRAND_PRODUCT
   add constraint FK_BRAND_PR_BRAND_PRO_BRAND foreign key (IDBRAND)
      references BRAND (IDBRAND)
      on delete restrict on update restrict;

alter table CATEGORY
   add constraint FK_CATEGORY_CATEGORY__CATEGORY foreign key (CAT_IDCATEGORY)
      references CATEGORY (IDCATEGORY)
      on delete restrict on update restrict;

alter table DEFINE_ADDITIVE
   add constraint FK_DEFINE_A_DEFINE_AD_PRODUCT foreign key (IDPRODUCT)
      references PRODUCT (IDPRODUCT)
      on delete restrict on update restrict;

alter table DEFINE_ADDITIVE
   add constraint FK_DEFINE_A_DEFINE_AD_ADDITIVE foreign key (IDADDITIVE)
      references ADDITIVE (IDADDITIVE)
      on delete restrict on update restrict;

alter table DEFINE_INGREDIENT
   add constraint FK_DEFINE_I_DEFINE_IN_INGREDIE foreign key (IDINGREDIENT)
      references INGREDIENT (IDINGREDIENT)
      on delete restrict on update restrict;

alter table DEFINE_INGREDIENT
   add constraint FK_DEFINE_I_DEFINE_IN_PRODUCT foreign key (IDPRODUCT)
      references PRODUCT (IDPRODUCT)
      on delete restrict on update restrict;

alter table IMAGE
   add constraint FK_IMAGE_REPRESENT_PRODUCT foreign key (IDPRODUCT)
      references PRODUCT (IDPRODUCT)
      on delete restrict on update restrict;

alter table IMAGE
   add constraint FK_IMAGE_TYPING_IM_TYPEIMAG foreign key (IDTYPEIMAGE)
      references TYPEIMAGE (IDTYPEIMAGE)
      on delete restrict on update restrict;

alter table PRODUCT
   add constraint FK_PRODUCT_CATEGORIS_CATEGORY foreign key (IDCATEGORY)
      references CATEGORY (IDCATEGORY)
      on delete restrict on update restrict;

alter table PRODUCT
   add constraint FK_PRODUCT_CREATE_CREATOR foreign key (IDCREATOR)
      references CREATOR (IDCREATOR)
      on delete restrict on update restrict;

alter table PRODUCT
   add constraint FK_PRODUCT_DEFINE_EC_ECOSCORE foreign key (IDECOSCORE)
      references ECOSCORE (IDECOSCORE)
      on delete restrict on update restrict;

alter table PRODUCT
   add constraint FK_PRODUCT_DEFINE_NO_NOVA_GRO foreign key (IDNOVAGROUP)
      references NOVA_GROUP (IDNOVAGROUP)
      on delete restrict on update restrict;

alter table PRODUCT
   add constraint FK_PRODUCT_DEFINE_NU_NUTRITIO foreign key (IDNUTRITIONALGRADE)
      references NUTRITIONALGRADE (IDNUTRITIONALGRADE)
      on delete restrict on update restrict;

alter table PRODUCT
   add constraint FK_PRODUCT_LOCATE_COUNTRY foreign key (IDCOUNTRY)
      references COUNTRY (IDCOUNTRY)
      on delete restrict on update restrict;

alter table SALES
   add constraint FK_SALES_ASSOCIATI_PRODUCT foreign key (IDPRODUCT)
      references PRODUCT (IDPRODUCT)
      on delete restrict on update restrict;

alter table SALES
   add constraint FK_SALES_ASSOCIATI_DISTRIBU foreign key (IDDISTRIBUTOR)
      references DISTRIBUTOR (IDDISTRIBUTOR)
      on delete restrict on update restrict;

