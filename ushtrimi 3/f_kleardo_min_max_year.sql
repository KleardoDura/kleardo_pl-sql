create or replace function kleardo_min_max_year(l_year number)  return boolean
as
  min_year number;
  max_year number;
  i boolean;
begin
  
begin
  select max(year)  into max_year from STTMS_LCL_HOLIDAY;
 exception 
    when others then
     dbms_output.put_line('ERROR');
end;

begin
  select min(year)  into  min_year from STTMS_LCL_HOLIDAY;
 exception 
    when others then
     dbms_output.put_line('ERROR');
end;
  
  if( l_year>=min_year and l_year<=max_year) then
     return true;
   else return false;  
  end if;
end kleardo_min_max_year;
