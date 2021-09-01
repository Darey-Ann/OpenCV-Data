-- Code for the paper "OpenCV on Stack Overflow: A Study on Developer Discussions"
-- Darey-Ann Louisville
-- ______________________________________________________________________________________

-- ######################################################################################
-- ######################################################################################
-- RQ1: What is the popularity trend for OpenCV posts on Stack Overflow?
-- ######################################################################################
-- ######################################################################################

-- These update statements will update the LOCATIONS table by aggregating locations into countries
-- After the updates, import into Excel with UTF-8 encoding to include special characters
-- Use geography datatype in Excel to create map graph
--

update locations 
set location = 'india'
where location like '%india%'
or    location like '%kerala%'
or    location like '%punjab%'
or    location like '%banglore%'
or    location like '%goa%'
or    location like '%mumbai%'
or    location like '%delhi%'
or    location like '%bangalore%'
or    location like '%hyderabad%'
or    location like '%ahmedabad%'
or    location like '%chennai%'
or    location like '%kolkata%'
or    location like '%surat%'
or    location like '%pune%'
or    location like '%jaipur%'
or    location like '%lucknow%'
or    location like '%kanpur%'
or    location like '%nagpur%'
or    location like '%indore%'
or    location like '%thane%'
or    location like '%bhopal%'
or    location like '%coimbatore%'
or    location like '%visakhapatnam%'
or    location like '%pimpri-chinchwad%'
or    location like '%patna%'
or    location like '%vadodara%'
or    location like '%ghaziabad%'
or    location like '%ludhiana%'
or    location like '%agra%'
or    location like '%nashik%'
or    location like '%ranchi%'
or    location like '%faridabad%'
or    location like '%meerut%'
or    location like '%rajkot%'
or    location like '%kalyan-dombivli%'
or    location like '%vasai-virar%'
or    location like '%varanasi%'
or    location like '%srinagar%'
or    location like '%aurangabad%'
or    location like '%dhanbad%'
or    location like '%amritsar%'
or    location like '%navi mumbai%'
or    location like '%allahabad%'
or    location like '%howrah%'
or    location like '%gwalior%'
or    location like '%jabalpur%'
or    location like '%madurai%'
or    location like '%vijayawada%'
or    location like '%jodhpur%'
or    location like '%salem%'
or    location like '%raipur%'
or    location like '%kota%'
or    location like '%chandigarh%'
or    location like '%guwahati%'
or    location like '%solapur%'
or    location like '%hubli–dharwad%'
or    location like '%mysore%'
or    location like '%tiruchirappalli%'
or    location like '%bareilly%'
or    location like '%aligarh%'
or    location like '%tiruppur%'
or    location like '%gurgaon%'
or    location like '%moradabad%'
or    location like '%jalandhar%'
or    location like '%bhubaneswar%'
or    location like '%warangal%'
or    location like '%mira-bhayandar%'
or    location like '%jalgaon%'
or    location like '%guntur%'
or    location like '%thiruvananthapuram%'
or    location like '%bhiwandi%'
or    location like '%saharanpur%'
or    location like '%gorakhpur%'
or    location like '%bikaner%'
or    location like '%amravati%'
or    location like '%noida%'
or    location like '%jamshedpur%'
or    location like '%bhilai%'
or    location like '%cuttack%'
or    location like '%firozabad%'
or    location like '%kochi%'
or    location like '%nellore%'
or    location like '%bhavnagar%'
or    location like '%dehradun%'
or    location like '%durgapur%'
or    location like '%asansol%'
or    location like '%rourkela%'
or    location like '%nanded%'
or    location like '%kolhapur%'
or    location like '%ajmer%'
or    location like '%akola%'
or    location like '%gulbarga%'
or    location like '%jamnagar%'
or    location like '%ujjain%'
or    location like '%loni%'
or    location like '%siliguri%'
or    location like '%jhansi%'
or    location like '%ulhasnagar%'
or    location like '%jammu%'
or    location like '%sangli-miraj%kupwad%'
or    location like '%mangalore%'
or    location like '%erode%'
or    location like '%belgaum%'
or    location like '%kurnool%'
or    location like '%ambattur%'
or    location like '%rajahmundry%'
or    location like '%tirunelveli%'
or    location like '%malegaon%'
or    location like '%gaya%'
or    location like '%tirupati%'
or    location like '%udaipur%'
or    location like '%kakinada%'
or    location like '%davanagere%'
or    location like '%kozhikode%'
or    location like '%maheshtala%'
or    location like '%rajpur sonarpur%'
or    location like '%bokaro%'
or    location like '%south dumdum%'
or    location like '%bellary%'
or    location like '%patiala%'
or    location like '%gopalpur%'
or    location like '%agartala%'
or    location like '%bhagalpur%'
or    location like '%muzaffarnagar%'
or    location like '%bhatpara%'
or    location like '%panihati%'
or    location like '%latur%'
or    location like '%dhule%'
or    location like '%rohtak%'
or    location like '%sagar%'
or    location like '%korba%'
or    location like '%bhilwara%'
or    location like '%berhampur%'
or    location like '%muzaffarpur%'
or    location like '%ahmednagar%'
or    location like '%mathura%'
or    location like '%kollam%'
or    location like '%avadi%'
or    location like '%kadapa%'
or    location like '%anantapuram%'
or    location like '%kamarhati%'
or    location like '%bilaspur%'
or    location like '%sambalpur%'
or    location like '%shahjahanpur%'
or    location like '%satara%'
or    location like '%bijapur%'
or    location like '%rampur%'
or    location like '%shimoga%'
or    location like '%chandrapur%'
or    location like '%junagadh%'
or    location like '%thrissur%'
or    location like '%alwar%'
or    location like '%bardhaman%'
or    location like '%kulti%'
or    location like '%nizamabad%'
or    location like '%parbhani%'
or    location like '%tumkur%'
or    location like '%khammam%'
or    location like '%uzhavarkarai%'
or    location like '%bihar sharif%'
or    location like '%panipat%'
or    location like '%darbhanga%'
or    location like '%bally%'
or    location like '%aizawl%'
or    location like '%dewas%'
or    location like '%ichalkaranji%'
or    location like '%karnal%'
or    location like '%bathinda%'
or    location like '%jalna%'
or    location like '%eluru%'
or    location like '%barasat%'
or    location like '%kirari suleman nagar%'
or    location like '%purnia%'
or    location like '%satna%'
or    location like '%mau%'
or    location like '%sonipat%'
or    location like '%farrukhabad%'
or    location like '%durg%'
or    location like '%imphal%'
or    location like '%ratlam%'
or    location like '%hapur%'
or    location like '%arrah%'
or    location like '%anantapur%'
or    location like '%karimnagar%'
or    location like '%etawah%'
or    location like '%ambarnath%'
or    location like '%north dumdum%'
or    location like '%bharatpur%'
or    location like '%begusarai%'
or    location like '%new delhi%'
or    location like '%gandhidham%'
or    location like '%baranagar%'
or    location like '%tiruvottiyur%'
or    location like '%pondicherry%'
or    location like '%sikar%'
or    location like '%thoothukudi%'
or    location like '%rewa%'
or    location like '%mirzapur%'
or    location like '%raichur%'
or    location like '%pali%'
or    location like '%ramagundam%'
or    location like '%silchar%'
or    location like '%haridwar%'
or    location like '%vijayanagaram%'
or    location like '%tenali%'
or    location like '%nagercoil%'
or    location like '%sri ganganagar%'
or    location like '%karawal nagar%'
or    location like '%mango%'
or    location like '%thanjavur%'
or    location like '%bulandshahr%'
or    location like '%uluberia%'
or    location like '%katni%'
or    location like '%sambhal%'
or    location like '%singrauli%'
or    location like '%nadiad%'
or    location like '%secunderabad%'
or    location like '%naihati%'
or    location like '%yamunanagar%'
or    location like '%bidhannagar%'
or    location like '%pallavaram%'
or    location like '%bidar%'
or    location like '%munger%'
or    location like '%panchkula%'
or    location like '%burhanpur%'
or    location like '%raurkela industrial township%'
or    location like '%kharagpur%'
or    location like '%dindigul%'
or    location like '%gandhinagar%'
or    location like '%hospet%'
or    location like '%nangloi jat%'
or    location like '%malda%'
or    location like '%ongole%'
or    location like '%deoghar%'
or    location like '%chapra%'
or    location like '%haldia%'
or    location like '%khandwa%'
or    location like '%nandyal%'
or    location like '%morena%'
or    location like '%amroha%'
or    location like '%anand%'
or    location like '%bhind%'
or    location like '%bhalswa jahangir pur%'
or    location like '%madhyamgram%'
or    location like '%bhiwani%'
or    location like '%berhampore%'
or    location like '%ambala%'
or    location like '%morbi%'
or    location like '%fatehpur%'
or    location like '%raebareli%'
or    location like '%khora, ghaziabad%'
or    location like '%chittoor%'
or    location like '%bhusawal%'
or    location like '%orai%'
or    location like '%bahraich%'
or    location like '%phusro%'
or    location like '%vellore%'
or    location like '%mehsana%'
or    location like '%raiganj%'
or    location like '%sirsa%'
or    location like '%danapur%'
or    location like '%serampore%'
or    location like '%sultan pur majra%'
or    location like '%guna%'
or    location like '%jaunpur%'
or    location like '%panvel%'
or    location like '%shivpuri%'
or    location like '%surendranagar dudhrej%'
or    location like '%unnao%'
or    location like '%chinsurah%'
or    location like '%alappuzha%'
or    location like '%kottayam%'
or    location like '%machilipatnam%'
or    location like '%shimla%'
or    location like '%adoni%'
or    location like '%udupi%'
or    location like '%katihar%'
or    location like '%proddatur%'
or    location like '%mahbubnagar%'
or    location like '%saharsa%'
or    location like '%dibrugarh%'
or    location like '%jorhat%'
or    location like '%hazaribagh%'
or    location like '%hindupur%'
or    location like '%nagaon%'
or    location like '%sasaram%'
or    location like '%hajipur%'
or    location like '%port blair%'
or    location like '%giridih%'
or    location like '%bhimavaram%'
or    location like '%kumbakonam%'
or    location like '%bongaigaon%'
or    location like '%dehri%'
or    location like '%madanapalle%'
or    location like '%siwan%'
or    location like '%bettiah%'
or    location like '%ramgarh%'
or    location like '%tinsukia%'
or    location like '%guntakal%'
or    location like '%srikakulam%'
or    location like '%motihari%'
or    location like '%dharmavaram%'
or    location like '%medininagar%'
or    location like '%gudivada%'
or    location like '%phagwara%'
or    location like '%pudukkottai%'
or    location like '%hosur%'
or    location like '%narasaraopet%'
or    location like '%suryapet%'
or    location like '%miryalaguda%'
or    location like '%tadipatri%'
or    location like '%karaikudi%'
or    location like '%kishanganj%'
or    location like '%jamalpur%'
or    location like '%ballia%'
or    location like '%kavali%'
or    location like '%tadepalligudem%'
or    location like '%amaravati%'
or    location like '%buxar%'
or    location like '%tezpur%'
or    location like '%jehanabad%'
or    location like '%aurangabad%'
or    location like '%gangtok%'
or    location like '%vasco da gama%';

update locations 
set location = 'sri lanka'
where location like '%sri lanka%'
or    location like '%srilanka%';

update locations 
set location = 'pakistan'
where location like '%pakistan%'
or    location like '%islamabad%';

update locations 
set location = 'iran'
where location like '%iran%'
or    location like '%tehran%';

update locations 
set location = 'iraq'
where location like '%iraq%';

update locations 
set location = 'united states of america'
where location like '%united states%'
or    location like '%united states of america%'
or    location like '%usa%'
or    location like '%, al'
or    location like '%, ak'
or    location like '%, as'
or    location like '%, az'
or    location like '%, ar'
or    location like '%, ca'
or    location like '%, co'
or    location like '%, ct'
or    location like '%, de'
or    location like '%, dc'
or    location like '%, fl'
or    location like '%, ga'
or    location like '%, gu'
or    location like '%, hi'
or    location like '%, id'
or    location like '%, il'
or    location like '%, in'
or    location like '%, ia'
or    location like '%, ks'
or    location like '%, ky'
or    location like '%, la'
or    location like '%, me'
or    location like '%, md'
or    location like '%, ma'
or    location like '%, mi'
or    location like '%, mn'
or    location like '%, ms'
or    location like '%, mo'
or    location like '%, mt'
or    location like '%, ne'
or    location like '%, nv'
or    location like '%, nh'
or    location like '%, nj'
or    location like '%, nm'
or    location like '%, ny'
or    location like '%, nc'
or    location like '%, nd'
or    location like '%, mp'
or    location like '%, oh'
or    location like '%, ok'
or    location like '%, or'
or    location like '%, pa'
or    location like '%, pr'
or    location like '%, ri'
or    location like '%, sc'
or    location like '%, sd'
or    location like '%, tn'
or    location like '%, tx'
or    location like '%, ut'
or    location like '%, vt'
or    location like '%, va'
or    location like '%, vi'
or    location like '%, wa'
or    location like '%, wv'
or    location like '%, wi'
or    location like '%, wy'
or    location like '%alabama%'
or    location like '%alaska%'
or    location like '%american samoa%'
or    location like '%arizona%'
or    location like '%arkansas%'
or    location like '%california%'
or    location like '%californie%'
or    location like '%colorado%'
or    location like '%connecticut%'
or    location like '%delaware%'
or    location like '%district of columbia%'
or    location like '%florida%'
or    location like '%georgia%'
or    location like '%guam%'
or    location like '%hawaii%'
or    location like '%idaho%'
or    location like '%illinois%'
or    location like '%indiana%'
or    location like '%iowa%'
or    location like '%kansas%'
or    location like '%kentucky%'
or    location like '%louisiana%'
or    location like '%maine%'
or    location like '%maryland%'
or    location like '%massachusetts%'
or    location like '%michigan%'
or    location like '%minnesota%'
or    location like '%mississippi%'
or    location like '%missouri%'
or    location like '%montana%'
or    location like '%nebraska%'
or    location like '%nevada%'
or    location like '%new hampshire%'
or    location like '%new hampshure%'
or    location like '%new jersey%'
or    location like '%new mexico%'
or    location like '%new york%'
or    location like '%north carolina%'
or    location like '%north dakota%'
or    location like '%northern mariana is%'
or    location like '%ohio%'
or    location like '%oklahoma%'
or    location like '%oregon%'
or    location like '%pennsylvania%'
or    location like '%puerto rico%'
or    location like '%rhode island%'
or    location like '%south carolina%'
or    location like '%south dakota%'
or    location like '%tennessee%'
or    location like '%texas%'
or    location like '%utah%'
or    location like '%vermont%'
or    location like '%virginia%'
or    location like '%virgin islands%'
or    location like '%washington%'
or    location like '%west virginia%'
or    location like '%wisconsin%'
or    location like '%wyoming%'
or    location like '%detroit%'
or    location like '%nyc%'
or    location like '%seattle%'
or    location like '%francisco%'
or    location like '%san diego%'
or    location like '%los angeles%'
or    location like '%chicago%'
or    location like '%boston%'
or    location like '%philadelphia%'
or    location like 'ny'
or    location like 'us'
or    location like 'ca'
or    location like 'america'
or    location like 'vereinigte staaten';


update locations 
set location = 'canada'
where location like '%canada%'
or    location like '%vancouver%'
or    location like '%calgary%'
or    location like '%winnipeg%'
or    location like '%alberta%'
or    location like '%british columbia%'
or    location like '%manitoba%'
or    location like '%new brunswick%'
or    location like '%newfoundland and labrador%'
or    location like '%nova scotia%'
or    location like '%ontario%'
or    location like '%prince edward island%'
or    location like '%quebec%'
or    location like '%saskatchewan%'
or    location like '%northwest territories%'
or    location like '%nunavut%'
or    location like '%yukon%'
or    location like '%ottawa%'
or    location like '%edmonton%'
or    location like '%victoria%'
or    location like '%winnipeg%'
or    location like '%fredericton%'
or    location like '%st. john''s%'
or    location like '%halifax%'
or    location like '%toronto%'
or    location like '%charlottetown%'
or    location like '%quebec city%'
or    location like '%regina%'
or    location like '%yellowknife%'
or    location like '%iqaluit%'
or    location like '%whitehorse%';

update locations 
set location = 'australia'
where location like '%australia%'
or    location like '%melbourne%'
or    location like '%sydney%'
or    location like '%brisbane%'
or    location like '%perth%'
or    location like '%adelaide%'
or    location like '%gold coast–tweed heads%'
or    location like '%newcastle–maitland%'
or    location like '%canberra–queanbeyan%'
or    location like '%sunshine coast%'
or    location like '%central coast%'
or    location like '%wollongong%'
or    location like '%geelong%'
or    location like '%hobart%'
or    location like '%townsville%'
or    location like '%cairns%'
or    location like '%toowoomba%'
or    location like '%darwin%'
or    location like '%ballarat%'
or    location like '%bendigo%'
or    location like '%albury–wodonga%'
or    location like '%launceston%'
or    location like '%mackay%'
or    location like '%rockhampton%'
or    location like '%melton%'
or    location like '%bunbury%'
or    location like '%coffs harbour%'
or    location like '%bundaberg%'
or    location like '%wagga wagga%'
or    location like '%hervey bay%'
or    location like '%shepparton–mooroopna%'
or    location like '%mildura–wentworth%'
or    location like '%port macquarie%'
or    location like '%gladstone–tannum sands%'
or    location like '%tamworth%'
or    location like '%traralgon–morwell%'
or    location like '%bowral–mittagong%'
or    location like '%orange%'
or    location like '%warragul–drouin%'
or    location like '%busselton%'
or    location like '%dubbo%'
or    location like '%nowra–bomaderry%'
or    location like '%bathurst%'
or    location like '%geraldton%'
or    location like '%warrnambool%'
or    location like '%albany%'
or    location like '%devonport%'
or    location like '%mount gambier%'
or    location like '%kalgoorlie–boulder%'
or    location like '%lismore%'
or    location like '%nelson bay%'
or    location like '%burnie–wynyard%'
or    location like '%maryborough%'
or    location like '%victor harbor–goolwa%'
or    location like '%ballina%'
or    location like '%alice springs%'
or    location like '%taree%'
or    location like '%morisset–cooranbong%'
or    location like '%armidale%'
or    location like '%goulburn%'
or    location like '%bacchus marsh%'
or    location like '%gisborne–macedon%'
or    location like '%gympie%'
or    location like '%echuca–moama%'
or    location like '%whyalla%'
or    location like '%forster–tuncurry%'
or    location like '%griffith%'
or    location like '%st georges basin–sanctuary point%'
or    location like '%yeppoon%'
or    location like '%wangaratta%'
or    location like '%murray bridge%'
or    location like '%grafton%'
or    location like '%camden haven%'
or    location like '%mount isa%'
or    location like '%karratha%'
or    location like '%broken hill%'
or    location like '%ulladulla%'
or    location like '%moe–newborough%'
or    location like '%batemans bay%'
or    location like '%horsham%'
or    location like '%port lincoln%'
or    location like '%singleton%'
or    location like '%bairnsdale%'
or    location like '%kempsey%'
or    location like '%sale%'
or    location like '%yanchep%'
or    location like '%warwick%'
or    location like '%port hedland%'
or    location like '%ulverstone%'
or    location like '%emerald%'
or    location like '%broome%'
or    location like '%port pirie%'
or    location like '%port augusta%'
or    location like '%lithgow%'
or    location like '%mudgee%'
or    location like '%colac%'
or    location like '%muswellbrook%'
or    location like '%esperance%'
or    location like '%parkes%'
or    location like '%swan hill%'
or    location like '%portland%'
or    location like '%kingaroy%';

update locations 
set location = 'united kingdom'
where location like '%united kingdom%'
or    location like '%england%'
or    location like '%wales%'
or    location like '%manchester%'
or    location like '%oxford%'
or    location like '%cambridge%'
or    location like '%bristol%'
or    location like '%rochester%'
or    location like '%london%'
or    location like '%scotland%'
or    location like '%southampton%'
or    location like '%英国%'
or    location like '%,uk'
or    location like '%, uk'
or    location like '%u.k.%'
or    location like 'uk';

update locations 
set location = 'united arab emirates'
where location like '%united arab emirates%'
or    location like '%dubai%';

update locations 
set location = 'brazil'
where location like '%brazil%'
or    location like '%brasil%';

update locations 
set location = 'china'
where location like '%china%'
or    location like '%chine%'
or    location like '%hong kong%'
or    location like '%hongkong%'
or    location like '%beijing%'
or    location like '%guangzhou%'
or    location like '%taiwan%'
or    location like '%中国%'
or    location like '%台灣%'
or    location like '%香港%';

update locations 
set location = 'japan'
where location like '%japan%'
or    location like '%tokyo%'
or    location like '%ōsaka%'
or    location like '%nhật bản%'
or    location like '%日本%';

update locations 
set location = 'south korea'
where location like '%대한민국%'
or    location like '%south korea%'
or    location like '%republic of korea%'
or    location like '%corea del sud%'
or    location like '%seoul%'
or    location like '%korea%';

update locations 
set location = 'vietnam'
where location like '%việt nam%'
or    location like '%viet nam%'
or    location like '%vietnam%';

update locations 
set location = 'thailand'
where location like '%thailand%'
or    location like '%thaïlande%'
or    location like '%ประเทศไทย%';

update locations 
set location = 'singapore'
where location like '%singapore%';

update locations 
set location = 'philippines'
where location like '%philippines%'
or    location like 'ph';

update locations 
set location = 'indonesia'
where location like '%indonesia%';

update locations 
set location = 'malaysia'
where location like '%malaysia%';

update locations 
set location = 'greece'
where location like '%greece%'
or    location like '%ελλάδα%';

update locations 
set location = 'bangladesh'
where location like '%bangladesh%';

update locations 
set location = 'spain'
where location like '%españa%'
or    location like '%espanya%'
or    location like '%barcelona%'
or    location like '%spain%';

update locations 
set location = 'belarus'
where location like '%беларусь%'
or    location like '%belarus%';

update locations 
set location = 'russia'
where location like '%россия%'
or    location like '%russia%'
or    location like '%petersburg%'
or    location like '%moscow%';

update locations 
set location = 'croatia'
where location like '%croatia%';

update locations 
set location = 'serbia'
where location like '%србија%'
or    location like '%belgrade%'
or    location like '%novi sad%'
or    location like '%serbia%';

update locations 
set location = 'norway'
where location like '%norge%'
or    location like '%norway%'
or    location like '%arendal%'
or    location like '%bergen%'
or    location like '%bodø%'
or    location like '%drammen%'
or    location like '%egersund%'
or    location like '%farsund%'
or    location like '%flekkefjord%'
or    location like '%florø%'
or    location like '%fredrikstad%'
or    location like '%gjøvik%'
or    location like '%grimstad%'
or    location like '%halden%'
or    location like '%hamar%'
or    location like '%hammerfest%'
or    location like '%harstad%'
or    location like '%haugesund%'
or    location like '%holmestrand%'
or    location like '%horten%'
or    location like '%hønefoss%'
or    location like '%kongsberg%'
or    location like '%kongsvinger%'
or    location like '%kristiansand%'
or    location like '%kristiansund%'
or    location like '%larvik%'
or    location like '%lillehammer%'
or    location like '%mandal%'
or    location like '%molde%'
or    location like '%moss%'
or    location like '%namsos%'
or    location like '%narvik%'
or    location like '%notodden%'
or    location like '%oslo%'
or    location like '%porsgrunn%'
or    location like '%risør%'
or    location like '%sandefjord%'
or    location like '%sandnes%'
or    location like '%sarpsborg%'
or    location like '%skien%'
or    location like '%stavanger%'
or    location like '%steinkjer%'
or    location like '%svolvær%'
or    location like '%tromsø%'
or    location like '%trondheim%'
or    location like '%tønsberg%'
or    location like '%vadsø%'
or    location like '%vardø%'
or    location like '%ålesund%';

update locations 
set location = 'sweden'
where location like '%sverige%'
or    location like '%sweden%';

update locations 
set location = 'ukraine'
where location like '%ukraine%'
or    location like '%ukraina%'
or    location like '%kyiv%'
or    location like '%kiev%'
or    location like '%украина%'
or    location like '%україна%';

update locations 
set location = 'romania'
where location like '%romania%'
or    location like '%românia%';

update locations 
set location = 'finland'
where location like '%finland%';

update locations 
set location = 'bulgaria'
where location like '%bulgaria%';

update locations 
set location = 'latvia'
where location like '%latvia%';

update locations 
set location = 'cyprus'
where location like '%cyprus%';

update locations 
set location = 'estonia'
where location like '%estonia%';

update locations 
set location = 'turkey'
where location like '%türkiye%'
or    location like '%turkey%';

update locations 
set location = 'netherlands'
where location like '%nederland%'
or    location like '%amsterdam%'
or    location like '%rotterdam%'
or    location like '%hague%'
or    location like '%hà lan%'
or    location like '%eindhoven%'
or    location like '%netherlands%';

update locations 
set location = 'belgium'
where location like '%belgium%'
or    location like '%belgië%'
or    location like '%antwerp%'
or    location like '%antwerpen%'
or    location like '%belgique%';

update locations 
set location = 'switzerland'
where location like '%switzerland%'
or    location like '%suisse%'
or    location like '%schweiz%';

update locations 
set location = 'czech republic'
where location like '%czech%'
or    location like '%česko%'
or    location like '%česká%'
or    location like '%brno%';

update locations 
set location = 'germany'
where location like '%deutschland%'
or    location like '%germany%'
or    location like '%frankfurt%'
or    location like '%niemcy%'
or    location like '%berlin%'
or    location like '%munich%'
or    location like '%alemania%'
or    location like '%德国%'
or    location like '%germania%'
or    location like '%hamburg%'
or    location like 'de';

update locations 
set location = 'austria'
where location like '%austria%'
or    location like '%ausztria%';

update locations 
set location = 'nepal'
where location like '%nepal%';

update locations 
set location = 'colombia'
where location like '%colombia%';

update locations 
set location = 'tunisia'
where location like '%tunisia%'
or    location like '%tunísia%'
or    location like '%tunisie%'
or    location like '%tunis%';


update locations 
set location = 'france'
where location like '%france%'
or    location like '%francia%'
or    location like '%paris%';

update locations 
set location = 'israel'
where location like '%ישראל%'
or    location like '%israel%'
or    location like '%israël%'
or    location like '%тель-авив%'
or    location like '%израиль%'
or    location like '%tel aviv%';

update locations 
set location = 'italy'
where location like '%italia%'
or    location like '%milan%'
or    location like '%italy%';

update locations 
set location = 'portugal'
where location like '%portugal%';

update locations 
set location = 'poland'
where location like '%poland%'
or    location like '%polska%';

update locations 
set location = 'egypt'
where location like '%egypt%'
or    location like '%cairo%'
or    location like '%مصر%';

update locations 
set location = 'saudi arabia'
where location like '%saudi arabia%';

update locations 
set location = 'nigeria'
where location like '%nigeria%';

update locations 
set location = 'kenya'
where location like '%kenya%'
or    location like '%nairobi%';

update locations 
set location = 'south africa'
where location like '%south africa%';

update locations 
set location = 'ethiopia'
where location like '%ethiopia%';

update locations 
set location = 'algeria'
where location like '%algeria%'
or    location like '%algérie%';

update locations 
set location = 'hungary'
where location like '%hungary%'
or    location like '%hingary%'
or    location like '%budapest%';

update locations 
set location = 'ireland'
where location like '%ireland%'
or    location like '%irlanda%'
or    location like '%dublin%';


update locations 
set location = 'argentina'
where location like '%argentina%'
or    location like '%argentine%';

update locations 
set location = 'denmark'
where location like '%denmark%'
or    location like '%danmark%'
or    location like '%copenhagen%';

update locations 
set location = 'morocco'
where location like '%morocco%'
or    location like '%maroc%'
or    location like '%marocco%';

update locations 
set location = 'mexico'
where location like '%mexico%'
or    location like '%méxico%';

update locations 
set location = 'new zealand'
where location like '%new zealand%';

update locations 
set location = 'slovakia'
where location like '%slovakia%';

update locations 
set location = 'slovenia'
where location like '%slovenia%';

update locations 
set location = 'armenia'
where location like '%armenia%';

update locations 
set location = 'chile'
where location like '%chile%';

update locations 
set location = 'ecuador'
where location like '%ecuador%';

update locations 
set location = 'lebanon'
where location like '%lebanon%';

update locations 
set location = 'ghana'
where location like '%ghana%';

update locations 
set location = 'venezuela'
where location like '%venezuela%';

update locations 
set location = 'kazakhstan'
where location like '%kazakhstan%';

update locations 
set location = 'iceland'
where location like '%iceland%';


/* never quit, without a */ commit;

-----------------------------------------------
/* -- doublecheck
select location 
,      sum(count)
from locations
group by location
order by 2 desc;
*/
-----------------------------------------------
