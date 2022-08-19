create or replace function kleardo_mid_rate (p_branch_code varchar2 ,p_ccy1 varchar2,p_ccy2 varchar2 ) return number
 as
  i number(24,12);
  x number(24,12);
  y number(24,12);
  z number(24,12);
  n_count number;
  l_ccy2_temp varchar2(3);
  l_check1 number:=0;
  l_check2 number :=0;
begin
 
--Check if l_ccy1 exist:
             --COLUMN : CCY1
             
 n_count:=kleardo_check_1_currency(p_branch_code,'CCY1',p_ccy1);
  if n_count > 0 then
    -- record exists
    l_check1:=1;
  end if;

---COLUMN : CCY2
n_count:=kleardo_check_1_currency(p_branch_code,'CCY2',p_ccy1);
  if n_count > 0 then
    -- record exists
    l_check1:=1;
  end if;




--Check if l_ccy2 exist:
 --COLUMN : CCY1
 n_count:=kleardo_check_1_currency(p_branch_code,'CCY1',p_ccy2);
  if n_count > 0 then
    -- record exists
    l_check2:=1;
  end if;

--COLUMN : CCY2
 n_count:=kleardo_check_1_currency(p_branch_code,'CCY2',p_ccy2);
  if n_count > 0 then
    -- record exists
    l_check2:=1;
  end if;

if l_check1=0 or l_check2=0 then 
  dbms_output.put_line('ERROR');
  return 0;
  end if;










 --if they are the same currency
  if p_ccy1=p_ccy2 then
    i:=1;
  return i;
  end if; 
   
  -- check if there is a record where CCY1:l_ccy1 and CCY2:l_ccy2
   n_count:=kleardo_check_2_currency(p_branch_code,p_ccy1,p_ccy2);
  if n_count > 0 then
    -- record exists
    --save the mid_rate
    i:=kleardo_find_mid_rate(p_branch_code,p_ccy1,p_ccy2);
     return i;
  end if;
 
 -- check if there is a record where CCY1:l_ccy2 and CCY2:l_ccy1
  n_count:=kleardo_check_2_currency(p_branch_code,p_ccy2,p_ccy1);
  if n_count > 0 then
    -- record exists
    --mid rate= 1/mid_rate 
   x:=kleardo_find_mid_rate(p_branch_code,p_ccy2,p_ccy1);
    i:=1/x;  
    return i;
  end if;
   
  --------------------------------------------------------------------------------------------------
 --check for derivatives rates
 
 
 --Is l_ccy1 in CCY1 column?:
   Select count(*) into n_count 
   from CYTMS_RATES
   Where BRANCH_CODE=p_branch_code AND CCY1=p_ccy1 AND rate_type='STANDARD';
  if n_count > 0 then
    -- l_ccy1 is in CCY1 column:
    -- get the  l_ccy2_temp
     select  CCY2 into l_ccy2_temp from CYTMS_RATES  where BRANCH_CODE=p_branch_code AND  CCY1=p_ccy1 AND rate_type='STANDARD' ;
    
    --get the  mid rate : l_ccy1=>l_ccy2_temp  (x)
    x:=kleardo_find_mid_rate(p_branch_code,p_ccy1,l_ccy2_temp);
   
--check if the combination l_ccy2_temp and l_ccy2 exists
    
    -- 1.Firstly check if CCY1:l_ccy2_temp and CCY2:l_ccy2
     n_count:=kleardo_check_2_currency(p_branch_code,l_ccy2_temp,p_ccy2);
     if n_count > 0 then
    -- record exists
    --get the mid rate  l_ccy2_temp=>l_ccy2  (y)
    y:=kleardo_find_mid_rate(p_branch_code,l_ccy2_temp,p_ccy2);
    i:=x*y;
    return i;
    end if;
    
    --2.Check if  CCY1:l_ccy2 and  CCY2:l_ccy2_temp
     n_count:=kleardo_check_2_currency(p_branch_code,p_ccy2,l_ccy2_temp);
     if n_count > 0 then
    -- record exists
    --get the  mid rate   l_ccy2=>l_ccy2_temp  (y)  therefore  l_ccy2_temp=>l_ccy2 (1/y)
    y:=kleardo_find_mid_rate(p_branch_code,p_ccy2,l_ccy2_temp);
    i:=x/y;
    return i;
    end if;
  

  end if;
      
  --Is l_ccy1 in CCY2 column?:
     Select count(*) into n_count 
   from CYTMS_RATES
   Where BRANCH_CODE=p_branch_code AND CCY2=p_ccy1 AND rate_type='STANDARD';
    if n_count > 0 then
    -- l_ccy1 is in CCY2 column
    -- get l_ccy2_temp
     select  CCY1 into l_ccy2_temp from CYTMS_RATES  where BRANCH_CODE=p_branch_code AND  CCY2=p_ccy1 AND rate_type='STANDARD' ;
    
    --get the mid rate: l_ccy2_temp=>l_ccy1  (1/z)
    z:=kleardo_find_mid_rate(p_branch_code,l_ccy2_temp,p_ccy1);
    x:=1/z;
    
    
    --check if the combination l_ccy2_temp and l_ccy2 exists:
    --1.Firstly check if CCY1:l_ccy2_temp and CCY2:l_ccy2
     n_count:=kleardo_check_2_currency(p_branch_code,l_ccy2_temp,p_ccy2);
     if n_count > 0 then
    -- record exists
    --get the  mid rate  l_ccy2_temp=>l_ccy2  (y)
    y:=kleardo_find_mid_rate(p_branch_code,l_ccy2_temp,p_ccy2);
    i:=x*y;
    return i;
    end if;
    --2.Check if  CCY1:l_ccy2 and  CCY2:l_ccy2_temp
      n_count:=kleardo_check_2_currency(p_branch_code,p_ccy2,l_ccy2_temp);
     if n_count > 0 then
    -- record exists
    --get the mid rate   l_ccy2=>l_ccy2_temp  (y)  therefore  l_ccy2_temp=>l_ccy2 (1/y)
    y:=kleardo_find_mid_rate(p_branch_code,p_ccy2,l_ccy2_temp);
    i:=x/y;
    return i;
    end if;
end if;
------------------------------------------------------------------------------------------------
  
exception 
  when others then 
      dbms_output.put_line(sqlerrm);
  return 0;
end kleardo_mid_rate;
