create or replace function f_kleardo_is_holiday (p_myDay date,p_n NUMBER,p_HorW OUT VARCHAR2,p_error_message OUT VARCHAR2) return boolean as
  l_myDay DATE :=p_myDay;
  l_new_date DATE ;
  l_year number;
  l_month number;
  l_day number;
  l_calendar varchar2(31);
begin
  l_new_date:=l_myDay+p_n;
  dbms_output.put_line(l_new_date);
  
  select EXTRACT( year FROM l_new_date ) into  l_year  FROM DUAL;   

   --Kontrollojm nese kjo date ndodhet ne tabele (ky vit)
   if (kleardo_min_max_year(l_year)) then
     dbms_output.put_line('Data e re ndodhet ne tabele');
    else     p_error_message:='Gabim ne vendosjen e dates '; 
       return false; 
    end if;   
    
    
    select EXTRACT( day FROM l_new_date ) into l_day  FROM DUAL; 
    select EXTRACT( month FROM l_new_date ) into l_month  FROM DUAL; 
    
    
   --kapim recordin perkates:
   begin
  SELECT HOLIDAY_LIST INTO l_calendar  FROM STTMS_LCL_HOLIDAY
            WHERE YEAR = l_year AND MONTH= l_month;
   exception 
     when others then
       p_error_message:='Gabim ne vendosjen e dates '; 
       return false;
   end;         
     dbms_output.put_line(l_calendar );
  
    p_HorW:=SUBSTR(l_calendar,l_day, 1);
    --bms_output.put_line(HorW);
  
      
return true;
exception 
  when others then
     dbms_output.put_line(sqlerrm);
   return false;
end f_kleardo_is_holiday;