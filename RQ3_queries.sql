-- Code for the paper "OpenCV on Stack Overflow: A Study on Developer Discussions"
-- Darey-Ann Louisville
-- ______________________________________________________________________________________
-- 06 june 2021

-- ######################################################################################
-- ######################################################################################
-- RQ3: Which topics are most difficult to answer?
-- ######################################################################################
-- ######################################################################################

-- OVERVIEW
-------------
-- 01. topic classsification
-- 02. topic difficulty analysis
--     * comparison dataset (attributes + KS test)
-- ______________________________________________________________________________________





-----------------------------------------------------------------------------------------
-- 01.A Topic Classification
-----------------------------------------------------------------------------------------

-- 1. //////////////////////////////////////////////////////
-- First, he OpenCV post tags were classified manually
-- 183 tags were categorized into 7 categories
-- see OpenCV_tables_views.xlsb - C##OPENCV.CATEGORIES and C##OPENCV.TAGS tabs
-- each of the 183 tags from the opencv_tags table was assigned a category ID from C##OPENCV.CATEGORIES

/* C##OPENCV.CATEGORIES (as seen in OpenCV_tables_views.xlsb):

ID	CAT_NAME	            CAT_DESCRIPTION
1	programming language	Programming languages e.g. C++, C, Python, Java etc.
2	library/framework	    API's, libraries and web application frameworks. e.g.  opencv, jquery, .Net, Keras,
3	software/environment	Operating systems, IDE's and other software, e.g. iOS, Windows, Tensorflow
4	domain	                Subjects of the computer program, e.g. computer vision, topic modelling
5	non-functional	        Judges operation of a system, e.g. multithreading
6	method/technique	    specific algorithms for implementation, e.g. hough-transform, haar-classifier
7	attributes	            Attributes and functions, e.g. image, camera, webcam, rgb, user-interface
*/

-- 2. //////////////////////////////////////////////////////
-- After classifying the topics individually, each post from POSTS_ANSWER_INTERVALS (see 01_SEDE_queries.sql) needed to be classified
-- Some posts can have multiple topics, e.g. programming language and library/framework


----- get amount of unique posts per tag category
-- (so no duplicate instances of posts that have multiuple tags in 1 category)
select * from tags;
-- posts per category
select listagg('<'||tag_name||'>',',') prog_lang from tags
where tag_cat_id = 1; -- etc

-----------------------------------------------------------------------------------------
-- 01.B NOW WE'LL BUILD A QUERY USING SELECT STATEMENTS
-----------------------------------------------------------------------------------------
-- (These queries will select which posts belong to which categories)

-- 1. //////////////////////////////////////////////////////
-- BASE QUERY
select count(distinct id)
from
(select * from vw_ans
union
select * from vw_noans)
where -- paste the generated clauses here. don't forget to remove the first "or"

-- 2. //////////////////////////////////////////////////////
-- WHERE CLAUSE BUILD 
-- (TO COPY AND PASTE after the BASE QUERY) 

-- EXAMPLE:
----------------------------------
--  programming language
select 'or instr(tags,''<'||tag_name||'>'') > 0' prog_lang from tags
where tag_cat_id = 1;
-- 44228

-- for example, with the above, our full query becomes:
select count(distinct id)
from
(select * from vw_ans
union
select * from vw_noans)
where instr(tags,'<python>') > 0
or instr(tags,'<c++>') > 0
or instr(tags,'<java>') > 0
or instr(tags,'<python-3.x>') > 0
or instr(tags,'<c>') > 0
or instr(tags,'<c#>') > 0
or instr(tags,'<python-2.7>') > 0
or instr(tags,'<objective-c>') > 0
or instr(tags,'<javascript>') > 0
or instr(tags,'<c++11>') > 0
or instr(tags,'<xml>') > 0
or instr(tags,'<swift>') > 0
or instr(tags,'<matlab>') > 0;
----------------------------------

-- do the same for the rest of the categories   (WHERE clause queries below)

select 'or instr(tags,''<'||tag_name||'>'') > 0' lib_framw from tags
where tag_cat_id = 2;
-- 60832


select 'or instr(tags,''<'||tag_name||'>'') > 0' softw_env from tags
where tag_cat_id = 3;
-- 16257



select 'or instr(tags,''<'||tag_name||'>'') > 0' domain from tags
where tag_cat_id = 4;
-- 21984


select 'or instr(tags,''<'||tag_name||'>'') > 0' non_funct from tags
where tag_cat_id = 5;
-- 1756


select 'or instr(tags,''<'||tag_name||'>'') > 0' meth_techn from tags
where tag_cat_id = 6;
-- 2206


select 'or instr(tags,''<'||tag_name||'>'') > 0' attr from tags
where tag_cat_id = 7;
-- 7177


-----------------------------------------------------------------------------------------
-- 02.A Topic Difficulty Analysis - difficulty of OpenCV topics (ref: Bagherzadeh)
-----------------------------------------------------------------------------------------

-- after each TAG was assigned individually, analyses could be done on each openCV POST
----- queries for new table/ figure ref: "Going Big: A Large-Scale Study on What Big Data Developers Ask" - Bagherzadeh table 4

/*
    do not run the entire from dual queries (SQL dev crashes)
    split each query into parts (collect each column separately)

----------------------------------------------------------------------------------
 This part groups each OpenCV post tag into a topic. 
 This could not be done in SEDE, because the topics were created manually and 
 the tags added to the posts also needed to be separated with regular expressions, 
  because they're stored as a single string with: '<tag1><tag2><tag3>' etc.
*/

-- separate queries for use after with clause:

select count(id) total_distinct_posts
from   topic;

--
select count(id)  accepted_answer
from   topic 
where  acceptedanswerid is not null ;

--
select count(id) no_accepted_answer
from   topic 
where  acceptedanswerid is null and answercount != 0;
    
--    
select count(id) no_answer
from   topic 
where  answercount = 0;
    
--    
select round(avg(minutes_until_answer)/60,1)  hrs_to_acc_answer
from   POSTS_ANSWER_INTERVALS
where  minutes_until_answer is not null
and    POST_SCORE >= 0  
and    post_id in (select id from topic) ;       

--
select round(median(minutes_until_answer)/60,1) median_hrs_to_acc_answer
from   POSTS_ANSWER_INTERVALS
where  minutes_until_answer is not null
and    POST_SCORE >= 0  
and    post_id in (select id from topic)   ;     
 

-- ALL TOPIC CLASSIFICATIONS USING POSTS_ANSWER_INTERVALS POSTS:

--1
with topic as
(select distinct id, acceptedanswerid, answercount, viewcount, favoritecount, score 
       from
       (select * from vw_ans
       union
       select * from vw_noans)
       where instr(tags,'<python>') > 0
       or instr(tags,'<c++>') > 0
       or instr(tags,'<java>') > 0
       or instr(tags,'<python-3.x>') > 0
       or instr(tags,'<c>') > 0
       or instr(tags,'<c#>') > 0
       or instr(tags,'<python-2.7>') > 0
       or instr(tags,'<objective-c>') > 0
       or instr(tags,'<javascript>') > 0
       or instr(tags,'<c++11>') > 0
       or instr(tags,'<xml>') > 0
       or instr(tags,'<swift>') > 0
       or instr(tags,'<matlab>') > 0
)
select 'programming language'                       topic
,      (select count(id)
        from   topic)                               total_distinct_posts
,      (select count(id)
        from   topic 
        where  acceptedanswerid is not null)            accepted_answer
,      (select count(id)
        from   topic 
        where  acceptedanswerid is null and answercount != 0)            no_accepted_answer
,      (select count(id)
        from   topic 
        where  answercount = 0)                     no_answer
,      (select round(avg(minutes_until_answer)/60,1)
        from   POSTS_ANSWER_INTERVALS
        where  minutes_until_answer is not null
        and    POST_SCORE >= 0  
        and    post_id in (select id from topic)        
        )                                          hrs_to_acc_answer
  ,      (select round(median(minutes_until_answer)/60,1)
        from   POSTS_ANSWER_INTERVALS
        where  minutes_until_answer is not null
        and    POST_SCORE >= 0  
        and    post_id in (select id from topic)        
        )                                          median_hrs_to_acc_answer
 from dual;      


--2
with topic as
(select distinct id, acceptedanswerid, answercount, viewcount, favoritecount, score 
       from
       (select * from vw_ans
       union
       select * from vw_noans)
       where instr(tags,'<numpy>') > 0
       or instr(tags,'<opencv3.0>') > 0
       or instr(tags,'<opencv-python>') > 0
       or instr(tags,'<cv2>') > 0
       or instr(tags,'<javacv>') > 0
       or instr(tags,'<python-imaging-library>') > 0
       or instr(tags,'<opencv-contour>') > 0
       or instr(tags,'<matplotlib>') > 0
       or instr(tags,'<opencv3.1>') > 0
       or instr(tags,'<scikit-image>') > 0
       or instr(tags,'<opencv4>') > 0
       or instr(tags,'<scikit-learn>') > 0
       or instr(tags,'<opencv>') > 0
       or instr(tags,'<java-native-interface>') > 0
       or instr(tags,'<gstreamer>') > 0
       or instr(tags,'<dlib>') > 0
       or instr(tags,'<opencl>') > 0
       or instr(tags,'<dll>') > 0
       or instr(tags,'<flask>') > 0
       or instr(tags,'<aruco>') > 0
       or instr(tags,'<rtsp>') > 0
       or instr(tags,'<scipy>') > 0
       or instr(tags,'<math>') > 0
       or instr(tags,'<django>') > 0
       or instr(tags,'<caffe>') > 0
       or instr(tags,'<boost>') > 0
       or instr(tags,'<keras>') > 0
       or instr(tags,'<.net>') > 0
       or instr(tags,'<tensorflow>') > 0
       or instr(tags,'<opengl>') > 0
       or instr(tags,'<mat>') > 0
       or instr(tags,'<openni>') > 0
)
select 'library/framework'                          topic
,      (select count(id)
        from   topic)                               total_distinct_posts
,      (select count(id)
        from   topic 
        where  acceptedanswerid is not null)            accepted_answer
,      (select count(id)
        from   topic 
        where  acceptedanswerid is null and answercount != 0)            no_accepted_answer
,      (select count(id)
        from   topic 
        where  answercount = 0)                     no_answer
,      (select round(avg(minutes_until_answer)/60,1)
        from   POSTS_ANSWER_INTERVALS
        where  minutes_until_answer is not null
        and    POST_SCORE >= 0  
        and    post_id in (select id from topic)        
        )                                          hrs_to_acc_answer
  ,      (select round(median(minutes_until_answer)/60,1)
        from   POSTS_ANSWER_INTERVALS
        where  minutes_until_answer is not null
        and    POST_SCORE >= 0  
        and    post_id in (select id from topic)        
        )                                          median_hrs_to_acc_answer
 from dual; 


-- 3
with topic as
(select distinct id, acceptedanswerid, answercount, viewcount, favoritecount, score 
       from
       (select * from vw_ans
       union
       select * from vw_noans)
       where instr(tags,'<ffmpeg>') > 0
       or instr(tags,'<opencv4android>') > 0
       or instr(tags,'<pycharm>') > 0
       or instr(tags,'<android>') > 0
       or instr(tags,'<windows>') > 0
       or instr(tags,'<visual-c++>') > 0
       or instr(tags,'<visual-studio-2010>') > 0
       or instr(tags,'<visual-studio>') > 0
       or instr(tags,'<eclipse>') > 0
       or instr(tags,'<svm>') > 0
       or instr(tags,'<android-studio>') > 0
       or instr(tags,'<anaconda>') > 0
       or instr(tags,'<iphone>') > 0
       or instr(tags,'<visual-studio-2012>') > 0
       or instr(tags,'<visual-studio-2013>') > 0
       or instr(tags,'<visual-studio-2015>') > 0
       or instr(tags,'<jupyter-notebook>') > 0
       or instr(tags,'<cmake>') > 0
       or instr(tags,'<qt>') > 0
       or instr(tags,'<ios>') > 0
       or instr(tags,'<emgucv>') > 0
       or instr(tags,'<linux>') > 0
       or instr(tags,'<macos>') > 0
       or instr(tags,'<ubuntu>') > 0
       or instr(tags,'<raspberry-pi>') > 0
       or instr(tags,'<android-ndk>') > 0
       or instr(tags,'<xcode>') > 0
       or instr(tags,'<cuda>') > 0
       or instr(tags,'<python-tesseract>') > 0
       or instr(tags,'<ros>') > 0
       or instr(tags,'<tkinter>') > 0
       or instr(tags,'<makefile>') > 0
       or instr(tags,'<opencvsharp>') > 0
       or instr(tags,'<node.js>') > 0
       or instr(tags,'<raspberry-pi3>') > 0
       or instr(tags,'<orb>') > 0
       or instr(tags,'<unity3d>') > 0
       or instr(tags,'<mingw>') > 0
       or instr(tags,'<g++>') > 0
       or instr(tags,'<pip>') > 0
       or instr(tags,'<gcc>') > 0
       or instr(tags,'<docker>') > 0
       or instr(tags,'<qt-creator>') > 0
       or instr(tags,'<codeblocks>') > 0
       or instr(tags,'<homebrew>') > 0
)
select 'software/environment'                       topic
,      (select count(id)
        from   topic)                               total_distinct_posts
,      (select count(id)
        from   topic 
        where  acceptedanswerid is not null)            accepted_answer
,      (select count(id)
        from   topic 
        where  acceptedanswerid is null and answercount != 0)            no_accepted_answer
,      (select count(id)
        from   topic 
        where  answercount = 0)                     no_answer
,      (select round(avg(minutes_until_answer)/60,1)
        from   POSTS_ANSWER_INTERVALS
        where  minutes_until_answer is not null
        and    POST_SCORE >= 0  
        and    post_id in (select id from topic)        
        )                                          hrs_to_acc_answer
  ,      (select round(median(minutes_until_answer)/60,1)
        from   POSTS_ANSWER_INTERVALS
        where  minutes_until_answer is not null
        and    POST_SCORE >= 0  
        and    post_id in (select id from topic)        
        )                                          median_hrs_to_acc_answer
 from dual; 
 
 
 -- 4
with topic as
(select distinct id, acceptedanswerid, answercount, viewcount, favoritecount, score 
       from
       (select * from vw_ans
       union
       select * from vw_noans)
       where instr(tags,'<image-processing>') > 0
       or instr(tags,'<computer-vision>') > 0
       or instr(tags,'<image>') > 0
       or instr(tags,'<video>') > 0
       or instr(tags,'<camera>') > 0
       or instr(tags,'<object-detection>') > 0
       or instr(tags,'<camera-calibration>') > 0
       or instr(tags,'<machine-learning>') > 0
       or instr(tags,'<ocr>') > 0
       or instr(tags,'<face-recognition>') > 0
       or instr(tags,'<face-detection>') > 0
       or instr(tags,'<video-capture>') > 0
       or instr(tags,'<feature-detection>') > 0
       or instr(tags,'<image-segmentation>') > 0
       or instr(tags,'<video-processing>') > 0
       or instr(tags,'<detection>') > 0
       or instr(tags,'<edge-detection>') > 0
       or instr(tags,'<deep-learning>') > 0
       or instr(tags,'<image-recognition>') > 0
       or instr(tags,'<video-streaming>') > 0
       or instr(tags,'<feature-extraction>') > 0
       or instr(tags,'<opticalflow>') > 0
       or instr(tags,'<background-subtraction>') > 0
       or instr(tags,'<template-matching>') > 0
       or instr(tags,'<image-stitching>') > 0
       or instr(tags,'<neural-network>') > 0
       or instr(tags,'<augmented-reality>') > 0
       or instr(tags,'<rotation>') > 0
       or instr(tags,'<classification>') > 0
       or instr(tags,'<pose-estimation>') > 0
       or instr(tags,'<vision>') > 0
       or instr(tags,'<motion-detection>') > 0
       or instr(tags,'<disparity-mapping>') > 0
       or instr(tags,'<object-recognition>') > 0
       or instr(tags,'<artificial-intelligence>') > 0
       or instr(tags,'<tracking>') > 0
       or instr(tags,'<3d-reconstruction>') > 0
       or instr(tags,'<calibration>') > 0
       or instr(tags,'<optimization>') > 0
)
select 'domain'                       topic
,      (select count(id)
        from   topic)                               total_distinct_posts
,      (select count(id)
        from   topic 
        where  acceptedanswerid is not null)            accepted_answer
,      (select count(id)
        from   topic 
        where  acceptedanswerid is null and answercount != 0)            no_accepted_answer
,      (select count(id)
        from   topic 
        where  answercount = 0)                     no_answer
,      (select round(avg(minutes_until_answer)/60,1)
        from   POSTS_ANSWER_INTERVALS
        where  minutes_until_answer is not null
        and    POST_SCORE >= 0  
        and    post_id in (select id from topic)        
        )                                          hrs_to_acc_answer
  ,      (select round(median(minutes_until_answer)/60,1)
        from   POSTS_ANSWER_INTERVALS
        where  minutes_until_answer is not null
        and    POST_SCORE >= 0  
        and    post_id in (select id from topic)        
        )                                          median_hrs_to_acc_answer
 from dual;  
 
 
  -- 5
with topic as
(select distinct id, acceptedanswerid, answercount, viewcount, favoritecount, score 
       from
       (select * from vw_ans
       union
       select * from vw_noans)
       where instr(tags,'<multithreading>') > 0
       or instr(tags,'<gpu>') > 0
       or instr(tags,'<performance>') > 0
       or instr(tags,'<installation>') > 0
       or instr(tags,'<compilation>') > 0
       or instr(tags,'<memory-leaks>') > 0
       or instr(tags,'<compiler-errors>') > 0
       or instr(tags,'<user-interface>') > 0
       or instr(tags,'<threshold>') > 0
       or instr(tags,'<segmentation-fault>') > 0
)
select 'non-functional'                       topic
,      (select count(id)
        from   topic)                               total_distinct_posts
,      (select count(id)
        from   topic 
        where  acceptedanswerid is not null)            accepted_answer
,      (select count(id)
        from   topic 
        where  acceptedanswerid is null and answercount != 0)            no_accepted_answer
,      (select count(id)
        from   topic 
        where  answercount = 0)                     no_answer
,      (select round(avg(minutes_until_answer)/60,1)
        from   POSTS_ANSWER_INTERVALS
        where  minutes_until_answer is not null
        and    POST_SCORE >= 0  
        and    post_id in (select id from topic)        
        )                                          hrs_to_acc_answer
  ,      (select round(median(minutes_until_answer)/60,1)
        from   POSTS_ANSWER_INTERVALS
        where  minutes_until_answer is not null
        and    POST_SCORE >= 0  
        and    post_id in (select id from topic)        
        )                                          median_hrs_to_acc_answer
 from dual;  
 
 
  -- 6
with topic as
(select distinct id, acceptedanswerid, answercount, viewcount, favoritecount, score 
       from
       (select * from vw_ans
       union
       select * from vw_noans)
       where instr(tags,'<hough-transform>') > 0
       or instr(tags,'<sift>') > 0
       or instr(tags,'<haar-classifier>') > 0
       or instr(tags,'<yolo>') > 0
       or instr(tags,'<canny-operator>') > 0
       or instr(tags,'<cascade-classifier>') > 0
       or instr(tags,'<k-means>') > 0
       or instr(tags,'<opencv-stitching>') > 0
       or instr(tags,'<fft>') > 0
       or instr(tags,'<surf>') > 0
)
select 'method/technique'                       topic
,      (select count(id)
        from   topic)                               total_distinct_posts
,      (select count(id)
        from   topic 
        where  acceptedanswerid is not null)            accepted_answer
,      (select count(id)
        from   topic 
        where  acceptedanswerid is null and answercount != 0)            no_accepted_answer
,      (select count(id)
        from   topic 
        where  answercount = 0)                     no_answer
,      (select round(avg(minutes_until_answer)/60,1)
        from   POSTS_ANSWER_INTERVALS
        where  minutes_until_answer is not null
        and    POST_SCORE >= 0  
        and    post_id in (select id from topic)        
        )                                          hrs_to_acc_answer
  ,      (select round(median(minutes_until_answer)/60,1)
        from   POSTS_ANSWER_INTERVALS
        where  minutes_until_answer is not null
        and    POST_SCORE >= 0  
        and    post_id in (select id from topic)        
        )                                          median_hrs_to_acc_answer
 from dual;  
 
 
  -- 7
with topic as
(select distinct id, acceptedanswerid, answercount, viewcount, favoritecount, score 
       from
       (select * from vw_ans
       union
       select * from vw_noans)
       where instr(tags,'<matrix>') > 0
       or instr(tags,'<contour>') > 0
       or instr(tags,'<webcam>') > 0
       or instr(tags,'<tesseract>') > 0
       or instr(tags,'<algorithm>') > 0
       or instr(tags,'<colors>') > 0
       or instr(tags,'<arrays>') > 0
       or instr(tags,'<vector>') > 0
       or instr(tags,'<homography>') > 0
       or instr(tags,'<histogram>') > 0
       or instr(tags,'<geometry>') > 0
       or instr(tags,'<rgb>') > 0
       or instr(tags,'<hsv>') > 0
       or instr(tags,'<pixel>') > 0
       or instr(tags,'<bitmap>') > 0
       or instr(tags,'<mask>') > 0
       or instr(tags,'<linker>') > 0
       or instr(tags,'<iplimage>') > 0
       or instr(tags,'<crop>') > 0
       or instr(tags,'<build>') > 0
       or instr(tags,'<ip-camera>') > 0
       or instr(tags,'<android-camera>') > 0
       or instr(tags,'<sockets>') > 0
       or instr(tags,'<bounding-box>') > 0
       or instr(tags,'<graphics>') > 0
       or instr(tags,'<imshow>') > 0
       or instr(tags,'<pointers>') > 0
       or instr(tags,'<imread>') > 0
       or instr(tags,'<blob>') > 0
       or instr(tags,'<grayscale>') > 0
       or instr(tags,'<stereo-3d>') > 0
       or instr(tags,'<kinect>') > 0
       or instr(tags,'<3d>') > 0
       or instr(tags,'<roi>') > 0
)
select 'attributes'                       topic
,      (select count(id)
        from   topic)                               total_distinct_posts
,      (select count(id)
        from   topic 
        where  acceptedanswerid is not null)            accepted_answer
,      (select count(id)
        from   topic 
        where  acceptedanswerid is null and answercount != 0)            no_accepted_answer
,      (select count(id)
        from   topic 
        where  answercount = 0)                     no_answer
,      (select round(avg(minutes_until_answer)/60,1)
        from   POSTS_ANSWER_INTERVALS
        where  minutes_until_answer is not null
        and    POST_SCORE >= 0  
        and    post_id in (select id from topic)        
        )                                          hrs_to_acc_answer
 ,      (select round(median(minutes_until_answer)/60,1)
        from   POSTS_ANSWER_INTERVALS
        where  minutes_until_answer is not null
        and    POST_SCORE >= 0  
        and    post_id in (select id from topic)        
        )                                          median_hrs_to_acc_answer
 from dual;  
 
 
 
-----------------------------------------------------------------------------------------
-- 02.B Topic Difficulty Analysis - popularity of OpenCV topics (ref: Bagherzadeh)
-----------------------------------------------------------------------------------------

-- to all 7 with-clauses (from the previous section), also add:
select round(avg(viewcount),1)        avg_views
,      round(avg(favoritecount),1)    avg_favorites
,      round(avg(answercount),1)      avg_answers
,      round(avg(score),1)            avg_score
from topic;

/* IMPORTANT NOTE!
   post with title "Opencv MPEG7 descriptors" has and accepted answer id (ACCEPTEDANSWERID = 1011958) but no time interval!!!
   Thus this cannot be analyzed in RQ3. 
   So for all queries, diregard where title = 'Opencv MPEG7 descriptors'
*/

-- 6 JUNI 2021
-- clean this up in the tables:
update posts_ans
set ACCEPTEDANSWERID = null 
where id = 882521; -- (ID = 882521 where ACCEPTEDANSWERID = 1011958


/* never quit, without a */ commit;



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- 02.C Difficulty metrics analysis queries
-----------------------------------------------------------------------------------------

-- all opencv posts with score >= 0: 61,120 posts
select count(*) from (select * from vw_ans union select * from vw_noans) 
-- 61120

-- 1. % of questions with no accepted answers
  -- data set (select * from vw_ans union select * from vw_noans)
  -- 36,498 posts
  select count(*)
  from (select * from vw_ans union select * from vw_noans)
  where acceptedanswerid is null

  -- to get the percentage : 59.72% has no ACCEPTED answer
  select round(
  ((select count(*) from (select * from vw_ans union select * from vw_noans) where acceptedanswerid is null)/
   (select count(*) from (select * from vw_ans union select * from vw_noans) ))*100,2) perc
  from dual


-- 2. % of questions with no answers AT ALL
  -- data set (select * from vw_ans union select * from vw_noans)
  -- 15,849 posts
  select count(*)
  from (select * from vw_ans union select * from vw_noans)
  where nvl(answercount,0) = 0 

  -- to get the percentage : 25.93% has no answer AT ALL
  select round(
  ((select count(*) from (select * from vw_ans union select * from vw_noans) where  nvl(answercount,0) = 0 )/
   (select count(*) from (select * from vw_ans union select * from vw_noans) ))*100,2) perc
  from dual
  
  
----------  
-- COMP_DATA IS ONLY FOR SUCCESSFUL POSTS WITH ACCEPTED ANSWERS

-- ONLY USE THESE DATASETS FOR COMPARISON: 
-- (both have 24,621 posts)

-- 1 Comparison dataset
select count(*)
from COMP_DATA;

-- 2 OpenCV dataset
select count(*)
from   POSTS_ANSWER_INTERVALS
where minutes_until_answer is not null
and   POST_SCORE >= 0;

-- averages

-- compdata
select round(avg(POST_VIEWCOUNT)) comp_data_avg_viewcount
from comp_data;

select round(avg(POST_ANSWERCOUNT)) comp_data_avg_answercount
from comp_data;

select round(avg(MINUTES_UNTIL_ANSWER),2) comp_data_avg_minutes_until_answer
from comp_data;
-- median = 30

-- opencv
select round(avg(POST_VIEWCOUNT)) opencv_avg_viewcount
from 
(select *
from   POSTS_ANSWER_INTERVALS
where minutes_until_answer is not null
and   POST_SCORE >= 0);

select round(avg(POST_ANSWERCOUNT)) opencv_avg_answercount
from 
(select *
from   POSTS_ANSWER_INTERVALS
where minutes_until_answer is not null
and   POST_SCORE >= 0);

select round(avg(MINUTES_UNTIL_ANSWER),2) opencv_avg_minutes_until_answer
from 
(select *
from   POSTS_ANSWER_INTERVALS
where minutes_until_answer is not null
and   POST_SCORE >= 0);
-- median = 192 min = 3.2 hrs


/* AVERAGES - of successful posts with accepted answers
COMP_DATA_AVG_VIEWCOUNT
-----------------------
                   8829


COMP_DATA_AVG_ANSWERCOUNT
-------------------------
                        2


COMP_DATA_AVG_MINUTES_UNTIL_ANSWER
----------------------------------
                          17818.03


OPENCV_AVG_VIEWCOUNT
--------------------
                4162


OPENCV_AVG_ANSWERCOUNT
----------------------
                     2


OPENCV_AVG_MINUTES_UNTIL_ANSWER
-------------------------------
                        24618.5


*/

-- For KS test, use 1% of the amount, so sample size for both = 247


-----------------------------------------------------------------------------------------
-- 02.D KOLMOGOROV-SMIRNOV TEST WITH SAMPLE SIZE N=247
-----------------------------------------------------------------------------------------
-- listagg lists used for KS TEST - OpenCV.ipynb

-- ///////// TIME INTERVAL COMPARISON

-- comp 1% random sample
select listagg(MINUTES_UNTIL_ANSWER,',') 
from 
(select *
 from COMP_DATA
 order by dbms_random.value
)
where rownum <= 247;
-- paste this for comparison set:
-- 762686,5,2,13,5,4,292,7,3067,5,354,135,62,5,2,5,4,4,28270,1328,25,646,10,11,4537,162,5,299,28,6,994,249,43,45002,170,6,1164,6,92,25,46,169,470,9,12,3,7,7,31498,6,10,11,15354,43,6,185,29,459,29,2318,7,734,2,28,42,10,13,22194,13436,9,32,12,7,5,8,1,204,3141,18,8,40,5,21,4,91,40,3,7,11,909,61670,1233,60,21,70318,78,49091,11,49,47,17,417,31,88,19,10449,1280,35,90,211,4,4,17893,4,8,7,447,24,27,4214,117,32,11,8,30096,10,20,2806,40,6,34,42986,9,805,22,39107,62,397,507046,173,183,19517,1,0,5,4,70,18926,1668,1527,8,8,5,122,8,15,13312,10,58,10,890,9,55,44,31,7381,24,3243,28,4230,6,27,4,28,1127,2721,28,82,3,71306,7,3,38,88409,33,447,421,10,27,16,42,1234,8,2,568,9,80647,1623,4,1,322,85,5,5,72,3,197,78,90,45,2,8,244,121,1813,4070,1350,5,12,130,15,3,9,173,322517,30,51,9,121396,29,4,21,3,3,528,10,3,67,175,5,1552152,755,784,1532,210,3501,6

-- opencv 1% random sample
select listagg(MINUTES_UNTIL_ANSWER,',') 
from 
(select *
 from   POSTS_ANSWER_INTERVALS
 where minutes_until_answer is not null
 and   POST_SCORE >= 0
 order by dbms_random.value
)
where rownum <= 247;
-- paste this for openCV set:
-- 56,214,1146,104,589,188121,27,8767,7,44,1237,14,1950,5,1505,1184,156,14,197,2850,91,618,20,400,261812,369,373,38,269,29,59,119,31,22,4,1742,23,178,33,1804,238,87,14,363,9,1170,191566,29,1396,135,326,21,20,58,165,18,19,119,3901,374,958,117,113,24,43072,584,31743,8782,759,482,29,6,1990,75,153,28,462,239,98,14,1515,407,12745,17,996,53,371,43,16,10,41,1669,54492,26,137,73,338,836896,56,136,195,50,362,483,3272,14,195,99,143,21,653,162,172398,949,375,742,1979,345,2531,5,2803,82089,6,234,1133,18669,489,106,50,6,9,4,101,31,458,2552,52,2206,1494,7688,1308,39,603,7128,2509,20207,941,12663,44,52,101,9025,488,298403,47,677,313784,52349,290750,531,10,1392,41,11608,17,13,1008,47,10,210,20611,2468,124,96552,213,455,1493,1510,2440,6981,697,2094,6,10572,4499,160943,166,4,1055,10,41,663,117,12,71,40,39,14,31,9,298,725672,6,32,7,1052,1063,28,517,419,12,16294,69,210,6,77,458,21,1,27,25,9,19,202,23,7,2373,56,1099,27,35,164,598,749,1013,99,482,125,6,752541,69886,54,42,15678,14,98,301

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
