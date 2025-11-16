SELECT *
FROM CovidDeaths
--WHERE location = '%international%'
Order by 3,4


SELECT *
FROM CovidVaccinations
Order by 3,4

-- Välja ut Data som vi kommer använda

SELECT Location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeaths
ORDER BY 1,2


-- Undersöka Total Cases vs Total Deaths (%)
-- Visar chansen (%) att dö ifall du får Covid-19 i respektive land
SELECT Location, date, total_cases, total_deaths, (CONVERT(DECIMAL(18,2), total_deaths) / CONVERT(DECIMAL(18,2), total_cases) )*100 as DeathPercentage
From PortfolioProject..CovidDeaths
WHERE location like '%sweden%'
and continent is NOT NULL
ORDER BY 1,2


-- Kolla på Total Cases kontra Population 
-- Detta ger oss en överblick över hur många som blev sjuka i respektive land
SELECT Location, date, population, total_cases, (CONVERT(DECIMAL(18,2), total_cases) / CONVERT(DECIMAL(18,2), population) )*100 
as SickPercentage
From PortfolioProject..CovidDeaths
WHERE location like '%sweden%' AND total_cases IS NOT NULL
ORDER BY 1,2

-- Kollar på länder som har högst infektion ökning
SELECT Location, population, MAX(total_cases) AS MaxTotalCases, (CONVERT(DECIMAL(18,2), MAX(total_cases)) 
/ CONVERT(DECIMAL(18,2), population) )*100 
as SickPercentage
From PortfolioProject..CovidDeaths
--WHERE location like '%sweden%' AND total_cases IS NOT NULL
GROUP BY location, population
ORDER BY SickPercentage DESC

--Kollar på hur många som dog av de som blev sjuka i förhållande till landet i %
SELECT Location, MAX(cast(total_deaths as int)) AS TotalDeathCount
--MAX(total_cases) AS MaxTotalCases, (CONVERT(DECIMAL(18,2), MAX(total_cases)) 
--/ CONVERT(DECIMAL(18,2), population) )*100 
--as SickPercentage
From PortfolioProject..CovidDeaths
--WHERE location like '%sweden%' AND total_cases IS NOT NULL
GROUP BY location, population
ORDER BY TotalDeathCount DESC


SELECT Location, MAX(cast(total_deaths as int)) AS TotalDeathCount
From PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY TotalDeathCount DESC

-- "WHERE continent IS NOT NULL" kan läggas till i varje query men jag orkar inte ;)

--Låt oss undersöka varje Kontinents enskilda data 
SELECT location, MAX(cast(total_deaths as int)) AS TotalDeathCount 
From PortfolioProject..CovidDeaths
WHERE continent IS NULL 
    AND location != 'High Income'
    AND location != 'Upper middle income'
    AND location != 'Lower middle income'
    AND location != 'Low income'
GROUP BY location
ORDER BY TotalDeathCount DESC


--Låt oss kolla på globala värden
SELECT date, MAX(new_cases) AS TotCases, MAX(cast(new_deaths as int)) as TotDeaths,
MAX(cast(new_deaths as int)) /MAX(new_cases)*100 as DeathPercentage 
From PortfolioProject..CovidDeaths
WHERE continent is NOT NULL
GROUP BY date
ORDER BY 1,2

--Vi kan även kolla på alla fall Totalt genom att enbart ta bort date i SELECT och GROUP BY

SELECT SUM(new_cases) AS TotCases, SUM(cast(new_deaths as int)) as TotDeaths,
SUM(cast(new_deaths as int)) /SUM(new_cases)*100 as DeathPercentage 
From PortfolioProject..CovidDeaths
WHERE continent is NOT NULL
--GROUP BY date
ORDER BY 1,2

--Vi kollar på vår andra tabell (CovidVaccinations) och joinar den med den förre tabellen

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
From CovidVaccinations vac
JOIN CovidDeaths dea
ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent is NOT NULL
Order by 1,2,3

--Ifall vi vill kolla på Afghanistan som första land så sorterar vi inte på kontinent då Afrika kommer före än Asien


Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
From CovidVaccinations vac
JOIN CovidDeaths dea
ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent is NOT NULL
Order by 2,3

--Vi kommer nu göra det möjligt att lägga till alla nya vacc. i varje kolumn så det adderas via Partition by

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(cast(vac.new_vaccinations as bigint)) OVER (Partition BY dea.location Order by dea.location, dea.date)
From CovidVaccinations vac
JOIN CovidDeaths dea
ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent is NOT NULL
Order by 2,3

--Verkar inte funka då vi får denna Syntax Error:
-- Msg 8729, Level 16, State 1, Line 115
--ORDER BY list of RANGE window frame has total size of 1020 bytes. Largest size supported is 900 bytes.

SELECT
    dea.continent,
    dea.location,
    dea.date,
    dea.population,
    vac.new_vaccinations,
    SUM(CAST(vac.new_vaccinations AS BIGINT)) OVER (PARTITION BY dea.location ORDER BY dea.date) AS running_sum
FROM
    CovidVaccinations vac
JOIN
    CovidDeaths dea ON dea.location = vac.location AND dea.date = vac.date
WHERE
    dea.continent IS NOT NULL
ORDER BY
    2, 3;



--Vi fortsätter med att skapa en CTE



SELECT
    dea.continent,
    dea.location,
    dea.date,
    dea.population,
    vac.new_vaccinations,
    SUM(CAST(vac.new_vaccinations AS BIGINT)) OVER (PARTITION BY dea.location ORDER BY dea.date) 
	AS running_sum
FROM
    CovidVaccinations vac
JOIN
    CovidDeaths dea ON dea.location = vac.location AND dea.date = vac.date
WHERE
    dea.continent IS NOT NULL
ORDER BY
    2, 3;


WITH POPvsVac (Continent, Location, date, population, new_vaccinations, running_sum)
AS
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CAST(vac.new_vaccinations AS BIGINT)) OVER (PARTITION BY dea.location ORDER BY dea.date) 
	AS running_sum
FROM CovidVaccinations vac
JOIN CovidDeaths dea ON dea.location = vac.location AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 2, 3	
)

Select *, (running_sum/population) *100 AS RNSP
From POPvsVac

--TempTables

DROP Table if EXISTS #PercentPopulationVaccinated
CREATE Table #PercentPopulationVaccinated
(

Continent nvarchar(255),
Location nvarchar (255),
Date datetime, 
Population numeric, 
New_vaccinations numeric, 
running_sum numeric
)

INSERT INTO #PercentPopulationVaccinated

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CAST(vac.new_vaccinations AS BIGINT)) OVER (PARTITION BY dea.location ORDER BY dea.date) 
	AS running_sum
FROM CovidVaccinations vac
JOIN CovidDeaths dea ON dea.location = vac.location AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 2, 3	

SELECT *
FROM #PercentPopulationVaccinated

--Create View

CREATE VIEW PercentPopulationVaccinated AS
SELECT Location, population, MAX(total_cases) AS MaxTotalCases, (CONVERT(DECIMAL(18,2), MAX(total_cases)) 
/ CONVERT(DECIMAL(18,2), population) )*100 
as SickPercentage
From PortfolioProject..CovidDeaths
--WHERE location like '%sweden%' AND total_cases IS NOT NULL
GROUP BY location, population
--ORDER BY SickPercentage DESC

SELECT *
FROM PercentPopulationVaccinated
ORDER BY SickPercentage ASC
