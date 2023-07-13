select [Table Name], [Income Group], Region, [Currency Unit]
from international_debt..country

select * from international_debt..country
select * from international_debt..Debt

--===============================================================================--
--1. Terdapat berapa banyak country yang akan dibahas?
	select count(distinct [Table Name]) as total_country_distinct
	from international_debt..country
	-- ternyata ada 135 country yang akan di explore

--2.berapa total debt tiap country hingga tahun 2022?
	select DISTINCT([Country Name]), SUM(cast(DEBT as bigint)) as totaldebt_percountry
	from international_debt..Debt
	group by [Country Name]
	order by totaldebt_percountry desc

--3. berapa total debt dari semua country?
	select SUM(cast(DEBT as bigint)) as Total_debt
	from international_debt..Debt

--4. country dengan debt terbesar?
	select DISTINCT TOP 1([Country Name]), SUM(cast(DEBT as bigint)) as maxdebt
	from international_debt..Debt
	group by [Country Name]

	select DISTINCT([Country Name]), SUM(MAX(cast(DEBT as bigint))) as maxdebt
	from international_debt..Debt
	group by [Country Name]

--5. hutang tiap tahun?
	select 
		SUM(1970) as sum_1970,
		SUM(1971) as sum_1971,
		SUM(1972) as sum_1972,
		SUM(1973) as sum_1973,
		SUM(1974) as sum_1974,
		SUM(1975) as sum_1975,
		SUM(1976) as sum_1976,
		SUM(1977) as sum_1977,
		SUM(1978) as sum_1978,
		SUM(1979) as sum_1979,
		SUM(1980) as sum_1980,
		SUM(1981) as sum_1981,
		SUM(1982) as sum_1982,
		SUM(1983) as sum_1983,
		SUM(1984) as sum_1984,
		SUM(1985) as sum_1985,
		SUM(1986) as sum_1986,
		SUM(1987) as sum_1987,
		SUM(1988) as sum_1988,
		SUM(1989) as sum_1989,
		SUM(1990) as sum_1990,
		SUM(1991) as sum_1991,
		SUM(1992) as sum_1992,
		SUM(1993) as sum_1993,
		SUM(1994) as sum_1994,
		SUM(1995) as sum_1995,
		SUM(1996) as sum_1996,
		SUM(1997) as sum_1997,
		SUM(1998) as sum_1998,
		SUM(1999) as sum_1999,
		SUM(2000) as sum_2000,
		SUM(2001) as sum_2001,
		SUM(2002) as sum_2002,
		SUM(2003) as sum_2003,
		SUM(2004) as sum_2004,
		SUM(2005) as sum_2005,
		SUM(2006) as sum_2006,
		SUM(2007) as sum_2007,
		SUM(2008) as sum_2008,
		SUM(2009) as sum_2009,
		SUM(2010) as sum_2010,
		SUM(2011) as sum_2011,
		SUM(2012) as sum_2012,
		SUM(2013) as sum_2013,
		SUM(2014) as sum_2014,
		SUM(2015) as sum_2015,
		SUM(2016) as sum_2016,
		SUM(2017) as sum_2017,
		SUM(2018) as sum_2018,
		SUM(2019) as sum_2019,
		SUM(2020) as sum_2020,
		SUM(2021) as sum_2021,
		SUM(2022) as sum_2022
	from international_debt..country

--6. series mana yang punya debt terbesar?
	select Distinct[Series Name], sum(cast(DEBT as bigint)) as debt_series
	from international_debt..Debt
	group by [Series Name]
	order by debt_series desc

	select Distinct top 1 [Series Name], sum(cast(DEBT as bigint)) as debt_series
	from international_debt..Debt
	group by [Series Name]
	order by debt_series desc

--7. series terbesar adalah GNI (current US$)
--   negara mana yang memiliki GNI (current US$) terbesar?
	select Distinct[Country Name], sum(cast(DEBT as bigint)) as debt_seriesGNI
	from international_debt..Debt
	where [Series Name] like ('%GNI (current US$)%')
	group by [Country Name]
	order by debt_seriesGNI desc

--8. distribusi debt untuk setiap series?
	select Distinct[Series Name], avg(cast(DEBT as bigint)) as debt_series
	from international_debt..Debt
	group by [Series Name]
	order by debt_series desc

	select Distinct top 1 [Series Name], avg(cast(DEBT as bigint)) as debt_series
	from international_debt..Debt
	group by [Series Name]

--9. series yang berpengaruh terbesar kepada hutang china?
	select DISTINCT([Country Name]), SUM(cast(DEBT as bigint)) as maxdebt
	from international_debt..Debt
	group by [Country Name]
	order by maxdebt desc

	select Distinct TOP 3 [Series Name], [Country Name], avg(cast(DEBT as bigint)) as debt_series
	from international_debt..Debt
	where [Country Name] like ('%China%')
	group by [Series Name], [Country Name]
	order by debt_series desc

-- 10. untuk setiap series, berapa banyak max debt yang dimilikinya dan oleh negara apa?
	select distinct[Series Name],[Country Name], max(cast(debt as bigint)) as max_debt_series
	from international_debt..Debt
	group by [Series Name], [Country Name]
	order by max_debt_series desc
	

	
	
	
	



