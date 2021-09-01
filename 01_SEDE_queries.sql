-- Code for the paper "OpenCV on Stack Overflow: A Study on Developer Discussions"
-- Darey-Ann Louisville
-- ######################################################################################

-- 1st step: Data Collection

-- Stack Exchange Data Explorer (SEDE) QUERIES
-- (https://data.stackexchange.com/stackoverflow/query/new) 
-- ######################################################################################
-- 01 May 2021
----------------------------------------------------------------------------------------

-- ######################################################################################
-- Below queries were run on SEDE and then exported as CSV's. 
-- These were then imported into SQL developer as tables or refined in Excel.
-- ######################################################################################


-- OVERVIEW
-------------
-- * General
--     * Answered and unanswered posts (POSTS_ANS, POSTS_NOANS)
-- * RQ1
--     1. Post trends
--     2. Tag trends
--     3. Location trends
-- * RQ2 - see RQ2_queries.sql
-- * RQ3
--     * Post difficulty data (POSTS_ANSWER_INTERVALS)
--     * All tags used in OpenCV posts (TAGS)
--     * Comparison dataset: non-OpenCV posts (COMP_DATA)
-- ______________________________________________________________________________________



--***************************************************************************************
-- General
--***************************************************************************************

-- Answered and unanswered posts
------------------------------------------------------

-- * Answered OpenCV posts
-- SQL table name: POSTS_ANS
select p."Id"
,      p."Title"
--,      p."Body"
,      p."Tags"
,      p."Score"
,      p."ViewCount"
,      p."AnswerCount"
,      p."CommentCount"
,      p."FavoriteCount"
,      p."PostTypeId"
,      pt."Name"   "PostType"
,      p."AcceptedAnswerId"
,      p."ParentId"
,      p."OwnerUserId"
,      p."OwnerDisplayName"
,      p."LastEditorUserId"
,      p."LastEditorDisplayName"
,      p."LastEditDate"
,      p."LastActivityDate"
,      p."CommunityOwnedDate"
,      p."CreationDate"
,      p."DeletionDate"
,      p."ClosedDate"
,      p."ContentLicense"
from  Posts p
left outer join PostTypes pt on p."PostTypeId" = pt."Id"
where lower("Tags") like '%open%cv%'
and p."AnswerCount" > 0
order by p."ViewCount", p."CommentCount", p."AnswerCount" desc;

-- * Unanswered OpenCV posts
-- SQL table name: POSTS_NOANS
-- Same as above, but with:
and p."AnswerCount" = 0


--***************************************************************************************
-- RQ1: OpenCV trends
--***************************************************************************************

-- 1) Post trends 
------------------------------------------------------
-- saved SEDE query results into one file to import into SQL Developer

-- * post trends per year
-- graphed in Excel
select format("CreationDate",'yyyy') "CreationYear"
,      count("CreationDate")         "Count"
from Posts
where lower("Tags") like '%open%cv%'
group by format("CreationDate",'yyyy')
order by convert(datetime,format("CreationDate",'yyyy')) 

-- * post trends per month (graphed in excel)
-- SQL table name: TRENDS_TOTAL 
select format("CreationDate",'yyyy-MM') creationdate
,       count("CreationDate")            posts
from  Posts
where lower("Tags") like '%open%cv%'
and   "CreationDate" < convert(datetime,format(GETDATE(),'yyyy-MM-01'))
group by format("CreationDate",'yyyy-MM')
     
-- * post trends per programming language
------------------------------------------------------ 
-- Note: retrieved separately for each language because 8 left joins caused a timeout on SEDE
-- Combined afterwards to analyze in Excel
/*
TABLE NAME: TRENDS_PYTHON
-- ***************************************
*/ 
select format("CreationDate",'yyyy-MM') creationdate
,      count("CreationDate")            posts
from  Posts
where (lower("Tags") like '%open%cv%' and lower("Tags") like '%<python%>%')
and   "CreationDate" < convert(datetime,format(GETDATE(),'yyyy-MM-01'))
group by format("CreationDate",'yyyy-MM')
 
/*
TABLE NAME: TRENDS_CPP
-- ***************************************
*/ 
select format("CreationDate",'yyyy-MM') creationdate
,      count("CreationDate")            posts
from   Posts
where (lower("Tags") like '%open%cv%' and lower("Tags") like '%<c++%>%')
and   "CreationDate" < convert(datetime,format(GETDATE(),'yyyy-MM-01'))
group by format("CreationDate",'yyyy-MM')     
     
/*
TABLE NAME: TRENDS_C
-- ***************************************
*/     
select format("CreationDate",'yyyy-MM') creationdate
,      count("CreationDate")            posts
from   Posts
where (lower("Tags") like '%open%cv%' and lower("Tags") like '%<c>%')
and   "CreationDate" < convert(datetime,format(GETDATE(),'yyyy-MM-01'))
group by format("CreationDate",'yyyy-MM')

/*
TABLE NAME: TRENDS_C#
-- ***************************************
*/
select format("CreationDate",'yyyy-MM') creationdate
,      count("CreationDate")            posts
from   Posts
where (lower("Tags") like '%open%cv%' and lower("Tags") like '%<c#>%')
and   "CreationDate" < convert(datetime,format(GETDATE(),'yyyy-MM-01'))
group by format("CreationDate",'yyyy-MM')


/*
TABLE NAME: TRENDS_JAVA
-- ***************************************
*/
select format("CreationDate",'yyyy-MM') creationdate
,      count("CreationDate")            posts
from   Posts
where (lower("Tags") like '%open%cv%' and lower("Tags") like '%<java>%')
and   "CreationDate" < convert(datetime,format(GETDATE(),'yyyy-MM-01'))
group by format("CreationDate",'yyyy-MM')

/*
TABLE NAME: TRENDS_JS
-- ***************************************
*/
select format("CreationDate",'yyyy-MM') creationdate
,      count("CreationDate")            posts
from   Posts
where (lower("Tags") like '%open%cv%' and lower("Tags") like '%<javascript%>%')
and   "CreationDate" < convert(datetime,format(GETDATE(),'yyyy-MM-01'))
group by format("CreationDate",'yyyy-MM')     

/*
TABLE NAME: TRENDS_MATLAB
-- ***************************************
*/
select format("CreationDate",'yyyy-MM') creationdate
,      count("CreationDate")            posts
from   Posts
where (lower("Tags") like '%open%cv%' and lower("Tags") like '%<matlab%>%')
and   "CreationDate" < convert(datetime,format(GETDATE(),'yyyy-MM-01'))
group by format("CreationDate",'yyyy-MM')

/*
TABLE NAME: TRENDS_OTHER
-- ***************************************
*/
select format("CreationDate",'yyyy-MM') creationdate
     ,      count("CreationDate")            posts
     from   Posts
     where (lower("Tags") like '%open%cv%' and  (    lower("Tags") not like '%<python%>%'
                                                 and lower("Tags") not like '%<c++%>%'
                                                 and lower("Tags") not like '%<c>%'
                                                 and lower("Tags") not like '%<c#>%'
                                                 and lower("Tags") not like '%<java>%'
                                                 and lower("Tags") not like '%<javascript%>%'
                                                 and lower("Tags") not like '%<matlab%>%'
                                                )
            )
     and   "CreationDate" < convert(datetime,format(GETDATE(),'yyyy-MM-01'))
     group by format("CreationDate",'yyyy-MM')
     

-- EXTRA data about tags:
/*
TABLE NAME: TAGS_ANS_ALL
-- ***************************************
---- tags of posts with ALL anwers
*/
select t."TagName"         name
,      count (t."TagName") "Count"
from posttags pt
left  outer join tags t  on t."Id" = pt."TagId"
where pt."PostId" in (select "Id" from posts where "Tags" like '%open%cv%' and "AnswerCount" > 0)
group by t."TagName"
having count (t."TagName") >= 100
order by count (t."TagName") desc

/*
TABLE NAME: TAGS_ANS_ALL_POS_SCORE
-- ***************************************
---- tags of posts with anwers (score >= 0)
*/
select t."TagName"         name
,      count (t."TagName") "Count"
from posttags pt
left  outer join tags t  on t."Id" = pt."TagId"
where pt."PostId" in (select "Id" from posts where "Tags" like '%open%cv%' and "AnswerCount" > 0 and "Score" >= 0)
group by t."TagName"
having count (t."TagName") >= 100
order by count (t."TagName") desc

/*
TABLE NAME: TAGS_NOANS_ALL
-- ***************************************
---- tags of posts with NO anwers ALL
*/
select t."TagName"         name
,      count (t."TagName") "Count"
from posttags pt
left  outer join tags t  on t."Id" = pt."TagId"
where pt."PostId" in (select "Id" from posts where "Tags" like '%open%cv%' and "AnswerCount" = 0)
group by t."TagName"
having count (t."TagName") >= 100
order by count (t."TagName") desc

/*
TABLE NAME: TAGS_NOANS_ALL_POS_SCORE
-- ***************************************
---- tags of posts with NO anwers (score >= 0)
*/
select t."TagName"         name
,      count (t."TagName") "Count"
from posttags pt
left  outer join tags t  on t."Id" = pt."TagId"
where pt."PostId" in (select "Id" from posts where "Tags" like '%open%cv%' and "AnswerCount" = 0 and "Score" >= 0)
group by t."TagName"
having count (t."TagName") >= 100
order by count (t."TagName") desc


-- 2) Tag trends 
------------------------------------------------------
-- * openCV related tags
-- table name: TAGS
select "Id"
,      "TagName"
,      "Count"
,      "ExcerptPostId"
,      "WikiPostId"
,      "IsModeratorOnly"
,      "IsRequired"
from  Tags
where lower("TagName") like '%open%cv%'
order by "Count";

-- 3) Location trends 
------------------------------------------------------
-- Note: UTF-8 encoding to include special characters
-- Further refined before importing into Excel (see RQ1_queries.sql)
-- 11 may 2021
------------------------------------------------------
-- SQL table name: LOCATIONS
select lower("Location")
,      count("Id") "Count"
from   Users
where "Id" in 
  (select "OwnerUserId"  "Id"    from Posts where lower("Tags") like '%open%cv%')
group by lower("Location")
order by "Count" desc




--***************************************************************************************
-- RQ2: Question Types
--***************************************************************************************
-- This is a combination of SQL developer queries and SEDE queries, see RQ2_queries.sql


--***************************************************************************************
-- RQ3: Topic Difficulty 
--***************************************************************************************

-- All tags used in OpenCV posts - (Topic Distribution)
-- SQL table name: TAGS
select t."TagName"         name  
,      count (t."TagName") "Count"
from  posttags pt
left  outer join tags t  on t."Id" = pt."TagId"
where pt."PostId" in (select "Id" from posts where "Tags" like '%open%cv%')
group by t."TagName"
having count (t."TagName") >= 100
order by count (t."TagName") desc;

-- Post difficulty data - based on accepted answer response time
-- SQL table name: POSTS_ANSWER_INTERVALS
select datediff(day,p."CreationDate",a."CreationDate") days_until_answer
,      datediff(hour,p."CreationDate",a."CreationDate") hours_until_answer
,      datediff(minute,p."CreationDate",a."CreationDate") minutes_until_answer
,      p."CreationDate"     post_creationdate
,      p."Title"            post_title
,      p."ViewCount"        post_viewcount
,      p."CommentCount"     post_commentcount
,      p."AnswerCount"      post_answercount
,      p."Score"            post_score

,      a."CreationDate"     ans_creationdate
,      a."Title"            ans_title
,      a."ViewCount"        ans_viewcount
,      a."CommentCount"     ans_commentcount
,      a."AnswerCount"      ans_answercount
,      a."Score"            ans_score

,      p."Body"             post_body
,      a."Body"             ans_body

,      p."Tags"             post_tags
,      a."Tags"             ans_tags

,      p."Id"                          post_id
,      p."FavoriteCount"               post_favoritecount
,      p."PostTypeId"                  post_posttypeid
,      p."AcceptedAnswerId"            post_acceptedanswerid
,      p."ParentId"                    post_parentid
,      p."OwnerUserId"                 post_owneruserid
,      p."OwnerDisplayName"            post_ownerdisplayname
,      p."LastEditorUserId"            post_lasteditoruserid
,      p."LastEditorDisplayName"       post_lasteditordisplayname
,      p."LastEditDate"                post_lasteditdate
,      p."LastActivityDate"            post_lastactivitydate
,      p."CommunityOwnedDate"          post_communityowneddate
,      p."DeletionDate"                post_deletiondate
,      p."ClosedDate"                  post_closeddate
,      p."ContentLicense"              post_contentlicense

,      a."Id"                          ans_id
,      a."FavoriteCount"               ans_favoritecount
,      a."PostTypeId"                  ans_posttypeid
,      a."AcceptedAnswerId"            ans_acceptedanswerid
,      a."ParentId"                    ans_parentid
,      a."OwnerUserId"                 ans_owneruserid
,      a."OwnerDisplayName"            ans_ownerdisplayname
,      a."LastEditorUserId"            ans_lasteditoruserid
,      a."LastEditorDisplayName"       ans_lasteditordisplayname
,      a."LastEditDate"                ans_lasteditdate
,      a."LastActivityDate"            ans_lastactivitydate
,      a."CommunityOwnedDate"          ans_communityowneddate
,      a."DeletionDate"                ans_deletiondate
,      a."ClosedDate"                  ans_closeddate
,      a."ContentLicense"              ans_contentlicense

from  Posts p
left outer join Posts a on p."AcceptedAnswerId" = a."Id" 
where lower(p."Tags") like '%open%cv%'
and p."AnswerCount" > 0 -- only show posts with answers


-- Comparison dataset: non-OpenCV posts
-- SQL table name: COMP_DATA
SET ROWCOUNT 24621 -- (same amount as successful posts)
select datediff(day,p."CreationDate",a."CreationDate") days_until_answer
,      datediff(hour,p."CreationDate",a."CreationDate") hours_until_answer
,      datediff(minute,p."CreationDate",a."CreationDate") minutes_until_answer
,      p."CreationDate"     post_creationdate
,      p."Title"            post_title
,      p."ViewCount"        post_viewcount
,      p."CommentCount"     post_commentcount
,      p."AnswerCount"      post_answercount
,      p."Score"            post_score

,      a."CreationDate"     ans_creationdate
,      a."Title"            ans_title
,      a."ViewCount"        ans_viewcount
,      a."CommentCount"     ans_commentcount
,      a."AnswerCount"      ans_answercount
,      a."Score"            ans_score

,      p."Body"             post_body
,      a."Body"             ans_body

,      p."Tags"             post_tags
,      a."Tags"             ans_tags

,      p."Id"                          post_id
,      p."FavoriteCount"               post_favoritecount
,      p."PostTypeId"                  post_posttypeid
,      p."AcceptedAnswerId"            post_acceptedanswerid
,      p."ParentId"                    post_parentid
,      p."OwnerUserId"                 post_owneruserid
,      p."OwnerDisplayName"            post_ownerdisplayname
,      p."LastEditorUserId"            post_lasteditoruserid
,      p."LastEditorDisplayName"       post_lasteditordisplayname
,      p."LastEditDate"                post_lasteditdate
,      p."LastActivityDate"            post_lastactivitydate
,      p."CommunityOwnedDate"          post_communityowneddate
,      p."DeletionDate"                post_deletiondate
,      p."ClosedDate"                  post_closeddate
,      p."ContentLicense"              post_contentlicense

,      a."Id"                          ans_id
,      a."FavoriteCount"               ans_favoritecount
,      a."PostTypeId"                  ans_posttypeid
,      a."AcceptedAnswerId"            ans_acceptedanswerid
,      a."ParentId"                    ans_parentid
,      a."OwnerUserId"                 ans_owneruserid
,      a."OwnerDisplayName"            ans_ownerdisplayname
,      a."LastEditorUserId"            ans_lasteditoruserid
,      a."LastEditorDisplayName"       ans_lasteditordisplayname
,      a."LastEditDate"                ans_lasteditdate
,      a."LastActivityDate"            ans_lastactivitydate
,      a."CommunityOwnedDate"          ans_communityowneddate
,      a."DeletionDate"                ans_deletiondate
,      a."ClosedDate"                  ans_closeddate
,      a."ContentLicense"              ans_contentlicense

from  Posts p
left outer join Posts a on p."AcceptedAnswerId" = a."Id" 
where lower(p."Tags") not like '%open%cv%'
and p."AnswerCount" > 0                                            -- only show posts with answers
and datediff(minute,p."CreationDate",a."CreationDate") is not null -- only use posts that have response time
and p."Score" >= 0                                                  -- only show posts with score >= 0
ORDER BY RAND()