--declare n number(1):=0;

--Begin
--select count(*) into n from all_tables where table_name='TEST_RE';

--if (n=0) then

----Execute immediate 'Create table test_re(id number(8),name varchar(50))';
---- end if ;
--END;

Create table test_re(id number(8),name varchar(50))

ALTER TABLE test_re 
ADD birth_date DATE ;

ALTER TABLE test_re 
ADD address varchar(50) ;

ALTER TABLE test_re 
ADD city varchar(50) ;

ALTER TABLE test_re 
ADD citystate varchar(50) ;





