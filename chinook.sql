-- 1 - good
SELECT c.FirstName, c.LastName, c.Country FROM CUSTOMER c
WHERE c.country not LIKE 'usa';



-- 2 - good
SELECT c.FirstName, c.LastName, c.Country FROM CUSTOMER c
WHERE c.country LIKE 'brazil';

-- 3 - good
SELECT c.FirstName, c.LastName, c.Country, i.InvoiceId, i.InvoiceDate, i.BillingCountry FROM CUSTOMER c
JOIN Invoice i on c.CustomerId = i.CustomerId
WHERE c.country LIKE 'brazil';

-- 4 - good
SELECT * FROM Employee
where title = 'Sales Support Agent';

-- 5 - good
SELECT DISTINCT BillingCountry FROM Invoice
GROUP BY BillingCountry;

-- 6 - good
SELECT e.FirstName, e.LastName, i.InvoiceId 
FROM Employee e 
JOIN Customer on Customer.SupportRepId = e.EmployeeId
JOIN Invoice i on Customer.CustomerId = i.InvoiceId;

-- 7 - good
SELECT i.Total, c.FirstName || ' ' || c.LastName AS 'customer name', c.Country, e.FirstName || ' ' || e.LastName AS 'employee name'
FROM Employee e 
JOIN Customer c on c.SupportRepId = e.EmployeeId
JOIN Invoice i on c.CustomerId = i.InvoiceId;

-- 8 - good
SELECT `2009 INVOICES`, `2011 INVOICES` FROM
(
SELECT COUNT(i.InvoiceId) AS `2009 INVOICES` FROM Invoice i
WHERE i.InvoiceDate like '2009%'
),
(
SELECT COUNT(i.InvoiceId) AS `2011 INVOICES` FROM Invoice i
WHERE i.InvoiceDate like '2011%'
);

-- 9 - good
SELECT `2009 INVOICES`, `2011 INVOICES` FROM
(
SELECT SUM(i.Total) AS `2009 INVOICES` FROM Invoice i
WHERE i.InvoiceDate like '2009%'
),
(
SELECT SUM(i.Total) AS `2011 INVOICES` FROM Invoice i
WHERE i.InvoiceDate like '2011%'
);

-- 10 - good
SELECT Count(*) FROM InvoiceLine
JOIN Invoice i on i.InvoiceId = InvoiceLine.InvoiceId
WHERE invoiceline.InvoiceId = 37;

-- 11 - good
SELECT COUNT(*) FROM InvoiceLine
JOIN Invoice i on i.InvoiceId = InvoiceLine.InvoiceId
GROUP BY INVOICELINE.InvoiceId

-- 12 - good
SELECT i.InvoiceLineId, t.name from InvoiceLine i 
JOIN TRACK t on t.TrackId = i.TrackId
ORDER BY i.InvoiceLineId

-- 13 - maybe good. find a better way
SELECT i.InvoiceLineId, t.name, a.Name, iv.InvoiceId from InvoiceLine i 
JOIN TRACK t on t.TrackId = i.TrackId
JOIN ALBUM l on t.AlbumId = l.AlbumId
JOIN ARTIST a on a.ArtistId = l.ArtistId
JOIN invoice iv on iv.InvoiceId = i.InvoiceId
ORDER BY i.InvoiceLineId

-- 14 - good
Select Distinct i.BillingCountry, Count(i.InvoiceId) FROM Invoice i
GROUP BY I.BillingCountry

-- 15 - good
SELECT p.name, Count(*) FROM PlaylistTrack pt
JOIN Playlist p on p.PlaylistId = pt.PlaylistId
Group by p.name

-- 16 - good
SELECT a.Title, g.name, mt.name FROM TRACK t 
JOIN Album a on a.AlbumId = t.AlbumId
JOIN Genre g on g.GenreId = t.GenreId
JOIN MediaType mt on mt.MediaTypeId = t.MediaTypeId

-- 17 - good
SELECT i.InvoiceId, Count(il.InvoiceLineId) AS `lines on invoice` FROM invoice i 
JOIN InvoiceLine il on il.InvoiceId = i.InvoiceId
GROUP BY i.InvoiceId

-- 18 - good
SELECT e.FirstName || ' ' || e.LastName AS `employee name`, Sum(i.total) FROM Customer c
JOIN Employee e on e.EmployeeId = c.SupportRepId
JOIN Invoice i on i.CustomerId = c.CustomerId
GROUP BY `employee name`

-- 19 - good
SELECT MAX(highest_sales), `employee name` from 
(
SELECT e.FirstName || ' ' || e.LastName AS `employee name`, Sum(i.total) as highest_sales FROM Customer c
JOIN Employee e on e.EmployeeId = c.SupportRepId
JOIN Invoice i on i.CustomerId = c.CustomerId
WHERE I.InvoiceDate like '2009%'
GROUP BY `employee name`
)

-- 20 - good
SELECT max(highest_sales), `employee name` from
(SELECT e.FirstName || ' ' || e.LastName AS `employee name`, Sum(i.total) as highest_sales FROM Customer c
JOIN Employee e on e.EmployeeId = c.SupportRepId
JOIN Invoice i on i.CustomerId = c.CustomerId
GROUP BY `employee name`)

-- 21 - good
SELECT e.FirstName || ' ' || e.LastName AS `employee name`, COUNT(C.CustomerId) from employee e
LEFT JOIN Customer C ON C.SupportRepId = E.EmployeeId
GROUP BY `employee name`

-- 22 - good
Select i.BillingCountry, sum(i.total) from Invoice i
group by i.BillingCountry

-- 23 - good
Select max(country_total), country from 
(
Select i.BillingCountry as country, sum(i.total) as country_total from Invoice i
group by i.BillingCountry
)

-- 24 - good
select max(sales), highest_track from
(
SELECT Count(i.InvoiceLineId) as sales, t.name as highest_track from InvoiceLine i 
JOIN TRACK t on t.TrackId = i.TrackId
GROUP BY t.name
)

-- 25 - good
SELECT Count(i.InvoiceLineId) as sales, t.name as highest_track from InvoiceLine i 
JOIN TRACK t on t.TrackId = i.TrackId
GROUP BY t.name
order by sales DESC
limit 5

-- 26 - good
SELECT Count(i.InvoiceLineId) as sales, a.name from InvoiceLine i 
JOIN TRACK t on t.TrackId = i.TrackId
JOIN album al on al.AlbumId = t.AlbumId
JOIN artist a on a.ArtistId = al.ArtistId
GROUP BY a.name
order by sales DESC
limit 3

-- 27 - good
SELECT COUNT(i.InvoiceLineId) as sales, mt.name from InvoiceLine i 
join track t on t.trackid = i.TrackId
join MediaType mt on t.MediaTypeId = mt.MediaTypeId
group by t.MediaTypeId