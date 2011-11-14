/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     11/14/2011 3:55:57 PM                        */
/*==============================================================*/
drop table if exists SUBSRIBED_TO;

drop table if exists STUDIED_IN;

drop table if exists CERTIFIED_WITH;

drop table if exists INSURANCE_PLANS;

drop table if exists INSURANCES;

drop table if exists DOCTORS;

drop table if exists CITY;

drop table if exists CERTIFICATIONS;

drop table if exists GENDER;

drop table if exists SPECIALTIES;

drop table if exists UNIVERSTIES;

/*==============================================================*/
/* Table: CERTIFICATIONS                                        */
/*==============================================================*/
create table CERTIFICATIONS
(
   CERTIFICATE_NAME     text,
   CERTIFICATE_ID       int not null,
   primary key (CERTIFICATE_ID)
);

/*==============================================================*/
/* Table: CERTIFIED_WITH                                        */
/*==============================================================*/
create table CERTIFIED_WITH
(
   CERTIFICATE_ID       int not null,
   DR_ID                int not null,
   primary key (CERTIFICATE_ID, DR_ID)
);

/*==============================================================*/
/* Table: CITY                                                  */
/*==============================================================*/
create table CITY
(
   CITY_NAME            text,
   CITY_ID              int not null,
   primary key (CITY_ID)
);

/*==============================================================*/
/* Table: DOCTORS                                               */
/*==============================================================*/
create table DOCTORS
(
   CITY_ID              int,
   GENDER_ID            int,
   DR_NAME              text,
   DR_ADDRESS           text,
   DR_PHONE             numeric(8,0),
   DR_PRICE             float(8,2),
   DR_ABOUT             text,
   DR_ID                int not null,
   SPECIALITY_ID        int,
   primary key (DR_ID)
);

/*==============================================================*/
/* Table: GENDER                                                */
/*==============================================================*/
create table GENDER
(
   GENDER_NAME          text,
   GENDER_ID            int not null,
   primary key (GENDER_ID)
);

/*==============================================================*/
/* Table: INSURANCES                                            */
/*==============================================================*/
create table INSURANCES
(
   INSURANCE_NAME       text,
   INSURANCE_ID         int not null,
   primary key (INSURANCE_ID)
);

/*==============================================================*/
/* Table: INSURANCE_PLANS                                       */
/*==============================================================*/
create table INSURANCE_PLANS
(
   PLAN_NAME            text,
   PLAN_ID              int not null,
   INSURANCE_ID         int not null
);

/*==============================================================*/
/* Table: SPECIALTIES                                           */
/*==============================================================*/
create table SPECIALTIES
(
   SPECIALITY_NAME      text,
   SPECIALITY_ID        int not null,
   primary key (SPECIALITY_ID)
);

/*==============================================================*/
/* Table: STUDIED_IN                                            */
/*==============================================================*/
create table STUDIED_IN
(
   UNIVERSITY_ID        int not null,
   DR_ID                int not null,
   primary key (UNIVERSITY_ID, DR_ID)
);

/*==============================================================*/
/* Table: SUBSRIBED_TO                                          */
/*==============================================================*/
create table SUBSRIBED_TO
(
   DR_ID                int not null,
   PLAN_ID              int not null,
   primary key (DR_ID, PLAN_ID)
);

/*==============================================================*/
/* Table: UNIVERSTIES                                           */
/*==============================================================*/
create table UNIVERSTIES
(
   UNIVERSITY_NAME      text,
   UNIVERSIT_ID         int not null,
   primary key (UNIVERSIT_ID)
);

alter table CERTIFIED_WITH add constraint FK_CERTIFIED_WITH foreign key (CERTIFICATE_ID)
      references CERTIFICATIONS (CERTIFICATE_ID) on delete CASCADE on update CASCADE;

alter table CERTIFIED_WITH add constraint FK_CERTIFIED_WITH_DR foreign key (DR_ID)
      references DOCTORS (DR_ID) on delete CASCADE on update CASCADE;

alter table DOCTORS add constraint FK_GENDER_IS foreign key (GENDER_ID)
      references GENDER (GENDER_ID) on delete CASCADE on update CASCADE;

alter table DOCTORS add constraint FK_SATTLED_IN foreign key (CITY_ID)
      references CITY (CITY_ID) on delete CASCADE on update CASCADE;

alter table DOCTORS add constraint FK_SPECIALIZED_IN foreign key (SPECIALITY_ID)
      references SPECIALTIES (SPECIALITY_ID) on delete CASCADE on update CASCADE;

alter table INSURANCE_PLANS add constraint FK_PROVIDED_BY_COMPANY foreign key (INSURANCE_ID)
      references INSURANCES (INSURANCE_ID) on delete CASCADE on update CASCADE;

alter table STUDIED_IN add constraint FK_DR_STUDIED_IN foreign key (DR_ID)
      references DOCTORS (DR_ID) on delete CASCADE on update CASCADE;

alter table STUDIED_IN add constraint FK_UNINVERSITY_STUDIED_IN foreign key (UNIVERSITY_ID)
      references UNIVERSTIES (UNIVERSIT_ID) on delete CASCADE on update CASCADE;

alter table SUBSRIBED_TO add constraint FK_PROVIDED_BY_DR foreign key (PLAN_ID)
      references INSURANCE_PLANS (PLAN_ID) on delete CASCADE on update CASCADE;

alter table SUBSRIBED_TO add constraint FK_SUBISCRIBED_TO foreign key (DR_ID)
      references DOCTORS (DR_ID) on delete CASCADE on update CASCADE;

