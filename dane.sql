INSERT INTO Nauczyciel VALUES(0,'Mateusz','Paw�owski','398523515','mateuszpaw�owski@gmail.com',0,'mateusz_paw�owski','CMF211');
INSERT INTO Nauczyciel VALUES(1,'Agata','D�browski','264397773','agatad�browski@gmail.com',0,'agata_d�browski','EHA0DQ');
INSERT INTO Nauczyciel VALUES(2,'Agata','Krajewski','546348680','agatakrajewski@gmail.com',0,'agata_krajewski','BXSA85');
INSERT INTO Nauczyciel VALUES(3,'Urszula','G�rski','570886922','urszulag�rski@gmail.com',0,'urszula_g�rski','QD5O3G');
INSERT INTO Nauczyciel VALUES(4,'Genowefa','Michalski','341647567','genowefamichalski@gmail.com',0,'genowefa_michalski','LN0NC3');
INSERT INTO Nauczyciel VALUES(5,'Marianna','Kami�ski','734821318','mariannakami�ski@gmail.com',0,'marianna_kami�ski','H3SSJ0');
INSERT INTO Nauczyciel VALUES(6,'Maria','Adamski','811604216','mariaadamski@gmail.com',0,'maria_adamski','34150Y');
INSERT INTO Nauczyciel VALUES(7,'Genowefa','Marciniak','693710565','genowefamarciniak@gmail.com',0,'genowefa_marciniak','5VEUSP');
INSERT INTO Nauczyciel VALUES(8,'J�zef','Wieczorek','998093917','j�zefwieczorek@gmail.com',0,'j�zef_wieczorek','G6RQ1T');
INSERT INTO Nauczyciel VALUES(9,'Marianna','Szewczyk','136805182','mariannaszewczyk@gmail.com',0,'marianna_szewczyk','68TOGE');
INSERT INTO Opiekun VALUES(0,'Aleksandra','Grabowski','325275906','aleksandragrabowski@gmail.com','aleksandra_grabowski','HE4X6S',1,0);
INSERT INTO Opiekun VALUES(1,'Barbara','Maciejewski','111437064','barbaramaciejewski@gmail.com','barbara_maciejewski','P3912Q',0,1);
INSERT INTO Opiekun VALUES(2,'Leszek','Ka�mierczak','507275174','leszekka�mierczak@gmail.com','leszek_ka�mierczak','YHI4WV',0,0);
INSERT INTO Opiekun VALUES(3,'Helena','Laskowski','550608791','helenalaskowski@gmail.com','helena_laskowski','MC9QF7',0,0);
INSERT INTO Opiekun VALUES(4,'Jerzy','Marciniak','206901947','jerzymarciniak@gmail.com','jerzy_marciniak','IGLNUK',1,1);
INSERT INTO Opiekun VALUES(5,'Daniel','Zaj�c','446254480','danielzaj�c@gmail.com','daniel_zaj�c','L31SNI',0,0);
INSERT INTO Opiekun VALUES(6,'Pawe�','Krawczyk','181108188','pawe�krawczyk@gmail.com','pawe�_krawczyk','E3FH56',0,1);
INSERT INTO Opiekun VALUES(7,'Jan','G�rski','137986911','jang�rski@gmail.com','jan_g�rski','YNL8VJ',1,1);
INSERT INTO Przedmiot VALUES(0,'WOS');
INSERT INTO Przedmiot VALUES(1,'PO');
INSERT INTO Przedmiot VALUES(2,'J. polski');
INSERT INTO Przedmiot VALUES(3,'podstawy przedsi�biorczo�ci');
INSERT INTO Przedmiot VALUES(4,'Fizyka');
INSERT INTO Przedmiot VALUES(5,'w-f');
INSERT INTO Przedmiot VALUES(6,'technologia informacyjna');
INSERT INTO Przedmiot VALUES(7,'Biologia');
INSERT INTO Przedmiot VALUES(8,'Historia');
INSERT INTO Przedmiot VALUES(9,'Chemia');
INSERT INTO Przedmiot VALUES(10,'J. angielski');
INSERT INTO Przedmiot VALUES(11,'J. niemiecki');
INSERT INTO Przedmiot VALUES(12,'Matematyka');
INSERT INTO Przedmiot VALUES(13,'wiedza o kulturze');
INSERT INTO Przedmiot VALUES(14,'Religia');
INSERT INTO Klasa VALUES(0,'A1');
INSERT INTO Klasa VALUES(1,'B1');
INSERT INTO Klasa VALUES(2,'C1');
INSERT INTO Klasa VALUES(3,'D1');
INSERT INTO Klasa VALUES(4,'A2');
INSERT INTO Klasa VALUES(5,'B2');
INSERT INTO Klasa VALUES(6,'C2');
INSERT INTO Klasa VALUES(7,'D2');
INSERT INTO Klasa VALUES(8,'A3');
INSERT INTO Klasa VALUES(9,'B3');
INSERT INTO Klasa VALUES(10,'C3');
INSERT INTO Klasa VALUES(11,'D3');
INSERT INTO NauczanaKlasaPrzedmiot VALUES(0,9,7,3);
INSERT INTO NauczanaKlasaPrzedmiot VALUES(1,6,9,1);
INSERT INTO NauczanaKlasaPrzedmiot VALUES(2,4,8,10);
INSERT INTO NauczanaKlasaPrzedmiot VALUES(3,2,11,1);
INSERT INTO NauczanaKlasaPrzedmiot VALUES(4,5,0,6);
INSERT INTO NauczanaKlasaPrzedmiot VALUES(5,1,9,8);
INSERT INTO NauczanaKlasaPrzedmiot VALUES(6,1,10,11);
INSERT INTO NauczanaKlasaPrzedmiot VALUES(7,0,7,4);
INSERT INTO NauczanaKlasaPrzedmiot VALUES(8,5,1,12);
INSERT INTO NauczanaKlasaPrzedmiot VALUES(9,9,0,2);
INSERT INTO NauczanaKlasaPrzedmiot VALUES(10,7,5,8);
INSERT INTO NauczanaKlasaPrzedmiot VALUES(11,6,5,4);
INSERT INTO NauczanaKlasaPrzedmiot VALUES(12,6,10,0);
INSERT INTO Prog VALUES(0,40,50,55,60,70,80,90);
INSERT INTO Test VALUES(0,'Test0',3,0,5,'2018-10-26 19:33:08',14);
INSERT INTO Test VALUES(1,'Test1',2,0,6,'2018-10-15 04:33:08',2);
INSERT INTO Test VALUES(2,'Test2',1,0,0,'2018-07-22 09:33:08',39);
INSERT INTO Test VALUES(3,'Test3',7,0,0,'2018-10-30 01:33:08',13);
INSERT INTO Test VALUES(4,'Test4',5,0,1,'2018-12-02 00:33:08',21);
INSERT INTO Test VALUES(5,'Test5',2,0,7,'2018-07-01 03:33:08',35);
INSERT INTO Test VALUES(6,'Test6',2,0,2,'2018-08-01 16:33:08',8);
INSERT INTO Test VALUES(7,'Test7',4,0,4,'2019-04-21 14:33:08',15);
INSERT INTO Test VALUES(8,'Test8',8,0,3,'2018-12-17 01:33:08',33);
INSERT INTO Test VALUES(9,'Test9',2,0,11,'2018-06-24 00:33:08',25);
INSERT INTO Uczen VALUES(0,'Wies�aw','Kubiak','79830386199','947977942','wies�awkubiak@gmail.com','wies�aw_kubiak','5W4ZYA',3,6);
INSERT INTO Uczen VALUES(1,'Artur','Koz�owski','99657254546','873887628','arturkoz�owski@gmail.com','artur_koz�owski','BTBW2Q',3,6);
INSERT INTO Uczen VALUES(2,'Kamil','Wo�niak','77633708131','391463445','kamilwo�niak@gmail.com','kamil_wo�niak','5ZM4EG',3,4);
INSERT INTO Uczen VALUES(3,'Krystyna','Majewski','70547976905','551839990','krystynamajewski@gmail.com','krystyna_majewski','VFOYW5',2,6);
INSERT INTO Uczen VALUES(4,'Jacek','Andrzejewski','30869030729','255184617','jacekandrzejewski@gmail.com','jacek_andrzejewski','D7WTDO',5,6);
INSERT INTO Uczen VALUES(5,'Miros�aw','Kowalski','45464204893','874046825','miros�awkowalski@gmail.com','miros�aw_kowalski','DXRVNU',5,3);
INSERT INTO Uczen VALUES(6,'Mateusz','Zalewski','23209408991','423712189','mateuszzalewski@gmail.com','mateusz_zalewski','3S1JWT',4,4);
INSERT INTO Uczen VALUES(7,'Monika','D�browski','78388522162','325522312','monikad�browski@gmail.com','monika_d�browski','9AA3EW',5,11);
INSERT INTO Uczen VALUES(8,'Piotr','Wilk','15574767683','616338040','piotrwilk@gmail.com','piotr_wilk','6VP7OY',3,4);
INSERT INTO Uczen VALUES(9,'Jan','Adamczyk','50518057206','601065756','janadamczyk@gmail.com','jan_adamczyk','V353TW',2,4);
INSERT INTO Uczen VALUES(10,'Ryszard','Jasi�ski','29046881102','335132852','ryszardjasi�ski@gmail.com','ryszard_jasi�ski','O6E681',3,9);
INSERT INTO Uczen VALUES(11,'Tadeusz','Wilk','79174695733','329782154','tadeuszwilk@gmail.com','tadeusz_wilk','ZHDB9O',3,6);
INSERT INTO Uczen VALUES(12,'Marta','Zalewski','72900562189','976439003','martazalewski@gmail.com','marta_zalewski','FR8IEN',3,7);
INSERT INTO Uczen VALUES(13,'Stanis�awa','Kowalczyk','46306079553','678471055','stanis�awakowalczyk@gmail.com','stanis�awa_kowalczyk','F0GIRV',4,0);
INSERT INTO Uczen VALUES(14,'Helena','Paw�owski','67357198634','581657798','helenapaw�owski@gmail.com','helena_paw�owski','AMCI3D',4,6);
INSERT INTO Uczen VALUES(15,'Robert','G�owacki','25609472580','652848102','robertg�owacki@gmail.com','robert_g�owacki','RVG9MD',7,8);
INSERT INTO Uczen VALUES(16,'Ewelina','Kucharski','19287668819','947770802','ewelinakucharski@gmail.com','ewelina_kucharski','LPBQJX',5,5);
INSERT INTO Uczen VALUES(17,'Janusz','Czarnecki','84348060915','118467766','januszczarnecki@gmail.com','janusz_czarnecki','VSG0J6',4,8);
INSERT INTO Uczen VALUES(18,'Marta','Tomaszewski','58691182073','411261894','martatomaszewski@gmail.com','marta_tomaszewski','WWWJZ3',3,7);
INSERT INTO Uczen VALUES(19,'Henryk','Jakubowski','76023949288','130785964','henrykjakubowski@gmail.com','henryk_jakubowski','7D90KT',4,6);
INSERT INTO Uczen VALUES(20,'Marek','Kalinowski','65682916019','658863540','marekkalinowski@gmail.com','marek_kalinowski','IS5CEZ',7,3);
INSERT INTO Uczen VALUES(21,'Gra�yna','Nowakowski','80965876972','143170199','gra�ynanowakowski@gmail.com','gra�yna_nowakowski','3QMH9P',6,3);
INSERT INTO Uczen VALUES(22,'Maciej','Brzezi�ski','19195665743','337510932','maciejbrzezi�ski@gmail.com','maciej_brzezi�ski','9OREZS',5,11);
INSERT INTO Uczen VALUES(23,'Wies�awa','Sikorski','57746679851','417804162','wies�awasikorski@gmail.com','wies�awa_sikorski','347SBE',7,7);
INSERT INTO Uczen VALUES(24,'Jaros�aw','G�rski','93165568595','406828123','jaros�awg�rski@gmail.com','jaros�aw_g�rski','VUM2JF',4,1);
INSERT INTO Uczen VALUES(25,'Marianna','Jab�o�ski','75469326186','353619588','mariannajab�o�ski@gmail.com','marianna_jab�o�ski','0V69F0',4,3);
INSERT INTO Uczen VALUES(26,'Danuta','Kwiatkowski','24497703272','439372730','danutakwiatkowski@gmail.com','danuta_kwiatkowski','5OMNYX',5,4);
INSERT INTO Uczen VALUES(27,'Marcin','Laskowski','84522176520','251381611','marcinlaskowski@gmail.com','marcin_laskowski','V2MFNS',5,7);
INSERT INTO Uczen VALUES(28,'Maciej','Czerwi�ski','87644008835','652746372','maciejczerwi�ski@gmail.com','maciej_czerwi�ski','KKU1JT',6,10);
INSERT INTO Uczen VALUES(29,'J�zef','Borkowski','53126996826','408019226','j�zefborkowski@gmail.com','j�zef_borkowski','294XQY',0,5);
INSERT INTO Uczen VALUES(30,'Patrycja','Szyma�ski','39925577151','726172880','patrycjaszyma�ski@gmail.com','patrycja_szyma�ski','IMJFN0',5,9);
INSERT INTO Uczen VALUES(31,'Irena','St�pie�','47067217208','968642386','irenast�pie�@gmail.com','irena_st�pie�','0TXURZ',0,8);
INSERT INTO Uczen VALUES(32,'Damian','Ka�mierczak','65808251742','114837279','damianka�mierczak@gmail.com','damian_ka�mierczak','9MGQ8Y',3,7);
INSERT INTO Uczen VALUES(33,'Mieczys�aw','Kowalski','21708305810','625857855','mieczys�awkowalski@gmail.com','mieczys�aw_kowalski','IUHXJG',2,4);
INSERT INTO Uczen VALUES(34,'Edward','Baranowski','65814842322','263263743','edwardbaranowski@gmail.com','edward_baranowski','H9XJKV',4,0);
INSERT INTO Uczen VALUES(35,'Ma�gorzata','Czarnecki','98421708659','658560088','ma�gorzataczarnecki@gmail.com','ma�gorzata_czarnecki','YUL7H5',6,3);
INSERT INTO Uczen VALUES(36,'Kamil','Adamski','11751187702','466792485','kamiladamski@gmail.com','kamil_adamski','3HTYQ6',6,11);
INSERT INTO Uczen VALUES(37,'Marcin','Dudek','53377638384','453300029','marcindudek@gmail.com','marcin_dudek','I1U7B9',1,2);
INSERT INTO Uczen VALUES(38,'Aneta','Dudek','52068254939','553866264','anetadudek@gmail.com','aneta_dudek','4CUQUL',7,4);
INSERT INTO Uczen VALUES(39,'Maciej','Wysocki','11979241532','928181944','maciejwysocki@gmail.com','maciej_wysocki','GPYVUN',7,8);
INSERT INTO Uczen VALUES(40,'Sylwia','Koz�owski','86337669007','621170873','sylwiakoz�owski@gmail.com','sylwia_koz�owski','B7DUAG',4,8);
INSERT INTO Uczen VALUES(41,'Tadeusz','Soko�owski','55732783314','610127799','tadeuszsoko�owski@gmail.com','tadeusz_soko�owski','GGI7BC',2,11);
INSERT INTO Uczen VALUES(42,'Jacek','Zi�kowski','16067811553','511770336','jacekzi�kowski@gmail.com','jacek_zi�kowski','I89WWO',5,10);
INSERT INTO Uczen VALUES(43,'Krzysztof','Ko�odziej','26056114519','414181919','krzysztofko�odziej@gmail.com','krzysztof_ko�odziej','40BZGQ',7,5);
INSERT INTO Uczen VALUES(44,'Urszula','Michalski','97746699507','947795646','urszulamichalski@gmail.com','urszula_michalski','S7VJCI',2,11);
INSERT INTO Uczen VALUES(45,'�ukasz','Ostrowski','79036046676','969687142','�ukaszostrowski@gmail.com','�ukasz_ostrowski','XDXPCV',1,6);
INSERT INTO Uczen VALUES(46,'Sylwia','Tomaszewski','94921795089','416377269','sylwiatomaszewski@gmail.com','sylwia_tomaszewski','BGHIUJ',1,2);
INSERT INTO Uczen VALUES(47,'Karolina','Sawicki','14685612464','401801982','karolinasawicki@gmail.com','karolina_sawicki','LMFDGY',7,4);
INSERT INTO Uczen VALUES(48,'Halina','Sikorski','81686651835','172302240','halinasikorski@gmail.com','halina_sikorski','7XFQFX',5,8);
INSERT INTO Uczen VALUES(49,'Marta','Szymczak','54965666981','113328087','martaszymczak@gmail.com','marta_szymczak','L0YANH',1,7);
INSERT INTO Uczen VALUES(50,'Wanda','Wilk','44690273637','420059793','wandawilk@gmail.com','wanda_wilk','3G5UAG',2,1);
INSERT INTO Uczen VALUES(51,'Ryszard','Pawlak','19198160018','134318145','ryszardpawlak@gmail.com','ryszard_pawlak','8EFAD9',6,0);
INSERT INTO Uczen VALUES(52,'Anna','D�browski','61000878362','772913390','annad�browski@gmail.com','anna_d�browski','FO8FIO',2,3);
INSERT INTO Uczen VALUES(53,'Miros�aw','Sobczak','65596753383','984864672','miros�awsobczak@gmail.com','miros�aw_sobczak','7UYJZY',4,10);
INSERT INTO Uczen VALUES(54,'Teresa','Adamski','56021365432','230053398','teresaadamski@gmail.com','teresa_adamski','E27V7U',5,11);
INSERT INTO Uczen VALUES(55,'Leszek','Kalinowski','95075172096','668862445','leszekkalinowski@gmail.com','leszek_kalinowski','36MIDH',7,3);
INSERT INTO Uczen VALUES(56,'Henryk','Wieczorek','37502053365','269546575','henrykwieczorek@gmail.com','henryk_wieczorek','DPIMB8',0,1);
INSERT INTO Uczen VALUES(57,'W�adys�aw','Pietrzak','24909275860','933056258','w�adys�awpietrzak@gmail.com','w�adys�aw_pietrzak','GE6XXG',1,3);
INSERT INTO Uczen VALUES(58,'Jadwiga','Zaj�c','54117084265','963855146','jadwigazaj�c@gmail.com','jadwiga_zaj�c','400VX7',2,0);
INSERT INTO Uczen VALUES(59,'Dorota','Nowicki','92692322197','737307529','dorotanowicki@gmail.com','dorota_nowicki','HQZ3KL',4,8);
INSERT INTO Uczen VALUES(60,'Jan','Jakubowski','48906049365','647805684','janjakubowski@gmail.com','jan_jakubowski','XWCY3T',6,11);
INSERT INTO Uczen VALUES(61,'Piotr','Paw�owski','16825781270','750159490','piotrpaw�owski@gmail.com','piotr_paw�owski','D91D5U',4,5);
INSERT INTO Uczen VALUES(62,'Myszkor','Szczepa�ski','75755572662','916473900','myszkorszczepa�ski@gmail.com','myszkor_szczepa�ski','ZHOHTK',6,7);
INSERT INTO Uczen VALUES(63,'Andrzej','Makowski','97603542903','765949698','andrzejmakowski@gmail.com','andrzej_makowski','6QL46N',0,10);
INSERT INTO Uczen VALUES(64,'Magdalena','Czerwi�ski','35898709717','776061282','magdalenaczerwi�ski@gmail.com','magdalena_czerwi�ski','10UA3T',3,7);
INSERT INTO Uczen VALUES(65,'Teresa','Zi�kowski','99013338358','377348615','teresazi�kowski@gmail.com','teresa_zi�kowski','QL7YU8',5,3);
INSERT INTO Uczen VALUES(66,'Andrzej','Marciniak','57221198081','665521091','andrzejmarciniak@gmail.com','andrzej_marciniak','A72WJP',7,10);
INSERT INTO Uczen VALUES(67,'Edward','Pietrzak','61304447023','127565364','edwardpietrzak@gmail.com','edward_pietrzak','ZD5X7L',2,5);
INSERT INTO Uczen VALUES(68,'Gra�yna','Czarnecki','95846143179','357857119','gra�ynaczarnecki@gmail.com','gra�yna_czarnecki','JA3N7H',7,0);
INSERT INTO Uczen VALUES(69,'Jacek','Czarnecki','99737978818','401327125','jacekczarnecki@gmail.com','jacek_czarnecki','I2OK7J',1,9);
INSERT INTO Uczen VALUES(70,'Pawe�','Marciniak','53090983215','255465362','pawe�marciniak@gmail.com','pawe�_marciniak','3JRLBL',1,10);
INSERT INTO Uczen VALUES(71,'Grzegorz','Koz�owski','80389441392','617994820','grzegorzkoz�owski@gmail.com','grzegorz_koz�owski','FWOEWD',3,3);
INSERT INTO Uczen VALUES(72,'Przemys�aw','Majewski','94792246209','350371049','przemys�awmajewski@gmail.com','przemys�aw_majewski','SB2I96',7,7);
INSERT INTO Uczen VALUES(73,'Irena','Urba�ski','23708264471','175637277','irenaurba�ski@gmail.com','irena_urba�ski','WEJJAW',2,5);
INSERT INTO Uczen VALUES(74,'Bo�ena','Kaczmarek','90108020241','863336800','bo�enakaczmarek@gmail.com','bo�ena_kaczmarek','QV7QA8',2,6);
INSERT INTO Uczen VALUES(75,'Izabela','Czerwi�ski','12315790216','975670428','izabelaczerwi�ski@gmail.com','izabela_czerwi�ski','IVJ6DC',2,11);
INSERT INTO Uczen VALUES(76,'Jolanta','Wieczorek','60884426417','375768641','jolantawieczorek@gmail.com','jolanta_wieczorek','UL4GA0',1,10);
INSERT INTO Uczen VALUES(77,'Natalia','Malinowski','80344365452','251152042','nataliamalinowski@gmail.com','natalia_malinowski','C0VBR2',6,6);
INSERT INTO Uczen VALUES(78,'Krystyna','Przybylski','55136542725','672610386','krystynaprzybylski@gmail.com','krystyna_przybylski','OZR0GG',3,8);
INSERT INTO Uczen VALUES(79,'Grzegorz','Mazurek','19696252018','731569616','grzegorzmazurek@gmail.com','grzegorz_mazurek','1BUSLE',0,6);
INSERT INTO Uczen VALUES(80,'Renata','Kami�ski','80658345863','178499327','renatakami�ski@gmail.com','renata_kami�ski','FUQLXK',1,3);
INSERT INTO Uczen VALUES(81,'Myszkor','Sadowski','29975025890','833596867','myszkorsadowski@gmail.com','myszkor_sadowski','MOWB0S',6,6);
INSERT INTO Uczen VALUES(82,'Urszula','Mazur','47566713470','311471451','urszulamazur@gmail.com','urszula_mazur','8ISLA6',2,0);
INSERT INTO Uczen VALUES(83,'Dorota','Zieli�ski','32063541942','444431173','dorotazieli�ski@gmail.com','dorota_zieli�ski','H4A23E',0,10);
INSERT INTO Uczen VALUES(84,'Maciej','Sikorski','20888434355','560060915','maciejsikorski@gmail.com','maciej_sikorski','X7A2AV',4,11);
INSERT INTO Uczen VALUES(85,'Aleksandra','Wieczorek','11245821447','547298308','aleksandrawieczorek@gmail.com','aleksandra_wieczorek','K9IQQR',6,0);
INSERT INTO Uczen VALUES(86,'Alicja','Adamski','22037728329','707949750','alicjaadamski@gmail.com','alicja_adamski','UEMSSN',4,2);
INSERT INTO Uczen VALUES(87,'Aleksandra','Zaj�c','39839943878','155020752','aleksandrazaj�c@gmail.com','aleksandra_zaj�c','2A4P6J',4,4);
INSERT INTO Uczen VALUES(88,'Andrzej','Sadowski','13179843107','500660323','andrzejsadowski@gmail.com','andrzej_sadowski','YFYICG',1,8);
INSERT INTO Uczen VALUES(89,'Leszek','Zawadzki','60925515819','565255948','leszekzawadzki@gmail.com','leszek_zawadzki','N82MCU',4,4);
INSERT INTO Uczen VALUES(90,'Roman','Borkowski','43276973367','535682912','romanborkowski@gmail.com','roman_borkowski','L2OGIW',5,6);
INSERT INTO Uczen VALUES(91,'Janina','Tomaszewski','77999850628','511277230','janinatomaszewski@gmail.com','janina_tomaszewski','CWEZ01',2,1);
INSERT INTO Uczen VALUES(92,'S�awomir','Szymczak','89370814371','676310079','s�awomirszymczak@gmail.com','s�awomir_szymczak','LY2KDI',5,1);
INSERT INTO Uczen VALUES(93,'Marek','Paw�owski','69899377705','456362452','marekpaw�owski@gmail.com','marek_paw�owski','0GUNBG',1,1);
INSERT INTO Uczen VALUES(94,'Irena','Zi�kowski','75866817321','570566773','irenazi�kowski@gmail.com','irena_zi�kowski','JJLGJ4',2,8);
INSERT INTO Uczen VALUES(95,'Jerzy','Zi�kowski','98502074536','350043986','jerzyzi�kowski@gmail.com','jerzy_zi�kowski','O4CESJ',1,8);
INSERT INTO Uczen VALUES(96,'Zofia','Nowak','64375720166','917595472','zofianowak@gmail.com','zofia_nowak','S7BQ21',7,4);
INSERT INTO Uczen VALUES(97,'S�awomir','Kwiatkowski','90235033848','667331656','s�awomirkwiatkowski@gmail.com','s�awomir_kwiatkowski','O6YEHG',6,7);
INSERT INTO Uczen VALUES(98,'Helena','W�odarczyk','65081512804','161523406','helenaw�odarczyk@gmail.com','helena_w�odarczyk','9X6GR8',7,11);
INSERT INTO Uczen VALUES(99,'Halina','Brzezi�ski','89984465011','756607721','halinabrzezi�ski@gmail.com','halina_brzezi�ski','Y744BH',2,5);
INSERT INTO Uczen VALUES(100,'Marianna','Michalak','44117632865','947250175','mariannamichalak@gmail.com','marianna_michalak','FRUUOQ',7,11);
INSERT INTO Uczen VALUES(101,'Maciej','Tomaszewski','55497151355','246832351','maciejtomaszewski@gmail.com','maciej_tomaszewski','REQ2KA',2,6);
INSERT INTO Uczen VALUES(102,'Piotr','Ko�odziej','24595797610','984131137','piotrko�odziej@gmail.com','piotr_ko�odziej','5NZT8A',7,5);
INSERT INTO Uczen VALUES(103,'Robert','W�jcik','75973772808','824142215','robertw�jcik@gmail.com','robert_w�jcik','25WHXD',7,3);
INSERT INTO Uczen VALUES(104,'Jadwiga','Ko�odziej','82045631269','484695213','jadwigako�odziej@gmail.com','jadwiga_ko�odziej','Y2OSI2',7,1);
INSERT INTO Uczen VALUES(105,'Ma�gorzata','Jab�o�ski','77003548022','402541646','ma�gorzatajab�o�ski@gmail.com','ma�gorzata_jab�o�ski','1U9THM',0,1);
INSERT INTO Uczen VALUES(106,'Miros�aw','Marciniak','34628312383','188948106','miros�awmarciniak@gmail.com','miros�aw_marciniak','7YILYD',3,7);
INSERT INTO Uczen VALUES(107,'Anna','Malinowski','70143925105','929869909','annamalinowski@gmail.com','anna_malinowski','OMYIPR',5,8);
INSERT INTO Uczen VALUES(108,'Dariusz','D�browski','40377878707','401699920','dariuszd�browski@gmail.com','dariusz_d�browski','A2ED9Q',6,8);
INSERT INTO Uczen VALUES(109,'Stanis�awa','Wojciechowski','83452078124','960952981','stanis�awawojciechowski@gmail.com','stanis�awa_wojciechowski','J09U97',6,11);
INSERT INTO Uczen VALUES(110,'S�awomir','Kr�l','28365090583','834080612','s�awomirkr�l@gmail.com','s�awomir_kr�l','8GXDZ1',2,2);
INSERT INTO Uczen VALUES(111,'Beata','Wr�bel','55394823454','604926902','beatawr�bel@gmail.com','beata_wr�bel','OYVA2F',2,2);
INSERT INTO Uczen VALUES(112,'Stanis�aw','Kr�l','67515414297','193946058','stanis�awkr�l@gmail.com','stanis�aw_kr�l','PRFFMC',4,8);
INSERT INTO Uczen VALUES(113,'Marzena','Wilk','41499470995','850577239','marzenawilk@gmail.com','marzena_wilk','IJ6Y58',6,4);
INSERT INTO Uczen VALUES(114,'Iwona','Maciejewski','15629210075','363269249','iwonamaciejewski@gmail.com','iwona_maciejewski','JZHGM4',4,7);
INSERT INTO Uczen VALUES(115,'Anna','Lis','30243826914','758838878','annalis@gmail.com','anna_lis','G5ZMWC',7,6);
INSERT INTO Uczen VALUES(116,'Sylwia','Gajewski','81179236643','658843721','sylwiagajewski@gmail.com','sylwia_gajewski','76ICO7',1,3);
INSERT INTO Uczen VALUES(117,'Dorota','Ko�odziej','66386132879','117906561','dorotako�odziej@gmail.com','dorota_ko�odziej','SFZJET',6,4);
INSERT INTO Uczen VALUES(118,'Ewelina','Tomaszewski','78173179123','700293955','ewelinatomaszewski@gmail.com','ewelina_tomaszewski','5RXY60',1,9);
INSERT INTO Uczen VALUES(119,'Wanda','Duda','37011500440','916988101','wandaduda@gmail.com','wanda_duda','PVNYIM',5,1);
INSERT INTO TestKlasa VALUES(0,0,9);
INSERT INTO TestKlasa VALUES(1,7,6);
INSERT INTO TestKlasa VALUES(2,3,4);
INSERT INTO TestKlasa VALUES(3,9,8);
INSERT INTO TestKlasa VALUES(4,7,7);
INSERT INTO TestKlasa VALUES(5,1,7);
INSERT INTO TestKlasa VALUES(6,0,2);
INSERT INTO TestKlasa VALUES(7,0,8);
INSERT INTO TestKlasa VALUES(8,9,7);
INSERT INTO TestKlasa VALUES(9,1,6);
INSERT INTO TestKlasa VALUES(10,5,8);
INSERT INTO TestKlasa VALUES(11,7,5);
INSERT INTO TestKlasa VALUES(12,6,4);
INSERT INTO TestKlasa VALUES(13,2,0);
INSERT INTO TestKlasa VALUES(14,6,6);
INSERT INTO TestKlasa VALUES(15,3,8);
INSERT INTO TestKlasa VALUES(16,1,9);
INSERT INTO TestKlasa VALUES(17,6,3);
INSERT INTO TestKlasa VALUES(18,1,4);
INSERT INTO TestKlasa VALUES(19,0,6);
INSERT INTO Ocena VALUES(0,1,109,3,5,13,'2018-10-24 00:33:08');
INSERT INTO Ocena VALUES(1,8,113,2,5,11,'2019-01-02 10:33:08');
INSERT INTO Ocena VALUES(2,6,67,2,1,9,'2018-10-12 08:33:08');
INSERT INTO Ocena VALUES(3,6,119,2,4,2,'2019-02-22 10:33:08');
INSERT INTO Ocena VALUES(4,4,115,4,2,10,'2018-09-02 01:33:08');
INSERT INTO Ocena VALUES(5,0,82,3.5,2,6,'2019-05-04 10:33:08');
INSERT INTO Ocena VALUES(6,1,31,5,2,10,'2018-11-07 19:33:08');
INSERT INTO Ocena VALUES(7,2,106,3.5,5,11,'2019-03-13 11:33:08');
INSERT INTO Ocena VALUES(8,8,91,4,2,13,'2018-10-14 02:33:08');
INSERT INTO Ocena VALUES(9,6,89,3,4,1,'2019-03-30 19:33:08');
INSERT INTO Ocena VALUES(10,7,19,3.5,0,9,'2018-07-23 06:33:08');
INSERT INTO Ocena VALUES(11,9,114,4.5,7,7,'2018-12-27 13:33:08');
INSERT INTO Ocena VALUES(12,3,75,1,3,4,'2018-10-13 05:33:08');
INSERT INTO Ocena VALUES(13,2,15,4.5,4,3,'2018-11-14 06:33:08');
INSERT INTO Ocena VALUES(14,4,16,3.5,5,13,'2019-01-06 02:33:08');
INSERT INTO Ocena VALUES(15,0,11,2.5,1,7,'2018-07-21 12:33:08');
INSERT INTO Ocena VALUES(16,3,33,3.5,3,4,'2019-05-08 12:33:08');
INSERT INTO Ocena VALUES(17,6,80,3.5,3,9,'2018-09-25 16:33:08');
INSERT INTO Ocena VALUES(18,4,35,3.5,9,12,'2018-12-28 00:33:08');
INSERT INTO Ocena VALUES(19,8,4,5,2,8,'2018-07-28 19:33:08');
INSERT INTO Ocena VALUES(20,7,116,2.5,7,9,'2019-02-28 08:33:08');
INSERT INTO Ocena VALUES(21,1,34,1,5,13,'2018-12-25 15:33:08');
INSERT INTO Ocena VALUES(22,1,64,3.5,7,3,'2018-07-12 22:33:08');
INSERT INTO Ocena VALUES(23,7,90,4,6,10,'2018-10-28 06:33:08');
INSERT INTO Ocena VALUES(24,9,118,2,3,12,'2019-05-10 18:33:08');
INSERT INTO Ocena VALUES(25,0,4,2,3,12,'2018-08-22 04:33:08');
INSERT INTO Ocena VALUES(26,0,66,4.5,1,0,'2018-09-28 00:33:08');
INSERT INTO Ocena VALUES(27,3,37,2,6,6,'2019-05-07 02:33:08');
INSERT INTO Ocena VALUES(28,4,66,3,2,6,'2019-05-18 20:33:08');
INSERT INTO Ocena VALUES(29,5,115,1,6,1,'2018-10-18 04:33:08');
INSERT INTO Ocena VALUES(30,1,114,4,3,6,'2018-10-11 11:33:08');
INSERT INTO Ocena VALUES(31,9,74,4.5,7,4,'2018-12-19 14:33:08');
INSERT INTO Ocena VALUES(32,3,51,3,5,7,'2018-10-04 11:33:08');
INSERT INTO Ocena VALUES(33,5,105,2.5,1,14,'2018-08-15 13:33:08');
INSERT INTO Ocena VALUES(34,5,29,2.5,0,3,'2019-04-06 04:33:08');
INSERT INTO Ocena VALUES(35,2,35,4,5,2,'2019-02-08 06:33:08');
INSERT INTO Ocena VALUES(36,6,63,5,8,4,'2019-02-07 01:33:08');
INSERT INTO Ocena VALUES(37,1,0,2,0,14,'2019-03-26 01:33:08');
INSERT INTO Ocena VALUES(38,6,54,3.5,8,13,'2018-10-27 15:33:08');
INSERT INTO Ocena VALUES(39,1,118,3.5,9,11,'2019-02-11 15:33:08');
INSERT INTO Ocena VALUES(40,5,38,4.5,6,0,'2019-02-03 22:33:08');
INSERT INTO Ocena VALUES(41,0,97,5,7,10,'2019-03-08 13:33:08');
INSERT INTO Ocena VALUES(42,3,119,2.5,2,7,'2018-08-21 19:33:08');
INSERT INTO Ocena VALUES(43,4,14,2.5,7,4,'2019-05-01 17:33:08');
INSERT INTO Ocena VALUES(44,7,71,2,0,2,'2019-03-13 12:33:08');
INSERT INTO Ocena VALUES(45,7,86,1,1,1,'2018-12-19 23:33:08');
INSERT INTO Ocena VALUES(46,0,48,2.5,4,0,'2019-03-31 10:33:08');
INSERT INTO Ocena VALUES(47,5,41,5,3,3,'2018-10-17 15:33:08');
INSERT INTO Ocena VALUES(48,5,107,1,8,7,'2019-02-08 01:33:08');
INSERT INTO Ocena VALUES(49,0,18,3,4,5,'2019-03-20 06:33:08');


--Dodane p�niej
INSERT INTO TestKlasa VALUES(21, 6, 2)
INSERT INTO TestKlasa VALUES(20, 3, 2)