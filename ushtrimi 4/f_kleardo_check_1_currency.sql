create or replace function kleardo_check_1_currency(p_branch_code varchar2,p_ccy varchar2,p_ccy_value varchar2) return  number
as
 l_n_count number;
begin
  
EXECUTE IMMEDIATE 'select count(*)  from CYTMS_RATES where '||p_ccy ||'='''||p_ccy_value||'''  AND rate_type=''STANDARD'' and BRANCH_CODE =''' || p_branch_code ||''' ' into l_n_count;


  return l_n_count ;
  exception 
    when others then
      dbms_output.put_line((sqlerrm));
      return 0;
end kleardo_check_1_currency;
