create or replace procedure Kleardo AS
--Variablat
  file utl_file.file_type;
  
  l_line varchar2(10000);
  
  l_source_currency varchar2(10);
  l_target_currency varchar2(10);
  l_exchange_rate number;
  l_effective_date varchar2(20) ;
  c varchar2(20);

begin
  --Hapim filen
 file := utl_file.fopen('KLEARDO_CSV','rates.csv', 'r');
  dbms_output.put_line('File u hap');
  
  
  
   if utl_file.is_open(file) then
       
       --Kapim rreshtat  
       loop
         utl_file.get_line(file,l_line);
 
         --Kontrolljm nese eshte e cilesuar monedha target(Gjatesia e c me e madhe se 3)
          c:=regexp_substr(l_line, '[^,]+',1,1);
         
          if length(c)>3 then
   --Monedha target eshte e cilesuar
        l_source_currency := regexp_substr(c, '[^1 =]+',1,2);
        l_target_currency := regexp_substr(c, '[^1 =]+',1,1);
   
        else
     --Monedha target eshte EUR
         l_target_currency:=regexp_substr(l_line, '[^,]+',1,1);
         l_source_currency:='EUR';
         end if;
         l_exchange_rate:=regexp_substr(l_line, '[^,]+',1,2);
           l_effective_date:=TO_DATE(regexp_substr(l_line, '[^,]+',1,3), 'dd/mm/yyyy');
          --Kontrollojme nese jan kapur sakte te dhenat
          dbms_output.put_line('-> ' || l_source_currency || '|' || l_target_currency ||  '|' ||l_exchange_rate || '|' ||l_effective_date );
  

--Insertimi ne DB
begin
         insert into KLEARDO_CURRENCY(source_currency,target_currency,exchange_rate,effective_date)
         values (l_source_currency,l_target_currency,l_exchange_rate,l_effective_date);
         commit;

end;


 end loop;   
  end if;
 
 EXCEPTION
    WHEN no_data_found THEN
        utl_file.fclose(file);
        NULL;
  
  
  

end Kleardo;

