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
