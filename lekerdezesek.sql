
-- ------
select * from egyuttes 
where nev like '%e%' 

select vezeteknev, keresztnev from vasarlo 
where (floor((sysdate - szuletesi_datum) / 365)) between 30 and 60

-- ------

select album.cím, count(zeneszam.s_id) "számok darabja" from album
inner join zeneszam using(a_id) 
group by album.cím 

select album.cím, 
substr( to_char( numtodsinterval(
         sum( to_date( zeneszam.hossz, 'hh24:mi:ss' ) 
         	- to_date( '00:00:00', 'hh24:MI:SS' ) ),
         'day'
       ) ), 12, 8 ) as "Teljes hossz"
from album inner join zeneszam using(a_id)
group by album.cím

-- +000000000 00:23:41.000000000

select egyuttes.nev, album.cím from egyuttes 
inner join album using(e_id)

select zenesz.nev, egyuttes.nev from zenesz 
inner join tagja using(z_id)
inner join egyuttes using(e_id)
where zenesz.nev = 'Dave Grohl'

-- outer join

select nev, z_h.z_id from hangszer
left outer join z_h using(h_id)
order by z_id desc

select a_id, mufaj from a_m
right outer join mufaj using(m_id)

select * from vasarlas 
full outer join vasarlo on vasarlo.v_id = vasarlas.v_id
order by vasarlo.v_id desc

-- csoportképzéses és rendezéses

select count(album.cím) as darab, mufaj.mufaj from album
inner join a_m using (a_id)
inner join mufaj using(m_id)
group by mufaj.mufaj order by darab desc

select szerep, count(t_sz.szerep_id) from szerep
inner join t_sz on szerep.szerep_id = t_sz.szerep_id 
group by szerep order by szerep desc

-- al select
select cím, brutto_ar from album 
where brutto_ar = (select max(brutto_ar) from album) 

select vezeteknev, keresztnev, 
	floor((sysdate - szuletesi_datum) / 365) as "Életkor" from vasarlo
where floor((sysdate - szuletesi_datum) / 365)
	 >= (select avg(floor((sysdate - szuletesi_datum) / 365)) from vasarlo)

-- komplex

select vezeteknev, keresztnev, egyuttes.nev, cím from vasarlo
join vasarlas using(v_id)
join album using(a_id)
join egyuttes using(e_id)
where album.brutto_ar > 10000

-- származtatott tulajdonság

select cím, brutto_ar from album