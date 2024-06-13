insert into facts.totaltaxamount(
invoice_id,
TOTALTAXABLEAMOUNT
)
WITH cte_ili AS (
    SELECT invoiceid,
           itemid,
           quantity,
           TAXABLEAMOUNT,
           TAXCODE
    FROM learn.invoicelineitem
),
cte_invoice AS (
    SELECT INVOICEID,
           INVOICEDATE,
           BUYERID,
           ADDRESSID
    FROM work.invoices
)
SELECT li.invoiceid AS invoice_id,
       CASE 
           WHEN COUNT(li.invoiceid) > 1 THEN SUM(li.TAXABLEAMOUNT) 
           ELSE MAX(li.TAXABLEAMOUNT) 
       END AS totaltaxableamount
FROM cte_ili AS li
JOIN cte_invoice AS inv
ON li.INVOICEID = inv.INVOICEID
GROUP BY li.invoiceid
ORDER BY invoice_id ASC;
