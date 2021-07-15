USE H_Accounting;
DROP PROCEDURE IF EXISTS `jgranjaalmeida2019_sp`;

-- Balance Sheet Creation --

DROP PROCEDURE IF EXISTS `jgranjaalmeida2019_sp`;

-- Create Stored procedures for BS
DELIMITER $$

	CREATE PROCEDURE `jgranjaalmeida2019_sp`(varCalendarYear_y1 YEAR, varCalendarYear_y2 YEAR)
	BEGIN
  
	-- Define variables inside BS procedure
    DECLARE varCA_y1 			DOUBLE DEFAULT 0;
    DECLARE varFA_y1 			DOUBLE DEFAULT 0;
    DECLARE varDA_y1 			DOUBLE DEFAULT 0;
    DECLARE varCL_y1			DOUBLE DEFAULT 0;
    DECLARE varLLL_y1 			DOUBLE DEFAULT 0;
    DECLARE varDL_y1 			DOUBLE DEFAULT 0;
    DECLARE varEQ_y1			DOUBLE DEFAULT 0;
    DECLARE varTotalAsset_y1	DOUBLE DEFAULT 0;
    DECLARE varTotalLiabi_y1	DOUBLE DEFAULT 0;
    DECLARE varEquiLiabi_y1		DOUBLE DEFAULT 0;
	DECLARE varCA_y2 			DOUBLE DEFAULT 0;
    DECLARE varFA_y2 			DOUBLE DEFAULT 0;
    DECLARE varDA_y2 			DOUBLE DEFAULT 0;
    DECLARE varCL_y2			DOUBLE DEFAULT 0;
    DECLARE varLLL_y2 			DOUBLE DEFAULT 0;
    DECLARE varDL_y2 			DOUBLE DEFAULT 0;
    DECLARE varEQ_y2			DOUBLE DEFAULT 0;
    DECLARE varTotalAsset_y2	DOUBLE DEFAULT 0;
    DECLARE varTotalLiabi_y2	DOUBLE DEFAULT 0;
    DECLARE varEquiLiabi_y2		DOUBLE DEFAULT 0;

	-- Calculate the value and store them into the variables declared
    #varCA_y1
	SELECT SUM(IFNULL(jeli.debit,0) - IFNULL(jeli.credit,0)) INTO varCA_y1
            
		FROM journal_entry_line_item AS jeli
			INNER JOIN `account` 			AS ac ON ac.account_id = jeli.account_id
			INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
			INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.balance_sheet_section_id
            
		WHERE YEAR(je.entry_date) = varCalendarYear_y1
			AND ac.balance_sheet_section_id <> 0
            AND ss.statement_section_code = 'CA'
            AND je.debit_credit_balanced = 1;
            
    #varCA_y2
	SELECT SUM(IFNULL(jeli.debit,0) - IFNULL(jeli.credit,0)) INTO varCA_y2
            
		FROM journal_entry_line_item AS jeli
			INNER JOIN `account` 			AS ac ON ac.account_id = jeli.account_id
			INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
			INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.balance_sheet_section_id
            
		WHERE YEAR(je.entry_date) = varCalendarYear_y2
			AND ac.balance_sheet_section_id <> 0
            AND ss.statement_section_code = 'CA'
            AND je.debit_credit_balanced = 1;

    #varFA_y1
	SELECT SUM(IFNULL(jeli.debit,0) - IFNULL(jeli.credit,0)) INTO varFA_y1
            
		FROM journal_entry_line_item AS jeli
			INNER JOIN `account` 			AS ac ON ac.account_id = jeli.account_id
			INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
			INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.balance_sheet_section_id
            
		WHERE YEAR(je.entry_date) = varCalendarYear_y1
			AND ac.balance_sheet_section_id <> 0
            AND ss.statement_section_code = 'FA'
            AND je.debit_credit_balanced = 1;		

    #varFA_y2
	SELECT SUM(IFNULL(jeli.debit,0) - IFNULL(jeli.credit,0)) INTO varFA_y2
            
		FROM journal_entry_line_item AS jeli
			INNER JOIN `account` 			AS ac ON ac.account_id = jeli.account_id
			INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
			INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.balance_sheet_section_id
            
		WHERE YEAR(je.entry_date) = varCalendarYear_y2
			AND ac.balance_sheet_section_id <> 0
            AND ss.statement_section_code = 'FA'
            AND je.debit_credit_balanced = 1;		

    #varDA_y1
	SELECT SUM(IFNULL(jeli.debit,0) - IFNULL(jeli.credit,0)) INTO varDA_y1
            
		FROM journal_entry_line_item AS jeli
			INNER JOIN `account` 			AS ac ON ac.account_id = jeli.account_id
			INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
			INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.balance_sheet_section_id
            
		WHERE YEAR(je.entry_date) = varCalendarYear_y1
			AND ac.balance_sheet_section_id <> 0
            AND ss.statement_section_code = 'DA'
            AND je.debit_credit_balanced = 1;

    #varDA_y2
	SELECT SUM(IFNULL(jeli.debit,0) - IFNULL(jeli.credit,0)) INTO varDA_y2
            
		FROM journal_entry_line_item AS jeli
			INNER JOIN `account` 			AS ac ON ac.account_id = jeli.account_id
			INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
			INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.balance_sheet_section_id
            
		WHERE YEAR(je.entry_date) = varCalendarYear_y2
			AND ac.balance_sheet_section_id <> 0
            AND ss.statement_section_code = 'DA'
            AND je.debit_credit_balanced = 1;

    #varCL_y1
	SELECT SUM(IFNULL(jeli.credit,0) - IFNULL(jeli.debit,0)) INTO varCL_y1
            
		FROM journal_entry_line_item AS jeli
			INNER JOIN `account` 			AS ac ON ac.account_id = jeli.account_id
			INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
			INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.balance_sheet_section_id
            
		WHERE YEAR(je.entry_date) = varCalendarYear_y1
			AND ac.balance_sheet_section_id <> 0
            AND ss.statement_section_code = 'CL'
            AND je.debit_credit_balanced = 1;	

    #varCL_y2
	SELECT SUM(IFNULL(jeli.credit,0) - IFNULL(jeli.debit,0)) INTO varCL_y2
            
		FROM journal_entry_line_item AS jeli
			INNER JOIN `account` 			AS ac ON ac.account_id = jeli.account_id
			INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
			INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.balance_sheet_section_id
            
		WHERE YEAR(je.entry_date) = varCalendarYear_y2
			AND ac.balance_sheet_section_id <> 0
            AND ss.statement_section_code = 'CL'
            AND je.debit_credit_balanced = 1;	

    #varLLL_y1
	SELECT SUM(IFNULL(jeli.credit,0) - IFNULL(jeli.debit,0)) INTO varLLL_y1
            
		FROM journal_entry_line_item AS jeli
			INNER JOIN `account` 			AS ac ON ac.account_id = jeli.account_id
			INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
			INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.balance_sheet_section_id
            
		WHERE YEAR(je.entry_date) = varCalendarYear_y1
			AND ac.balance_sheet_section_id <> 0
            AND ss.statement_section_code = 'LLL'
            AND je.debit_credit_balanced = 1;	
            
    #varLLL_y2
	SELECT SUM(IFNULL(jeli.credit,0) - IFNULL(jeli.debit,0)) INTO varLLL_y2
            
		FROM journal_entry_line_item AS jeli
			INNER JOIN `account` 			AS ac ON ac.account_id = jeli.account_id
			INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
			INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.balance_sheet_section_id
            
		WHERE YEAR(je.entry_date) = varCalendarYear_y2
			AND ac.balance_sheet_section_id <> 0
            AND ss.statement_section_code = 'LLL'
            AND je.debit_credit_balanced = 1;	

    #varDL_y1
	SELECT SUM(IFNULL(jeli.credit,0) - IFNULL(jeli.debit,0)) INTO varDL_y1
            
		FROM journal_entry_line_item AS jeli
			INNER JOIN `account` 			AS ac ON ac.account_id = jeli.account_id
			INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
			INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.balance_sheet_section_id
            
		WHERE YEAR(je.entry_date) = varCalendarYear_y1
			AND ac.balance_sheet_section_id <> 0
            AND ss.statement_section_code = 'DL'
            AND je.debit_credit_balanced = 1;

    #varDL_y2
	SELECT SUM(IFNULL(jeli.credit,0) - IFNULL(jeli.debit,0)) INTO varDL_y2
            
		FROM journal_entry_line_item AS jeli
			INNER JOIN `account` 			AS ac ON ac.account_id = jeli.account_id
			INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
			INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.balance_sheet_section_id
            
		WHERE YEAR(je.entry_date) = varCalendarYear_y2
			AND ac.balance_sheet_section_id <> 0
            AND ss.statement_section_code = 'DL'
            AND je.debit_credit_balanced = 1;

    #varEQ_y1
	SELECT SUM(IFNULL(jeli.credit,0) - IFNULL(jeli.debit,0)) INTO varEQ_y1
            
		FROM journal_entry_line_item AS jeli
			INNER JOIN `account` 			AS ac ON ac.account_id = jeli.account_id
			INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
			INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.balance_sheet_section_id
            
		WHERE YEAR(je.entry_date) = varCalendarYear_y1
			AND ac.balance_sheet_section_id <> 0
            AND ss.statement_section_code = 'EQ'
            AND je.debit_credit_balanced = 1;	

    #varEQ_y2
	SELECT SUM(IFNULL(jeli.credit,0) - IFNULL(jeli.debit,0)) INTO varEQ_y2
            
		FROM journal_entry_line_item AS jeli
			INNER JOIN `account` 			AS ac ON ac.account_id = jeli.account_id
			INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
			INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.balance_sheet_section_id
            
		WHERE YEAR(je.entry_date) = varCalendarYear_y2
			AND ac.balance_sheet_section_id <> 0
            AND ss.statement_section_code = 'EQ'
            AND je.debit_credit_balanced = 1;	

    #varTotalAsset_y1
	SELECT SUM(IFNULL(jeli.debit,0) - IFNULL(jeli.credit,0)) INTO varTotalAsset_y1
            
		FROM journal_entry_line_item AS jeli
			INNER JOIN `account` 			AS ac ON ac.account_id = jeli.account_id
			INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
			INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.balance_sheet_section_id
            
		WHERE YEAR(je.entry_date) = varCalendarYear_y1
			AND ac.balance_sheet_section_id <> 0
            AND ss.statement_section_code IN ('CA','FA','DA')
            AND je.debit_credit_balanced = 1;	

    #varTotalAsset_y2
	SELECT SUM(IFNULL(jeli.debit,0) - IFNULL(jeli.credit,0)) INTO varTotalAsset_y2
            
		FROM journal_entry_line_item AS jeli
			INNER JOIN `account` 			AS ac ON ac.account_id = jeli.account_id
			INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
			INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.balance_sheet_section_id
            
		WHERE YEAR(je.entry_date) = varCalendarYear_y2
			AND ac.balance_sheet_section_id <> 0
            AND ss.statement_section_code IN ('CA','FA','DA')
            AND je.debit_credit_balanced = 1;	

    #varTotalLiabi_y1
	SELECT SUM(IFNULL(jeli.credit,0) - IFNULL(jeli.debit,0)) INTO varTotalLiabi_y1
            
		FROM journal_entry_line_item AS jeli
			INNER JOIN `account` 			AS ac ON ac.account_id = jeli.account_id
			INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
			INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.balance_sheet_section_id
            
		WHERE YEAR(je.entry_date) = varCalendarYear_y1
			AND ac.balance_sheet_section_id <> 0
            AND ss.statement_section_code IN ('CL','LLL','DL')
            AND je.debit_credit_balanced = 1;	
            
    #varTotalLiabi_y2
	SELECT SUM(IFNULL(jeli.credit,0) - IFNULL(jeli.debit,0)) INTO varTotalLiabi_y2
            
		FROM journal_entry_line_item AS jeli
			INNER JOIN `account` 			AS ac ON ac.account_id = jeli.account_id
			INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
			INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.balance_sheet_section_id
            
		WHERE YEAR(je.entry_date) = varCalendarYear_y2
			AND ac.balance_sheet_section_id <> 0
            AND ss.statement_section_code IN ('CL','LLL','DL')
            AND je.debit_credit_balanced = 1;	
	
        #varEquiLiabi_y1
	SELECT SUM(IFNULL(jeli.credit,0) - IFNULL(jeli.debit,0)) INTO varEquiLiabi_y1
            
		FROM journal_entry_line_item AS jeli
			INNER JOIN `account` 			AS ac ON ac.account_id = jeli.account_id
			INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
			INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.balance_sheet_section_id
            
		WHERE YEAR(je.entry_date) = varCalendarYear_y1
			AND ac.balance_sheet_section_id <> 0
            AND ss.statement_section_code NOT IN ('CA','FA','DA')
            AND je.debit_credit_balanced = 1;	
            
        #varEquiLiabi_y2
	SELECT SUM(IFNULL(jeli.credit,0) - IFNULL(jeli.debit,0)) INTO varEquiLiabi_y2
            
		FROM journal_entry_line_item AS jeli
			INNER JOIN `account` 			AS ac ON ac.account_id = jeli.account_id
			INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
			INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.balance_sheet_section_id
            
		WHERE YEAR(je.entry_date) = varCalendarYear_y2
			AND ac.balance_sheet_section_id <> 0
            AND ss.statement_section_code NOT IN ('CA','FA','DA')
            AND je.debit_credit_balanced = 1;	
            
	-- Create BS table
	DROP TABLE IF EXISTS tmp_jgranjaalmeida2019_table;
    
	CREATE TABLE tmp_jgranjaalmeida2019_table
		(	balance_sheet_line_number INT, 
			label VARCHAR(50), 
			amount_y1 VARCHAR(50),
            amount_y2 VARCHAR(50)
		);
  
	-- Insert the data for the report
	INSERT INTO tmp_jgranjaalmeida2019_table 
			(balance_sheet_line_number, label, amount_y1, amount_y2)    
			VALUES (1, 'BALANCE SHEET', '', "In USD"),
				   (2, '', '', ''),
                   (3, '', varCalendarYear_y1, varCalendarYear_y2),
				   (4, 'Current assets', 		format(IFNULL(varCA_y1, 0),0),	format(IFNULL(varCA_y2, 0),0)),
                   (5, 'Fixed assets', 			format(IFNULL(varFA_y1, 0),0),	format(IFNULL(varFA_y2, 0),0)),
                   (6, 'Deferred assets', 		format(IFNULL(varDA_y1, 0),0),	format(IFNULL(varDA_y2, 0),0)),
                   (7, 'Total assets', 			format(IFNULL(varTotalAsset_y1, 0),0),	format(IFNULL(varTotalAsset_y2, 0),0)),
                   (8, '', '', ''),
                   (9, 'Current liabilities', 	format(IFNULL(varCL_y1, 0),0),	format(IFNULL(varCL_y2, 0),0)),
                   (10, 'Long-term liabilities', format(IFNULL(varLLL_y1, 0),0),	format(IFNULL(varLLL_y2, 0),0)),
                   (11, 'Deferred liabilities' , format(IFNULL(varDL_y1, 0),0),		format(IFNULL(varDL_y2, 0),0)),
                   (12, 'Total liabilities', 	format(IFNULL(varTotalLiabi_y1, 0),0),	format(IFNULL(varTotalLiabi_y2, 0),0)),
                   (13, 'Equity', 				format(IFNULL(varEQ_y1, 0),0),		format(IFNULL(varEQ_y2, 0),0)),
                   (14, 'Total equity and liabilities', format(IFNULL(varEquiLiabi_y1, 0),0), format(IFNULL(varEquiLiabi_y2, 0),0));
            
  END $$

DELIMITER ;          

#call BS stored procedures
CALL jgranjaalmeida2019_sp(2019, 2018);

#display BS
SELECT * FROM tmp_jgranjaalmeida2019_table; 