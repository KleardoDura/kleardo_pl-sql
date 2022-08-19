create or replace procedure kleardo_p_does_contrat_exist as
----------------------Ploteso te dhenat
udf_name VARCHAR2(105):='CL_EXT_ACCOUNT_NO';
p_udf_value VARCHAR2(150):='000HPDD202560001';
p_fc_module varchar2(2):='SI';
x varchar(1);
---------------------------------------
begin
x:=kleardo_does_contract_exist_no(udf_name,p_udf_value,p_fc_module);

dbms_output.put_line(x);
  
end kleardo_p_does_contrat_exist;
