-- Create table
create table KLEARDO_CURRENCY
(
  source_currency NVARCHAR2(10),
  target_currency NVARCHAR2(10),
  exchange_rate   NUMBER,
  effective_date  NVARCHAR2(15)
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
