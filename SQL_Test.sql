1. select MONTH(purchase_time) as month, count(purchase_time) as number of purchase #display of month and count of purchase
 from transactions 
 where refund_item is NULL  
 group by MONTH(purchase_time)

2. select count(store_id)
   from transactions
   where (
	select count(purchase_time) 
        from transactions 
        where MONTH(purchase_time) = '10' AND YEAR(purchase_time) = '2020'
        group by store_id) > 5
   group by store_id

3. select store_id, min(timediff(refund_time, purchase_time)) as shortest_interval
case when refund_time is NULL then shortest_interval is NULL
     else shortest_interval = min(timediff(refund_time, purchase_time))
END;
group by store_id 

4. select distinct(store_id), gross_transaction_value as first_gross_transaction_value
from transactions
group by min(purchase_time)

5. with table1 as (           #cte new table
   select distinct(buyer_id) as buyer_id, item_name
   from transactions t inner join items i
   on t.item_id = i.item_id
   group by min(purchase_time) 
   )
   select item_name, count(item_name) from table1
   group by item_name 
   order by count(item_name) desc

6. alter_table transactions 
   add refund_possible BOOLEAN
   case when refund_time is NULL then refund_possible = FALSE
        when timediff(refund_time, purchase_time) <= 72:00:00 then refund_possible = TRUE
    else refund_possible = FALSE
    END;

7. with table2 as (
	select buyer_id, ROW_NUMBER() OVER (partition by order by order_by_buyer_id )  as buyer_purchase_no, purchase_time, return_time, store_id, item_id, gross_transaction_value 
from transactions 
)
select * from table2 where buyer_purchase_no = 2;

8. #using cte named table2 of question number 7
   select buyer_id, transaction_time,
   from table2
   where buyer_purchase_no = 2;
