create or replace procedure kleardo_is_holiday as
---Ploteso me te dhenat----------------
p_myDay date :=to_date ('06/12/2021', 'DD/MM/YYYY');
p_n NUMBER:=-6;
----------------------------------------
p_HorW varchar2(1);
p_error_message varchar2(30);

i boolean;
begin
 
  i:=f_kleardo_is_holiday(p_myDay,p_n,p_HorW,p_error_message);
  dbms_output.put_line(p_error_message);
   dbms_output.put_line(p_HorW);
   exception 
    when others then
     dbms_output.put_line(sqlerrm);
end kleardo_is_holiday;
