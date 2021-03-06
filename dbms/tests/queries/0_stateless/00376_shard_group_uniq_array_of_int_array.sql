DROP TABLE IF EXISTS test.group_uniq_arr_int;
CREATE TABLE test.group_uniq_arr_int ENGINE = Memory AS
	SELECT g as id, if(c == 0, [v], if(c == 1, emptyArrayInt64(), [v, v])) as v FROM 
		(SELECT intDiv(number%1000000, 100) as v, intDiv(number%100, 10) as g, number%10 as c FROM system.numbers WHERE c < 3 LIMIT 10000000);

SELECT length(groupUniqArray(v)) FROM test.group_uniq_arr_int GROUP BY id ORDER BY id;
SELECT length(groupUniqArray(v)) FROM remote('127.0.0.{1,2,3,4}', 'test', 'group_uniq_arr_int') GROUP BY id ORDER BY id;

DROP TABLE IF EXISTS test.group_uniq_arr_int;
