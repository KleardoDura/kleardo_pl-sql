create or replace procedure kleardo_xml as
       
begin
  

  begin
 INSERT INTO kleardo_xml_table_info (id, xml_data)
VALUES (
  1, xmltype(
   bfilename('KLEARDO_CSV', 'instrument.xml')
 , nls_charset_id('UTF8')    
 )
); commit;
 dbms_output.put_line('success1');
 end;
 
 
 begin
INSERT INTO kleardo_xml_data (ENDTOENDID,AMT,CCY,IBAN,BIC)
SELECT tab.*
  FROM  kleardo_xml_table_info ,
   XMLTABLE('/Msg/Docs/Doc/Cctinit/Document/CstmrCdtTrfInitn/PmtInf/CdtTrfTxInf'
        PASSING  kleardo_xml_table_info.xml_data
       COLUMNS
        "ENDTOENDID" varchar2(15) PATH 'PmtId/EndToEndId',
        "AMT" number PATH 'Amt/InstdAmt',
        "CCY" varchar2(3) PATH 'Amt/InstdAmt/@Ccy',-- '@' perdoret per atribute
        "IBAN" varchar2(20) PATH 'CdtrAcct/Id/IBAN',
        "BIC" varchar2(12)  PATH 'CdtrAgt/FinInstnId/BIC'
      )tab; commit;
 exception 
    when others then
     dbms_output.put_line('ERROR');
end;

 dbms_output.put_line('success2');
 exception 
    when others then
     dbms_output.put_line(sqlerrm);

end kleardo_xml;
