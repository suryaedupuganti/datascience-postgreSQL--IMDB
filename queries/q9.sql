/* select all films release in particular production year */

select production_year, count(*) as num from movie 
group by production_year 
order by production_year asc