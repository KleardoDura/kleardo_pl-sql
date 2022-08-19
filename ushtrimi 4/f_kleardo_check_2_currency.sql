create or replace function kleardo_check_2_currency(p_branch_code varchar2,p_ccy1 varchar2,p_ccy2 varchar2) return number as
 n_count number;
begin
   SELECT COUNT(*) INTO n_count FROM CYTMS_RATES WHERE BRANCH_CODE = p_branch_code AND CCY1 = p_ccy1 AND CCY2 = p_ccy2 AND rate_type = 'STANDARD';
  RETURN n_count;
    
exception 
  when others then 
      dbms_output.put_line(sqlerrm);
  return 0;
end kleardo_check_2_currency;
