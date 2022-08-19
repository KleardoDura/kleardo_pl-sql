-- Create table
create table KLEARDO_XML_DATA
(
  endtoendid NVARCHAR2(15),
  amt        NUMBER,
  ccy        VARCHAR2(3),
  iban       VARCHAR2(20),
  bic        VARCHAR2(12)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
