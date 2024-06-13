--Demo is database facts is schema
-- VIew Script
create or replace view DEMO.FACTS.totaltaxableamountgreaterthan1000_view(
	INVOICE_ID,
	TOTALTAXABLEAMOUNT
) as
with cte_ili as (
select invoiceid,
itemid,
quantity,
TAXABLEAMOUNT,
TAXCODE from learn.invoicelineitem
),
cte_invoice as(
select INVOICEID,
INVOICEDATE,
BUYERID,
ADDRESSID from work.invoices
)
select li.invoiceid as invoice_id,
sum(li.TAXABLEAMOUNT) as totaltaxableamount
from cte_ili as li
join cte_invoice as inv
on li.INVOICEID= inv.INVOICEID
-- where li.INVOICEID in (1,2,3,4,5)
group by li.invoiceid
having sum(li.TAXABLEAMOUNT)> 1000
order by invoice_id asc;