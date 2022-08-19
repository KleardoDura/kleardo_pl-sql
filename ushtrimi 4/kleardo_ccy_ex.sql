create or replace procedure kleardo_ccy_ex as


x number;
y number;  
l_branch_code varchar(3);
l_ccy1 varchar(3);
l_ccy2 varchar(3);
i number;
amount number;
begin
-------------------PLOTEO ME TE DHENAT:-------------------------------------

  l_branch_code:='000';
  l_ccy1:='GBP';
  l_ccy2:='USD';
  
  amount:=100;

----------------------------------------------------------------------------

--gjetja e mid rate
 x:=kleardo_mid_rate(l_branch_code,l_ccy1, l_ccy2);
 
 if x=0 then 
   
   return;
 end if;
 
DBMS_OUTPUT.PUT_LINE('Mid_rate per  ' || l_ccy1 || ' ne  ' || l_ccy2 || ' branch_code  '||  l_branch_code||' eshte ' );
 dbms_output.put_line(x);



--llogaritja e shumes
y:=kleardo_ex_ccy(amount,l_branch_code,l_ccy1,l_ccy2);
dbms_output.put_line(amount ||' '||l_ccy1||' = '||y||' '|| l_ccy2); 
   exception 
  when others then
     dbms_output.put_line(sqlerrm);
   
end kleardo_ccy_ex;
