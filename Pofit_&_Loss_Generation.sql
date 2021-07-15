USE H_Accounting;
DROP PROCEDURE IF EXISTS `jgranjaalmeida2019_sp`;

-- Profit and Loss Statement

-- Create Stored procedures for PL
DELIMITER $$

	CREATE PROCEDURE `jgranjaalmeida2019_sp`(varCalendarYear_y1 YEAR, varCalendarYear_y2 YEAR)
	BEGIN
  
	-- Define variables inside PL procedure
    DECLARE varRevenue_y1 			DOUBLE DEFAULT 0;
    DECLARE varReturns_y1			DOUBLE DEFAULT 0;
    DECLARE varCOGS_y1 				DOUBLE DEFAULT 0;
    DECLARE varGrossprofit_y1 		DOUBLE DEFAULT 0;
    DECLARE varSelling_y1 			DOUBLE DEFAULT 0;
    DECLARE varAdmin_y1 			DOUBLE DEFAULT 0;
    DECLARE varOtherIncome_y1		DOUBLE DEFAULT 0;
    DECLARE varOtherExp_y1			DOUBLE DEFAULT 0;
    DECLARE varEBIT_y1				DOUBLE DEFAULT 0;
    DECLARE varIncomeTax_y1			DOUBLE DEFAULT 0;
	DECLARE varOtherTax_y1			DOUBLE DEFAULT 0;
	DECLARE varProfitLoss_y1		DOUBLE DEFAULT 0;
    DECLARE varRevenue_y2			DOUBLE DEFAULT 0;
    DECLARE varReturns_y2			DOUBLE DEFAULT 0;
    DECLARE varCOGS_y2 				DOUBLE DEFAULT 0;
    DECLARE varGrossprofit_y2 		DOUBLE DEFAULT 0;
    DECLARE varSelling_y2 			DOUBLE DEFAULT 0;
    DECLARE varAdmin_y2 			DOUBLE DEFAULT 0;
    DECLARE varOtherIncome_y2		DOUBLE DEFAULT 0;
    DECLARE varOtherExp_y2			DOUBLE DEFAULT 0;
    DECLARE varEBIT_y2				DOUBLE DEFAULT 0;
    DECLARE varIncomeTax_y2			DOUBLE DEFAULT 0;
	DECLARE varOtherTax_y2			DOUBLE DEFAULT 0;
	DECLARE varProfitLoss_y2		DOUBLE DEFAULT 0;

	-- Calculate the value and store them into the variables declared
    #varRevenue_y1 
	SELECT SUM(IFNULL(jeli.credit,0) - IFNULL(jeli.debit,0)) INTO varRevenue_y1 
            
		FROM journal_entry_line_item AS jeli
			INNER JOIN `account` 			AS ac ON ac.account_id = jeli.account_id
			INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
			INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.profit_loss_section_id
            
		WHERE YEAR(je.entry_date) = varCalendarYear_y1 
			AND ac.profit_loss_section_id <> 0
			AND je.closing_type = 0
			AND je.cancelled = 0
			AND description NOT LIKE '%closing%'
            AND ss.statement_section_code = 'REV';
            
    #varRevenue_y2
	SELECT SUM(IFNULL(jeli.credit,0) - IFNULL(jeli.debit,0)) INTO varRevenue_y2
            
		FROM journal_entry_line_item AS jeli
			INNER JOIN `account` 			AS ac ON ac.account_id = jeli.account_id
			INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
			INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.profit_loss_section_id
            
		WHERE YEAR(je.entry_date) = varCalendarYear_y2
			AND ac.profit_loss_section_id <> 0
            AND je.closing_type = 0
			AND je.cancelled = 0
			AND description NOT LIKE '%closing%'
            AND ss.statement_section_code = 'REV';
            
    #varReturns_y1
	SELECT SUM(IFNULL(jeli.debit,0) - IFNULL(jeli.credit,0)) INTO varReturns_y1
            
		FROM journal_entry_line_item AS jeli
			INNER JOIN `account` 			AS ac ON ac.account_id = jeli.account_id
			INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
			INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.profit_loss_section_id
            
		WHERE YEAR(je.entry_date) = varCalendarYear_y1
			AND ac.profit_loss_section_id <> 0
            AND je.closing_type = 0
			AND je.cancelled = 0
			AND description NOT LIKE '%closing%'
            AND ss.statement_section_code = 'RET';

    #varReturns_y2
	SELECT SUM(IFNULL(jeli.debit,0) - IFNULL(jeli.credit,0)) INTO varReturns_y2
            
		FROM journal_entry_line_item AS jeli
			INNER JOIN `account` 			AS ac ON ac.account_id = jeli.account_id
			INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
			INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.profit_loss_section_id
            
		WHERE YEAR(je.entry_date) = varCalendarYear_y2
			AND ac.profit_loss_section_id <> 0
			AND je.closing_type = 0
			AND je.cancelled = 0
			AND description NOT LIKE '%closing%'
            AND ss.statement_section_code = 'RET';       

    #varCOGS_y1
	SELECT SUM(IFNULL(jeli.debit,0) - IFNULL(jeli.credit,0)) INTO varCOGS_y1
            
		FROM journal_entry_line_item AS jeli
			INNER JOIN `account` 			AS ac ON ac.account_id = jeli.account_id
			INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
			INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.profit_loss_section_id
            
		WHERE YEAR(je.entry_date) = varCalendarYear_y1
			AND ac.profit_loss_section_id <> 0
			AND je.closing_type = 0
			AND je.cancelled = 0
			AND description NOT LIKE '%closing%'
            AND ss.statement_section_code = 'COGS';   
            
    #varCOGS_y2
	SELECT SUM(IFNULL(jeli.debit,0) - IFNULL(jeli.credit,0)) INTO varCOGS_y2
            
		FROM journal_entry_line_item AS jeli
			INNER JOIN `account` 			AS ac ON ac.account_id = jeli.account_id
			INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
			INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.profit_loss_section_id
            
		WHERE YEAR(je.entry_date) = varCalendarYear_y2
			AND ac.profit_loss_section_id <> 0
			AND je.closing_type = 0
			AND je.cancelled = 0
			AND description NOT LIKE '%closing%'
            AND ss.statement_section_code = 'COGS';   

    #varGrossprofit_y1
	SELECT SUM(IFNULL(jeli.credit,0) - IFNULL(jeli.debit,0)) INTO varGrossprofit_y1
            
		FROM journal_entry_line_item AS jeli
			INNER JOIN `account` 			AS ac ON ac.account_id = jeli.account_id
			INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
			INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.profit_loss_section_id
            
		WHERE YEAR(je.entry_date) = varCalendarYear_y1
			AND ac.profit_loss_section_id <> 0
			AND je.closing_type = 0
			AND je.cancelled = 0
			AND description NOT LIKE '%closing%'
            AND ss.statement_section_code IN ('REV', 'RET', 'COGS');   
            
    #varGrossprofit_y2
	SELECT SUM(IFNULL(jeli.credit,0) - IFNULL(jeli.debit,0)) INTO varGrossprofit_y2
            
		FROM journal_entry_line_item AS jeli
			INNER JOIN `account` 			AS ac ON ac.account_id = jeli.account_id
			INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
			INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.profit_loss_section_id
            
		WHERE YEAR(je.entry_date) = varCalendarYear_y2
			AND ac.profit_loss_section_id <> 0
			AND je.closing_type = 0
			AND je.cancelled = 0
			AND description NOT LIKE '%closing%'
            AND ss.statement_section_code IN ('REV', 'RET', 'COGS');     

    #varSelling_y1
	SELECT SUM(IFNULL(jeli.debit,0) - IFNULL(jeli.credit,0)) INTO varSelling_y1
            
		FROM journal_entry_line_item AS jeli
			INNER JOIN `account` 			AS ac ON ac.account_id = jeli.account_id
			INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
			INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.profit_loss_section_id
            
		WHERE YEAR(je.entry_date) = varCalendarYear_y1
			AND ac.profit_loss_section_id <> 0
			AND je.closing_type = 0
			AND je.cancelled = 0
			AND description NOT LIKE '%closing%'
            AND ss.statement_section_code = 'SEXP';   
            
    #varSelling_y2
	SELECT SUM(IFNULL(jeli.debit,0) - IFNULL(jeli.credit,0)) INTO varSelling_y2
            
		FROM journal_entry_line_item AS jeli
			INNER JOIN `account` 			AS ac ON ac.account_id = jeli.account_id
			INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
			INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.profit_loss_section_id
            
		WHERE YEAR(je.entry_date) = varCalendarYear_y2
			AND ac.profit_loss_section_id <> 0
			AND je.closing_type = 0
			AND je.cancelled = 0
			AND description NOT LIKE '%closing%'
            AND ss.statement_section_code = 'SEXP';   
	
	#varAdmin_y1
	SELECT SUM(IFNULL(jeli.debit,0) - IFNULL(jeli.credit,0)) INTO varAdmin_y1
            
		FROM journal_entry_line_item AS jeli
			INNER JOIN `account` 			AS ac ON ac.account_id = jeli.account_id
			INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
			INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.profit_loss_section_id
            
		WHERE YEAR(je.entry_date) = varCalendarYear_y1
			AND ac.profit_loss_section_id <> 0
			AND je.closing_type = 0
			AND je.cancelled = 0
			AND description NOT LIKE '%closing%'
            AND ss.statement_section_code = 'GEXP';   
            
	#varAdmin_y2
	SELECT SUM(IFNULL(jeli.debit,0) - IFNULL(jeli.credit,0)) INTO varAdmin_y2
            
		FROM journal_entry_line_item AS jeli
			INNER JOIN `account` 			AS ac ON ac.account_id = jeli.account_id
			INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
			INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.profit_loss_section_id
            
		WHERE YEAR(je.entry_date) = varCalendarYear_y2
			AND ac.profit_loss_section_id <> 0
			AND je.closing_type = 0
			AND je.cancelled = 0
			AND description NOT LIKE '%closing%'
            AND ss.statement_section_code = 'GEXP';   

	#varOtherIncome_y1
	SELECT SUM(IFNULL(jeli.credit,0) - IFNULL(jeli.debit,0)) INTO varOtherIncome_y1
            
		FROM journal_entry_line_item AS jeli
			INNER JOIN `account` 			AS ac ON ac.account_id = jeli.account_id
			INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
			INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.profit_loss_section_id
            
		WHERE YEAR(je.entry_date) = varCalendarYear_y1
			AND ac.profit_loss_section_id <> 0
			AND je.closing_type = 0
			AND je.cancelled = 0
			AND description NOT LIKE '%closing%'
            AND ss.statement_section_code = 'OI';  
            
	#varOtherIncome_y2
	SELECT SUM(IFNULL(jeli.credit,0) - IFNULL(jeli.debit,0)) INTO varOtherIncome_y2
            
		FROM journal_entry_line_item AS jeli
			INNER JOIN `account` 			AS ac ON ac.account_id = jeli.account_id
			INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
			INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.profit_loss_section_id
            
		WHERE YEAR(je.entry_date) = varCalendarYear_y2
			AND ac.profit_loss_section_id <> 0
			AND je.closing_type = 0
			AND je.cancelled = 0
			AND description NOT LIKE '%closing%'
            AND ss.statement_section_code = 'OI';  

	#varOtherExp_y1
	SELECT SUM(IFNULL(jeli.debit,0) - IFNULL(jeli.credit,0)) INTO varOtherExp_y1
            
		FROM journal_entry_line_item AS jeli
			INNER JOIN `account` 			AS ac ON ac.account_id = jeli.account_id
			INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
			INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.profit_loss_section_id
            
		WHERE YEAR(je.entry_date) = varCalendarYear_y1
			AND ac.profit_loss_section_id <> 0
			AND je.closing_type = 0
			AND je.cancelled = 0
			AND description NOT LIKE '%closing%'
            AND ss.statement_section_code = 'OEXP';  

	#varOtherExp_y2
	SELECT SUM(IFNULL(jeli.debit,0) - IFNULL(jeli.credit,0)) INTO varOtherExp_y2
            
		FROM journal_entry_line_item AS jeli
			INNER JOIN `account` 			AS ac ON ac.account_id = jeli.account_id
			INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
			INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.profit_loss_section_id
            
		WHERE YEAR(je.entry_date) = varCalendarYear_y2
			AND ac.profit_loss_section_id <> 0
			AND je.closing_type = 0
			AND je.cancelled = 0
			AND description NOT LIKE '%closing%'
            AND ss.statement_section_code = 'OEXP';  
            
	#varEBIT_y1
	SELECT SUM(IFNULL(jeli.credit,0) - IFNULL(jeli.debit,0)) INTO varEBIT_y1
            
		FROM journal_entry_line_item AS jeli
			INNER JOIN `account` 			AS ac ON ac.account_id = jeli.account_id
			INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
			INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.profit_loss_section_id
            
		WHERE YEAR(je.entry_date) = varCalendarYear_y1
			AND ac.profit_loss_section_id <> 0
			AND je.closing_type = 0
			AND je.cancelled = 0
			AND description NOT LIKE '%closing%'
            AND ss.statement_section_code IN ('REV','RET', 'COGS','GEXP','SEXP','OEXP','OI');  
            
	#varEBIT_y2
	SELECT SUM(IFNULL(jeli.credit,0) - IFNULL(jeli.debit,0)) INTO varEBIT_y2
            
		FROM journal_entry_line_item AS jeli
			INNER JOIN `account` 			AS ac ON ac.account_id = jeli.account_id
			INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
			INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.profit_loss_section_id
            
		WHERE YEAR(je.entry_date) = varCalendarYear_y2
			AND ac.profit_loss_section_id <> 0
			AND je.closing_type = 0
			AND je.cancelled = 0
			AND description NOT LIKE '%closing%'
            AND ss.statement_section_code IN ('REV','RET', 'COGS','GEXP','SEXP','OEXP','OI');  


	#varIncomeTax_y1
	SELECT SUM(IFNULL(jeli.debit,0) - IFNULL(jeli.credit,0)) INTO varIncomeTax_y1
            
		FROM journal_entry_line_item AS jeli
			INNER JOIN `account` 			AS ac ON ac.account_id = jeli.account_id
			INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
			INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.profit_loss_section_id
            
		WHERE YEAR(je.entry_date) = varCalendarYear_y1
			AND ac.profit_loss_section_id <> 0
			AND je.closing_type = 0
			AND je.cancelled = 0
			AND description NOT LIKE '%closing%'
            AND ss.statement_section_code = 'INCTAX';  

	#varIncomeTax_y2
	SELECT SUM(IFNULL(jeli.debit,0) - IFNULL(jeli.credit,0)) INTO varIncomeTax_y2
            
		FROM journal_entry_line_item AS jeli
			INNER JOIN `account` 			AS ac ON ac.account_id = jeli.account_id
			INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
			INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.profit_loss_section_id
            
		WHERE YEAR(je.entry_date) = varCalendarYear_y2
			AND ac.profit_loss_section_id <> 0
			AND je.closing_type = 0
			AND je.cancelled = 0
			AND description NOT LIKE '%closing%'
            AND ss.statement_section_code = 'INCTAX';  
            
	#varOtherTax_y1
	SELECT SUM(IFNULL(jeli.debit,0) - IFNULL(jeli.credit,0)) INTO varOtherTax_y1
            
		FROM journal_entry_line_item AS jeli
			INNER JOIN `account` 			AS ac ON ac.account_id = jeli.account_id
			INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
			INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.profit_loss_section_id
            
		WHERE YEAR(je.entry_date) = varCalendarYear_y1
			AND ac.profit_loss_section_id <> 0
			AND je.closing_type = 0
			AND je.cancelled = 0
			AND description NOT LIKE '%closing%'
            AND ss.statement_section_code = 'OTHTAX';  
            
	#varOtherTax_y2
	SELECT SUM(IFNULL(jeli.debit,0) - IFNULL(jeli.credit,0)) INTO varOtherTax_y2
            
		FROM journal_entry_line_item AS jeli
			INNER JOIN `account` 			AS ac ON ac.account_id = jeli.account_id
			INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
			INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.profit_loss_section_id
            
		WHERE YEAR(je.entry_date) = varCalendarYear_y2
			AND ac.profit_loss_section_id <> 0
			AND je.closing_type = 0
			AND je.cancelled = 0
			AND description NOT LIKE '%closing%'
            AND ss.statement_section_code = 'OTHTAX';  

	#varProfitLoss_y1
	SELECT SUM(IFNULL(jeli.credit,0) - IFNULL(jeli.debit,0)) INTO varProfitLoss_y1
            
		FROM journal_entry_line_item AS jeli
			INNER JOIN `account` 			AS ac ON ac.account_id = jeli.account_id
			INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
			INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.profit_loss_section_id
            
		WHERE YEAR(je.entry_date) = varCalendarYear_y1
			AND ac.profit_loss_section_id <> 0
            AND je.closing_type = 0
			AND je.cancelled = 0
			AND description NOT LIKE '%closing%';  
            
            
	#varProfitLoss_y2
	SELECT SUM(IFNULL(jeli.credit,0) - IFNULL(jeli.debit,0)) INTO varProfitLoss_y2
            
		FROM journal_entry_line_item AS jeli
			INNER JOIN `account` 			AS ac ON ac.account_id = jeli.account_id
			INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
			INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.profit_loss_section_id
            
		WHERE YEAR(je.entry_date) = varCalendarYear_y2
			AND ac.profit_loss_section_id <> 0
            AND je.closing_type = 0
			AND je.cancelled = 0
			AND description NOT LIKE '%closing%';  

	-- create PL table
	DROP TABLE IF EXISTS tmp_jgranjaalmeida2019_table;

	CREATE TABLE tmp_jgranjaalmeida2019_table
		(	profit_loss_line_number INT, 
			label VARCHAR(50), 
			amount_y1 VARCHAR(50),
            amount_y2 VARCHAR(50)
		);

	-- Insert the data for the report
	INSERT INTO tmp_jgranjaalmeida2019_table 
			(profit_loss_line_number, label, amount_y1, amount_y2)
			VALUES (1, 'PROFIT AND LOSS STATEMENT', '', "In USD"),
				   (2, '', '', ''),
                   (3, '', varCalendarYear_y1, varCalendarYear_y2),
				   (4, 'Revenue', 						format(IFNULL(varRevenue_y1,0),0),	format(IFNULL(varRevenue_y2,0),0)),
                   (5, 'Returns, refunds, discounts', 	format(IFNULL(varReturns_y1,0),0),	format(IFNULL(varReturns_y2,0),0)),
                   (6, 'Cost of goods and services', 	format(IFNULL(varCOGS_y1,0),0),		format(IFNULL(varCOGS_y2,0),0)),
                   (7, 'Gross profit (loss)', 			format(IFNULL(varGrossprofit_y1, 0),0),	format(IFNULL(varGrossprofit_y2, 0),0)),
                   (8, '', '', ''),
                   (9, 'Selling expenses',				format(IFNULL(varSelling_y1,0),0),	format(IFNULL(varSelling_y2,0),0)),
                   (10, 'Administrative expenses',		format(IFNULL(varAdmin_y1,0),0),	format(IFNULL(varAdmin_y2,0),0)),
                   (11, 'Other income' , 				format(IFNULL(varOtherIncome_y1,0),0), format(IFNULL(varOtherIncome_y2,0),0)),
                   (12, 'Other expenses', 				format(IFNULL(varOtherExp_y1,0),0),	format(IFNULL(varOtherExp_y2,0),0)),
                   (13, 'Earnings before interest and taxes (EBIT)', format(IFNULL(varEBIT_y1,0),0),  format(IFNULL(varEBIT_y2,0),0)),
                   (14, '', '', ''),
                   (15, 'Income tax', 					format(IFNULL(varIncomeTax_y1,0),0),	format(IFNULL(varIncomeTax_y2,0),0)),
                   (16, 'Other tax', 					format(IFNULL(varOtherTax_y1,0),0),		format(IFNULL(varOtherTax_y2,0),0)),
                   (17, 'Profit (loss) for the year', 	format(IFNULL(varProfitLoss_y1,0),0),	format(IFNULL(varProfitLoss_y2,0),0))
;

END $$

DELIMITER ;

#call PL stored procedures
CALL jgranjaalmeida2019_sp(2019, 2018);

#display PL	
SELECT * FROM tmp_jgranjaalmeida2019_table;