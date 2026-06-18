-- EXPLORATORY DATA ANALYSIS

SELECT * FROM layoffs_staging2;

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

SELECT * FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

SELECT * FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

SELECT company, SUM(total_laid_off) as total_laid_off
FROM layoffs_staging2
GROUP BY company
ORDER BY total_laid_off DESC;

SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2;

SELECT industry, SUM(total_laid_off) as total_laid_off
FROM layoffs_staging2
GROUP BY industry
ORDER BY total_laid_off DESC;

SELECT * FROM layoffs_staging2;

SELECT country, SUM(total_laid_off) as total_laid_off
FROM layoffs_staging2
GROUP BY country
ORDER BY total_laid_off DESC;

SELECT YEAR(`date`), SUM(total_laid_off) as total_laid_off
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY total_laid_off DESC;

SELECT stage, SUM(total_laid_off) as total_laid_off
FROM layoffs_staging2
GROUP BY stage
ORDER BY total_laid_off DESC;

WITH monthly_layoffs AS (
	SELECT SUBSTR(`date`, 1, 7) AS `Month`, SUM(total_laid_off) as layoffs
	FROM layoffs_staging2
	WHERE SUBSTR(`date`, 1, 7) IS NOT NULL
	GROUP BY `Month`
	ORDER BY 1
)
SELECT `Month`, SUM(layoffs) OVER (ORDER BY `Month`) as Rolling_Month_Total_Layoffs
FROM monthly_layoffs;


WITH cte AS (
	SELECT company, SUBSTR(`date`, 1, 4) AS yr, SUM(total_laid_off) AS total_laid_off
	FROM layoffs_staging2
	GROUP BY company, yr
	ORDER BY total_laid_off DESC
)
SELECT company, yr, SUM(total_laid_off) OVER(PARTITION BY company ORDER BY yr)
FROM cte;

WITH rank_cte AS (
	SELECT company, SUBSTR(`date`, 1, 4) AS yr, SUM(total_laid_off) AS total_laid_off
	FROM layoffs_staging2
    WHERE SUBSTR(`date`, 1, 4) IS NOT NULL
	GROUP BY company, yr
)
, rnk_lte_5 AS (
	SELECT company, yr, total_laid_off, DENSE_RANK() OVER(PARTITION BY yr ORDER BY total_laid_off DESC) as rnk
	FROM rank_cte
)
SELECT * FROM rnk_lte_5
WHERE rnk <= 5;