create or replace function kleardo_rrumbullakimi(p_ccy2 varchar2 ) return number as
 l_x number;
begin
  begin
 select DISTINCT CCY_DECIMALS into l_x from CYTMS_CCY_DEFN_MASTER  where CCY_CODE=p_ccy2;  
--If this currency does not exist in this table then get as deafult Ccy Decimal=2
exception 
  when others then 
    l_x:=2;
    end;
    
--dbms_output.put_line(l_x);
  return l_x;
end kleardo_rrumbullakimi;
