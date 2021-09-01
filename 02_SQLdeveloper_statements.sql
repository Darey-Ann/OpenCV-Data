-- Code for the paper "OpenCV on Stack Overflow: A Study on Developer Discussions"
-- Darey-Ann Louisville
-- ######################################################################################

-- 2nd step: Pre-Processing

-- Oracle SQL Developer 
-- The statements below were run in SQL developer to create tables and views for analysis
-- Some tables were created by importing the excel/csv files that were saved from the SEDE queries
-- ######################################################################################


-- ######################################################################################
-- ######################################################################################
-- TABLES 
-- ######################################################################################
-- ######################################################################################
/* OVERVIEW - SQL Developer Tables

   *01 categories
   *02 comp_data
   *03 locations
   *04 posts_ans
   *05 posts_answer_intervals
   *06 posts_noans
   *07 rq2_classification
   *08 rq2_classification_final
   *09 rq2_classification_to_fill_in
   *10 rq2_sample
   *11 rq2_sample_bodies
   *12 sample_ids
   *13 tags
   *14 tags_ans_all
   *15 tags_ans_all_pos_score
   *16 tags_noans_all
   *17 tags_noans_all_pos_score
   *18 trends_c
   *19 trends_c#
   *20 trends_cpp
   *21 trends_java
   *22 trends_matlab
   *23 trends_other
   *24 trends_python
   *25 trends_total
*/

-- 01. CATEGORIES 
---- RQ3: Topic Distribution (See paper, table 1.12)
---- NOTE: 
---- Created manually in Excel and imported into SQL developer 
---- see OpenCV_tables_views.xlsb


-- 02. COMP_DATA 
---- RQ3: Comparison dataset: non-OpenCV posts (See paper, table 1.13)
---- NOTE: 
---- imported from Comparison dataset: non-OpenCV posts 
---- see 01_SEDE_queries.sql


-- 03. LOCATIONS 
---- RQ1: User Locations (See paper, table 1.5)
---- NOTE: 
---- Further refined before importing into Excel 
---- see 01_SEDE_queries.sql


-- 04. POSTS_ANS 
---- RQ3: Answered posts  (See paper, table 1.8)
---- NOTE: imported into SQL Developer after saving SEDE query results
---- see 01_SEDE_queries.sql


-- 05. POSTS_ANSWER_INTERVALS
---- RQ3: Post difficulty data
---- NOTE: imported into SQL Developer after saving SEDE query results
---- see 01_SEDE_queries.sql


-- 06. POSTS_NOANS
---- RQ3:  (See paper, table 1.10)
---- NOTE: imported into SQL Developer after saving SEDE query results
---- see 01_SEDE_queries.sql


-- 07. RQ2_CLASSIFICATION (CREATED IN RQ2_QUERIES.SQL)
---- RQ2
---- NOTE: 
---- see RQ2_queries.sql


-- 08. RQ2_CLASSIFICATION_FINAL
---- RQ2: 612 posts subset for question types (See paper, table 1.6)
---- NOTE: 
---- see RQ2_queries.sql


-- 09. RQ2_CLASSIFICATION_TO_FILL_IN
---- RQ2
---- NOTE: 
---- see RQ2_queries.sql


-- 10. RQ2_SAMPLE
---- RQ2 
---- NOTE: 
---- see RQ2_queries.sql


-- 11. RQ2_SAMPLE_BODIES
---- RQ2
---- NOTE: 
---- "Opencv MPEG7 descriptors" has accepted answer id but no time interval, so this row is disregarded.
---- see RQ2_queries.sql


-- 12. SAMPLE_IDS
---- RQ2
---- NOTE: 
---- see RQ2_queries.sql


-- 13. TAGS
---- RQ1: OpenCV related tags (See paper, table 1.4)
---- NOTE: imported into SQL Developer after saving SEDE query results
---- see 01_SEDE_queries.sql



-- 14. TAGS_ANS_ALL
---- extra data
---- NOTE: imported into SQL Developer after saving SEDE query results
---- see 01_SEDE_queries.sql


-- 15. TAGS_ANS_ALL_POS_SCORE
---- extra data
---- NOTE: imported into SQL Developer after saving SEDE query results
---- see 01_SEDE_queries.sql


-- 16. TAGS_NOANS_ALL
---- extra data
---- NOTE: imported into SQL Developer after saving SEDE query results
---- see 01_SEDE_queries.sql


-- 17. TAGS_NOANS_ALL_POS_SCORE
---- extra data
---- NOTE: imported into SQL Developer after saving SEDE query results
---- see 01_SEDE_queries.sql 


-- 18. TRENDS_C
---- RQ1: Post trends per progr.lang. per month  (See paper, table 1.3)
---- NOTE: 
---- see RQ1_queries.sql


-- 19. TRENDS_C#
---- RQ1: Post trends per progr.lang. per month  (See paper, table 1.3)
---- NOTE: 
---- see RQ1_queries.sql


-- 20. TRENDS_CPP
---- RQ1: Post trends per progr.lang. per month  (See paper, table 1.3)
---- NOTE: 
---- see RQ1_queries.sql

-- 21. TRENDS_JAVA
---- RQ1: Post trends per progr.lang. per month  (See paper, table 1.3)
---- NOTE: 
---- see RQ1_queries.sql


-- 22. TRENDS_MATLAB
---- RQ1: Post trends per progr.lang. per month  (See paper, table 1.3)
---- NOTE: 
---- see RQ1_queries.sql 


-- 23. TRENDS_OTHER
---- RQ1: Post trends per progr.lang. per month  (See paper, table 1.3)
---- NOTE: 
---- see RQ1_queries.sql


-- 24. TRENDS_PYTHON
---- RQ1: Post trends per progr.lang. per month  (See paper, table 1.3)
---- NOTE: 
---- see RQ1_queries.sql


-- 25. TRENDS_TOTAL
---- RQ1: Post trends per progr.lang. per month  (See paper, table 1.3)
---- NOTE: 
---- see RQ1_queries.sql


-- ######################################################################################
-- ######################################################################################
-- VIEWS
-- ######################################################################################
-- ######################################################################################
/* OVERVIEW - SQL Developer Views 

   *01 vw_all_posts
   *02 vw_ans
   *03 vw_noans
   *04 vw_tags_cat
   *05 vw_tags_cat_ans
   *06 vw_tags_cat_ans_pos_score
   *07 vw_tags_cat_noans
   *08 vw_tags_cat_noans_pos_score
*/

-- 01. VIEW NAME: vw_all_posts
-- note: change posts_noans ACCEPTEDANSWERID column type to NUMBER instead of varchar2
create or replace view vw_all_posts as
select * from posts_ans
union 
select * from posts_noans;


-- 02. VIEW NAME: vw_ans
-- All opencv posts with answers, with a score >= 0
create or replace view vw_ans as
select * from posts_ans where score >= 0;


-- 03. VIEW NAME: vw_noans
-- All opencv posts with NO answers, with a score >= 0
create or replace view vw_noans as
select * from posts_ans where score >= 0;


-- CATEGORY DISTRIBUTIONS
--////////////////////////////////////////////////////////

-- 04. VIEW NAME: vw_tags_cat
-- out of the 183 tags, this is the division in categories
create or replace view vw_tags_cat as
select cat.id
,      cat.cat_name
,      count(tag.id)       "Tag Keywords"
,      sum(tag.tag_count)  "Instances" 
from      tags       tag
left join categories cat on tag.tag_cat_id = cat.id
group by  cat.id, cat.cat_name
order by 1;

-- 05. VIEW NAME: vw_tags_cat_ans
-- Check which categories have answers (all)
create or replace view vw_tags_cat_ans as
select cat.id
,      cat.cat_name
,      count(taa.name)       "Tag Keywords"
,      sum(taa.count)  "Instances" 
from      tags       tag
left join categories     cat on tag.tag_cat_id = cat.id
left join tags_ans_all   taa on taa.name       = tag.tag_name
group by  cat.id, cat.cat_name
order by 1;

-- 06. VIEW NAME: vw_tags_cat_ans_pos_score
-- Check which categories have answers (score > 0)
create or replace view vw_tags_cat_ans_pos_score as
select cat.id
,      cat.cat_name
,      count(taa.name)       "Tag Keywords"
,      sum(taa.count)  "Instances" 
from      tags       tag
left join categories     cat on tag.tag_cat_id = cat.id
left join tags_ans_all_pos_score   taa on taa.name       = tag.tag_name
group by  cat.id, cat.cat_name
order by 1;

-- 07. VIEW NAME: vw_tags_cat_noans
-- Check which categories have NO answers (all)
create or replace view vw_tags_cat_noans as
select cat.id
,      cat.cat_name
,      count(taa.name)       "Tag Keywords"
,      sum(taa.count)  "Instances" 
from      tags       tag
left join categories     cat on tag.tag_cat_id = cat.id
left join tags_noans_all   taa on taa.name       = tag.tag_name
group by  cat.id, cat.cat_name
order by 1;

-- 08. VIEW NAME: vw_tags_cat_noans_pos_score
-- Check which categories have NO answers (score > 0)
create or replace view vw_tags_cat_noans_pos_score as
select cat.id
,      cat.cat_name
,      count(taa.name)       "Tag Keywords"
,      sum(taa.count)  "Instances" 
from      tags       tag
left join categories     cat on tag.tag_cat_id = cat.id
left join tags_noans_all_pos_score   taa on taa.name       = tag.tag_name
group by  cat.id, cat.cat_name
order by 1;

