-- Create table
create table KLEARDO_XML_TABLE_INFO
(
  id                        NUMBER,
  xml_data                  XMLTYPE,
  "LOADEDDATETIME DATETIME" DATE
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
