create or replace function kleardo_ex_ccy(p_amount number,p_branch_code varchar2 ,p_ccy1 varchar2,p_ccy2 varchar2 ) return number
 as
  x number ;
  l_mid_rate number;
  y number;
begin
  --llogaritja e mid rate:
  l_mid_rate:=kleardo_mid_rate(p_branch_code,p_ccy1,p_ccy2);
  
--llogaritja  e vleres
  x:=l_mid_rate*p_amount;
  
  y:=kleardo_rrumbullakimi(p_ccy2 );
  x:=ROUND(x,y);

return x;
 exception 
  when others then
     dbms_output.put_line(sqlerrm);
     return 0;
end kleardo_ex_ccy;
