create or replace function kleardo_does_contract_exist_no(udf_name VARCHAR2, p_udf_value VARCHAR2, p_fc_module varchar2) return varchar2
as
  n number;
  x varchar2(1);
  l_field_num number(3);
  l_field_name VARCHAR2(105);
  y varchar2(1):='N';
begin
  
--Kapim FIELD NUM
begin 
  select field_num into l_field_num from cstm_product_udf_fields_map  where field_name=udf_name;
  exception
     when others then 
       dbms_output.put_line('ERROR');
end;


--Formojme field name
l_field_name:='FIELD_VAL_'||l_field_num;

dbms_output.put_line(l_field_name);
dbms_output.put_line( p_udf_value);

--Kontrollojme nese rekordi ekziston
EXECUTE IMMEDIATE 'select count(*)  from cstm_contract_userdef_fields where '||l_field_name||'='''||p_udf_value||'''  and module =''' || p_fc_module ||''' ' into n;

  if n> 0 then
    -- do something here if exists
    dbms_output.put_line('record exists.');
    x:='Y';
  else
    -- do something here if not exists
    dbms_output.put_line('record does not exists.');
    x:='N';
  end if;


  
  return x;
 exception 
  when others then
     dbms_output.put_line(sqlerrm);
   return y; 
 
 
end kleardo_does_contract_exist_no;
