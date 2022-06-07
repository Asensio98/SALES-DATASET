-- SALES DATA ANALYSIS--

/* Skills used : orderby,groupby,windows function, aliasing,unions */

use plata_hloding;
select * from salescat;
select * from saleschannel;
select * from salesdata;
select * from salesproduct;
select * from salespromotion;
select * from salesstate;

-- TOTAL PROFIT, TOTAL NUMBER OF SALES,TOTAL QTY SOLD,AVERAGE COST OF SALES--
select sum(round(((price*orderqty)-costofsales),3)) as 'profit (N)', count(orderid) as 'TOTAL NUMBER OF SALES' ,
sum(orderqty) as 'TOTAL NO OF QTY SOLD',
avg(costofsales) as 'AVERAGE COST OF SALES'
 from salesdata;
 
/* Channel Analysis */

-- profit from different channels--
select sum(round(((price*orderqty)-costofsales),2)) as 'profit (N)',saleschannel.channelname from salesdata left join saleschannel
on salesdata.chanelkey = saleschannel.channelkey
group by saleschannel.channelname
order by 2 desc;

-- CHANNELS AND CORRESPONDING SALES AND QUANTITY SOLD --
select count(salesdata.orderid) as 'TOTAL NUMBER OF SALES', sum(salesdata.orderqty) as 'TOTAL NO OF QTY SOLD', saleschannel.channelname AS 'Channel name'
from salesdata inner join saleschannel
on salesdata.chanelkey = saleschannel.channelkey
group by saleschannel.channelname
order by 1 desc,2 desc;

-- CHANNELS AND CORRESPONDING SALES AND QUANTITY SOLD IN STATES--

select count(salesdata.orderid) as 'TOTAL NUMBER OF SALES', sum(salesdata.orderqty) as 'TOTAL NO OF QTY SOLD', saleschannel.channelname AS 'Channel name',salesstate.state
from salesdata inner join saleschannel
on salesdata.chanelkey = saleschannel.channelkey
inner join salesstate
on salesdata.stateid = salesstate.stateid
group by 3,4
order by 1 desc,2 desc;


/* State & Zone Analysis*/

-- Report of order and Profit for Diffrent State and Respective Zones--
select sum(salesdata.orderqty) as 'TOTAL NO OF QTY SOLD',count(salesdata.orderid) as 'TOTAL NO OF SALES',sum(round(((price*orderqty)-costofsales),2)) as 'Profit (N)',salesstate.zone,salesstate.state from 
salesdata inner join salesstate
on salesdata.stateid = salesstate.stateid
group by salesstate.state
order by 1 desc,2 desc, 3 desc;

-- generate a report showing total sales across zone--
select salesstate.zone, count(salesdata.orderid)as 'TOTAL NO OF SALES',sum(round(((price*orderqty)-costofsales),2)) as 'PROFIT (N)' from salesdata inner join salesstate
on salesdata.stateid = salesstate.stateid
group by salesstate.zone
order by 3 desc;

-- sales and Profit accross Geo political zone--
-- SOUTH SOUTH--
select salesstate.state, count(salesdata.orderid) as 'Total no of Sales',sum(round(((price*orderqty)-costofsales),2)) as 'Profit (N)' from salesdata inner join salesstate
on salesdata.stateid = salesstate.stateid
where zone like 'south south%'
group by salesstate.state
order by 2 desc,3 desc;

-- SOUTH WEST--
select salesstate.state, count(salesdata.orderid) as 'Total no of Sales',sum(round(((price*orderqty)-costofsales),2)) as 'Profit (N)' from salesdata inner join salesstate
on salesdata.stateid = salesstate.stateid
where zone like 'south west%'
group by salesstate.state
order by 2 desc,3 desc;

-- SOUTH EAST--
select salesstate.state, count(salesdata.orderid) as 'Total no of Sales',sum(round(((price*orderqty)-costofsales),2)) as 'Profit (N)' from salesdata inner join salesstate
on salesdata.stateid = salesstate.stateid
where zone like 'south east%'
group by salesstate.state
order by 2 desc , 3 desc;

-- North West--
select salesstate.state, count(salesdata.orderid) as 'Total no of Sales',sum(round(((price*orderqty)-costofsales),2)) as 'Profit (N)' from salesdata inner join salesstate
on salesdata.stateid = salesstate.stateid
where zone like 'north west%'
group by salesstate.state
order by 2 desc,3 desc;
 
-- NORTH EAST--
select salesstate.state, count(salesdata.orderid) as 'Total no of Sales',sum(round(((price*orderqty)-costofsales),2)) as 'Profit (N)' from salesdata inner join salesstate
on salesdata.stateid = salesstate.stateid
where zone like 'north east%'
group by salesstate.state
order by 2 desc, 3 desc;

-- NORTH CENTRAL--
select salesstate.state, count(salesdata.orderid) as 'Total no of Sales',sum(round(((price*orderqty)-costofsales),2)) as 'Profit (N)' from salesdata inner join salesstate
on salesdata.stateid = salesstate.stateid
where zone like 'north central%'
group by salesstate.state
order by 2 desc, 3 desc;

/* Product Category Analysis*/

-- product category and sales table--

select count(sd.orderid) as 'Total no of sales' ,sd.price,sc.productcategory,sum(round(((price*orderqty)-costofsales),2)) as 'Profit (N)' from 
salescat as sc inner join salesdata as sd
on sc.productsubcategorykey= sd.productsubcategorykey
group by sc.productcategory; 


select count(sd.orderid) as 'Total no of sales' ,sd.price,sc.productcategory,sum(round(((price*orderqty)-costofsales),2)) as 'Profit (N)',salesstate.state from 
salescat as sc inner join salesdata as sd
on sc.productsubcategorykey= sd.productsubcategorykey
inner join salesstate
on sd.stateid = salesstate.stateid
group by sc.productcategory,salesstate.state
order by 1 desc, 4 desc;

/* Promotion Analysis */
-- Total No Of Sales,Total No of Qty Sold across promotion name--
select salespromotion.promotionname,count(salesdata.orderid) as 'Total No Of SALES',sum(salesdata.orderqty) as 'Total No Of Qty Sold',sum(round(((price*orderqty)-costofsales),2)) as 'Profit (N)'
from salespromotion inner join salesdata
on salespromotion.promotionkey = salesdata.promotionkey
group by salespromotion.promotionname
order by 2 desc, 3 desc,4 desc;

-- Generate a report to show sales across promotions in different states--
select salespromotion.promotionname,salesstate.state,count(salesdata.orderid) as 'Total no of Sales' from salesdata inner join salespromotion
on salesdata.promotionkey = salespromotion.promotionkey
inner join salesstate
on salesdata.stateid = salesstate.stateid
group by salespromotion.promotionname,salesstate.state
order by 3 desc;