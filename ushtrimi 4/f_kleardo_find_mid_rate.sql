create or replace function kleardo_find_mid_rate(p_branch_code varchar2 ,p_ccy1 varchar2,p_ccy2 varchar2 ) return number
 as
 mid_rate number;
 
begin
 
  select  MID_RATE into mid_rate from CYTMS_RATES  where BRANCH_CODE=p_branch_code AND CCY1=p_ccy1 AND CCY2=p_ccy2 AND rate_type='STANDARD' ;
     
  return  mid_rate;
  exception 
     when others then
       dbms_output.put_line(sqlerrm);
end kleardo_find_mid_rate;
