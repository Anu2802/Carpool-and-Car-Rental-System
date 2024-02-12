--- Team 4
---Members : Amanul Rahiman Attar 1002071319
---          Abhishek Joshi 1002050821
---          Anushka Chandrakant Pawar 1002071263
---          Sayali Suresh Shirbahadurkar 1002069366

 

SET ECHO OFF
SET SERVEROUTPUT ON SIZE 1000000
SET PAGESIZE 999
SET LINESIZE 132
SET WRAP OFF

-- Query 1
--- 1. Retrieve the total amount of rent for all rental car for each combination of Car Make and Car Type.
-- QUERY 1 FOR CUBE
SELECT Spring23_S003_4_car.car_type as car_type, Spring23_S003_4_car.car_make as car_make, SUM(Spring23_S003_4_car_rental_ride.fare) as total_fares
FROM Spring23_S003_4_car, Spring23_S003_4_car_rental_ride
WHERE Spring23_S003_4_car_rental_ride.licence_pl_number = Spring23_S003_4_car.licence_pl_number
GROUP BY CUBE(Spring23_S003_4_car.car_type,Spring23_S003_4_car.car_make);

/* ---OUTPUT---  
CAR_TYPE        CAR_MAKE             TOTAL_FARES
--------------- -------------------- -----------
                                            5476
                BMW                          506
                GMC                          120
                Audi                         192
                Ford                         523
                MINI                          59
                Acura                        112
                Honda                        354
                Lexus                        286
                Mazda                        198
                Nissan                        55
                Subaru                       566
                Toyota                       822
                Lincoln                       45
                Mercury                      376
                Porsche                      101
                Cadillac                      49
                Infiniti                     238
                Land Rover                    37
                Mitsubishi                   244
                Volkswagen                    90
                Mercedes-Benz                503
SUV                                         1375
SUV             BMW                          159
SUV             GMC                          120
SUV             Acura                        112
SUV             Honda                        283
SUV             Mazda                        198
SUV             Toyota                       217
SUV             Mercury                      129
SUV             Mitsubishi                   157
Sedan                                       1330
Sedan           BMW                          174
Sedan           Ford                         523
Sedan           MINI                          59
Sedan           Nissan                        55
Sedan           Toyota                       123
Sedan           Lincoln                       45
Sedan           Mercury                       34
Sedan           Porsche                      101
Sedan           Infiniti                     126
Sedan           Volkswagen                    90
Pickup Truck                                2771
Pickup Truck    BMW                          173
Pickup Truck    Audi                         192
Pickup Truck    Honda                         71
Pickup Truck    Lexus                        286
Pickup Truck    Subaru                       566
Pickup Truck    Toyota                       482
Pickup Truck    Mercury                      213
Pickup Truck    Cadillac                      49
Pickup Truck    Infiniti                     112
Pickup Truck    Land Rover                    37
Pickup Truck    Mitsubishi                    87
Pickup Truck    Mercedes-Benz                503

55 rows selected. */


-- Query 2
-- 2. Retrieve the total amount of fair for all carpool car for each combination of Car Make and Car Type.
-- QUERY 2 FOR CUBE
SELECT Spring23_S003_4_car.car_type as car_type, Spring23_S003_4_car.car_make as car_make, SUM(temp.fare) as total_fares
FROM Spring23_S003_4_car,Spring23_S003_4_carpool_ride,(select cr_id, SUM(fare)as fare from Spring23_S003_4_is_member group by cr_id) temp
WHERE Spring23_S003_4_carpool_ride.licence_pl_number = Spring23_S003_4_car.licence_pl_number AND 
      Spring23_S003_4_carpool_ride.cr_id = temp.cr_id
GROUP BY CUBE(Spring23_S003_4_car.car_type,Spring23_S003_4_car.car_make);


/* ---OUTPUT--- 
 CAR_TYPE        CAR_MAKE             TOTAL_FARES
--------------- -------------------- -----------
                                            2965
                GMC                          102
                Ford                         720
                Buick                        117
                Dodge                        144
                Honda                        136
                Lotus                        206
                Nissan                        36
                Saturn                        93
                Toyota                       311
                Mercury                       36

CAR_TYPE        CAR_MAKE             TOTAL_FARES
--------------- -------------------- -----------
                Pontiac                      258
                Porsche                       63
                Infiniti                     139
                Oldsmobile                   142
                Lamborghini                  179
                Mercedes-Benz                283
SUV                                          805
SUV             GMC                          102
SUV             Ford                         117
SUV             Dodge                        144
SUV             Lotus                         59

CAR_TYPE        CAR_MAKE             TOTAL_FARES
--------------- -------------------- -----------
SUV             Toyota                       168
SUV             Mercury                       36
SUV             Lamborghini                  179
Sedan                                       1120
Sedan           Buick                        117
Sedan           Honda                         79
Sedan           Lotus                        147
Sedan           Nissan                        36
Sedan           Saturn                        93
Sedan           Toyota                        56
Sedan           Pontiac                      104

CAR_TYPE        CAR_MAKE             TOTAL_FARES
--------------- -------------------- -----------
Sedan           Porsche                       63
Sedan           Oldsmobile                   142
Sedan           Mercedes-Benz                283
Pickup Truck                                1040
Pickup Truck    Ford                         603
Pickup Truck    Honda                         57
Pickup Truck    Toyota                        87
Pickup Truck    Pontiac                      154
Pickup Truck    Infiniti                     139

42 rows selected.
 */


-- Query 3
-- 3. Retrieve average rental rate for each unique combination of Car Make and Car Type.
-- QUERY 1 FOR OVER
SELECT Spring23_S003_4_car.car_type as car_type, Spring23_S003_4_car.car_make as car_make, 
        ROUND(AVG(Spring23_S003_4_car_rental_ride.fare) OVER(PARTITION BY Spring23_S003_4_car.car_type, Spring23_S003_4_car.car_make),2)as total_fares
FROM Spring23_S003_4_car, Spring23_S003_4_car_rental_ride
WHERE Spring23_S003_4_car_rental_ride.licence_pl_number = Spring23_S003_4_car.licence_pl_number;

 
/*  ---OUTPUT--- 

CAR_TYPE        CAR_MAKE             TOTAL_FARES
--------------- -------------------- -----------
Pickup Truck    Audi                          96
Pickup Truck    Audi                          96
Pickup Truck    BMW                         86.5
Pickup Truck    BMW                         86.5
Pickup Truck    Cadillac                      49
Pickup Truck    Honda                         71
Pickup Truck    Infiniti                      56
Pickup Truck    Infiniti                      56
Pickup Truck    Land Rover                    37
Pickup Truck    Lexus                      95.33
Pickup Truck    Lexus                      95.33

CAR_TYPE        CAR_MAKE             TOTAL_FARES
--------------- -------------------- -----------
Pickup Truck    Lexus                      95.33
Pickup Truck    Mercedes-Benz              83.83
Pickup Truck    Mercedes-Benz              83.83
Pickup Truck    Mercedes-Benz              83.83
Pickup Truck    Mercedes-Benz              83.83
Pickup Truck    Mercedes-Benz              83.83
Pickup Truck    Mercedes-Benz              83.83
Pickup Truck    Mercury                    106.5
Pickup Truck    Mercury                    106.5
Pickup Truck    Mitsubishi                    87
Pickup Truck    Subaru                     70.75

CAR_TYPE        CAR_MAKE             TOTAL_FARES
--------------- -------------------- -----------
Pickup Truck    Subaru                     70.75
Pickup Truck    Subaru                     70.75
Pickup Truck    Subaru                     70.75
Pickup Truck    Subaru                     70.75
Pickup Truck    Subaru                     70.75
Pickup Truck    Subaru                     70.75
Pickup Truck    Subaru                     70.75
Pickup Truck    Toyota                     68.86
Pickup Truck    Toyota                     68.86
Pickup Truck    Toyota                     68.86
Pickup Truck    Toyota                     68.86

CAR_TYPE        CAR_MAKE             TOTAL_FARES
--------------- -------------------- -----------
Pickup Truck    Toyota                     68.86
Pickup Truck    Toyota                     68.86
Pickup Truck    Toyota                     68.86
SUV             Acura                        112
SUV             BMW                         79.5
SUV             BMW                         79.5
SUV             GMC                           60
SUV             GMC                           60
SUV             Honda                      94.33
SUV             Honda                      94.33
SUV             Honda                      94.33

CAR_TYPE        CAR_MAKE             TOTAL_FARES
--------------- -------------------- -----------
SUV             Mazda                         99
SUV             Mazda                         99
SUV             Mercury                       43
SUV             Mercury                       43
SUV             Mercury                       43
SUV             Mitsubishi                   157
SUV             Toyota                     108.5
SUV             Toyota                     108.5
Sedan           BMW                           58
Sedan           BMW                           58
Sedan           BMW                           58

CAR_TYPE        CAR_MAKE             TOTAL_FARES
--------------- -------------------- -----------
Sedan           Ford                       104.6
Sedan           Ford                       104.6
Sedan           Ford                       104.6
Sedan           Ford                       104.6
Sedan           Ford                       104.6
Sedan           Infiniti                      63
Sedan           Infiniti                      63
Sedan           Lincoln                       45
Sedan           MINI                          59
Sedan           Mercury                       34
Sedan           Nissan                        55

CAR_TYPE        CAR_MAKE             TOTAL_FARES
--------------- -------------------- -----------
Sedan           Porsche                      101
Sedan           Toyota                       123
Sedan           Volkswagen                    90

69 rows selected. */


-- Query 4
-- 4. Calculate average rate charged to each car renter whose average is greater than overall average fares collected by all car renters
-- QUERY 1 FOR GROUP 
SELECT Spring23_S003_4_persons.f_name as first_name,Spring23_S003_4_persons.l_name as last_name, ROUND(temp.fare,2) as fares
FROM Spring23_S003_4_persons,(SELECT Spring23_S003_4_car_renter.renter_id as renter_id,AVG(Spring23_S003_4_car_rental_ride.fare) as fare
                              FROM Spring23_S003_4_car_rental_ride,Spring23_S003_4_is_renter_of,Spring23_S003_4_car_renter
                              WHERE Spring23_S003_4_car_rental_ride.ride_id = Spring23_S003_4_is_renter_of.ride_id AND
                                    Spring23_S003_4_is_renter_of.renter_id = Spring23_S003_4_car_renter.renter_id 
                              GROUP BY Spring23_S003_4_car_renter.renter_id 
                              HAVING AVG(Spring23_S003_4_car_rental_ride.fare) > (SELECT AVG(Spring23_S003_4_car_rental_ride.fare)
                                                                                  FROM Spring23_S003_4_car_rental_ride ))temp, Spring23_S003_4_car_renter
WHERE temp.renter_id = Spring23_S003_4_car_renter.renter_id AND 
      Spring23_S003_4_persons.p_id = Spring23_S003_4_car_renter.p_id;


/* ---OUTPUT--- 
 

FIRST_NAME                                         LAST_NAME                                               FARES
-------------------------------------------------- -------------------------------------------------- ----------
Skipper                                            Esch                                                     91.6
Reginald                                           Dennidge                                                99.67
Sallyann                                           Joselovitch                                               138
Sheri                                              Josefowicz                                                143
Jemmie                                             McDavid                                                  81.6
Tailor                                             Dossett                                                   108
Pall                                               Videan                                                     84
Gussi                                              Mowett                                                    110
Ira                                                McGunley                                                  101
Aubrey                                             Duligal                                                117.67
Fernanda                                           Maycey                                                    112
Erda                                               Tink                                                     85.8
Sheila-kathryn                                     Skule                                                   127.5

13 rows selected.
 */

-- Query 5
-- 5. Calculate average fares collected by car pool owners whose average fare is greater than overall average fare collected by all car pool owners. Display top 5 Car Pool Owners.
SELECT Spring23_S003_4_persons.f_name as first_name,Spring23_S003_4_persons.l_name as last_name, ROUND( temp.amt_paid,2) as total_amount
FROM (  SELECT Spring23_S003_4_payment_record.cpo_id as cpo_id,AVG(Spring23_S003_4_payment_record.amt_paid) as amt_paid
        FROM Spring23_S003_4_payment_record
        WHERE Spring23_S003_4_payment_record.cro_id IS NULL AND Spring23_S003_4_payment_record.renter_id IS NULL
        GROUP BY Spring23_S003_4_payment_record.cpo_id
        HAVING AVG(Spring23_S003_4_payment_record.amt_paid) > (SELECT AVG(Spring23_S003_4_payment_record.amt_paid) 
                                                               FROM Spring23_S003_4_payment_record
                                                               WHERE Spring23_S003_4_payment_record.cro_id IS NULL AND Spring23_S003_4_payment_record.renter_id IS NULL)
        FETCH FIRST 5 ROWS ONLY)temp, Spring23_S003_4_persons,Spring23_S003_4_carpool_owner
WHERE Spring23_S003_4_persons.p_id = Spring23_S003_4_carpool_owner.p_id AND
      temp.cpo_id = Spring23_S003_4_carpool_owner.cpo_id 
ORDER BY temp.amt_paid DESC
FETCH FIRST 5 ROWS ONLY;

/* ---OUTPUT--- 

FIRST_NAME                                         LAST_NAME                                          TOTAL_AMOUNT
-------------------------------------------------- -------------------------------------------------- ------------
Leeanne                                            Ruppel                                                       39
Lettie                                             Hurtic                                                    38.33
Kessiah                                            Cafferty                                                     37
Suzette                                            Gianni                                                       37
Stacy                                              Albiston                                                  30.67

 */
      
-- Query 6
-- 6. Calculate average rent collected by rental car owners whose average is greater than overall average rent collected by all RENTAL car owners. Display top 5 Car Rental Owners.
-- QUERY 3 FOR GROUP, ORDERBY , FETCH
SELECT Spring23_S003_4_persons.f_name as first_name,Spring23_S003_4_persons.l_name as last_name, ROUND(temp.amt_paid,2) as total_amount
FROM (  SELECT Spring23_S003_4_payment_record.cro_id as cro_id,AVG(Spring23_S003_4_payment_record.amt_paid) as amt_paid
        FROM Spring23_S003_4_payment_record
        WHERE Spring23_S003_4_payment_record.cpo_id IS NULL
        GROUP BY Spring23_S003_4_payment_record.cro_id
        HAVING AVG(Spring23_S003_4_payment_record.amt_paid) > (SELECT AVG(Spring23_S003_4_payment_record.amt_paid) 
                                                               FROM Spring23_S003_4_payment_record
                                                               WHERE Spring23_S003_4_payment_record.cpo_id IS NULL)
        FETCH FIRST 5 ROWS ONLY)temp, Spring23_S003_4_persons,Spring23_S003_4_rental_car_owner
WHERE Spring23_S003_4_persons.p_id = Spring23_S003_4_rental_car_owner.p_id AND
      temp.cro_id = Spring23_S003_4_rental_car_owner.cro_id 
ORDER BY temp.amt_paid DESC
FETCH FIRST 5 ROWS ONLY;

 
/* ---OUTPUT--- 
 
-- FIRST_NAME                                         LAST_NAME                                          TOTAL_AMOUNT
------------------------------------------------ -------------------------------------------------- ------------
-- Devonna                                            Draysay                                                     109
-- Ernaline                                           Blenkhorn                                                   102
-- Blanche                                            Ivancevic                                                  67.5
-- Frederick                                          Rouchy                                                    64.33
-- Patrick                                            Gomersal                                                     64

  */

-- Query 7
-- 7. Find name of all carpool riders that are in every ride with destination having zipcode 76905
-- QUERY 1 FOR DIVISION, LIKE
SELECT Spring23_S003_4_persons.f_name as first_name,Spring23_S003_4_persons.l_name as last_name
FROM Spring23_S003_4_persons, Spring23_S003_4_carpool_rider, (
                                                                SELECT carpool_rider_id
                                                                FROM Spring23_S003_4_carpool_rider CR
                                                                WHERE NOT EXISTS(
                                                                                    (SELECT  cr_id
                                                                                     FROM Spring23_S003_4_carpool_ride
                                                                                     WHERE destination LIKE '%76905%'
                                                                                    )
                                                                                    MINUS
                                                                                    (SELECT DISTINCT CR1.cr_id
                                                                                     FROM Spring23_S003_4_carpool_ride CR1, Spring23_S003_4_is_member IM
                                                                                     WHERE CR1.cr_id = IM.cr_id AND CR.carpool_rider_id = IM.carpool_rider_id
                                                                                    )
                                                                                )
                                                             )temp
WHERE temp.carpool_rider_id = Spring23_S003_4_carpool_rider.carpool_rider_id AND Spring23_S003_4_carpool_rider.p_id = Spring23_S003_4_persons.p_id;

 
 
/*  ---OUTPUT--- 
 
FIRST_NAME                                         LAST_NAME
-------------------------------------------------- --------------------------------------------------
Nicky                                              Joscelin

  */

-- Buisness Goals

 

-- 8. To give a list of customers who have signed up as a student.
SELECT DISTINCT Spring23_S003_4_persons.f_name as first_name,Spring23_S003_4_persons.l_name as last_name
FROM Spring23_S003_4_persons, Spring23_S003_4_carpool_rider, Spring23_S003_4_car_renter
WHERE Spring23_S003_4_carpool_rider.stud_id is not null AND
      Spring23_S003_4_car_renter.stud_id is not null AND
      Spring23_S003_4_carpool_rider.p_id = Spring23_S003_4_persons.p_id OR 
      Spring23_S003_4_car_renter.p_id = Spring23_S003_4_persons.p_id;
	  


/* ---OUTPUT--- 
FIRST_NAME                                         LAST_NAME
-------------------------------------------------- --------------------------------------------------
Ira                                                McGunley
Colet                                              Windas
Venus                                              Mulholland
Vernice                                            Sowrey
Ty                                                 Wickham
Ginnifer                                           Plank
Bryna                                              Traite
Ferdinande                                         Stainland
Wilona                                             Neads
Roma                                               Dannett
Manny                                              Wisniewski
Hermione                                           Turland
Martie                                             Starling
Gussi                                              Mowett
Maye                                               Mughal
Sheri                                              Josefowicz
Easter                                             Sharpless
Lanie                                              Sugarman
Sallyann                                           Brounsell
Travus                                             McTrustie
Brendon                                            Doole
Aubrey                                             Duligal
Judah                                              Hugnet
Cob                                                Fidler
Caria                                              Greiser
Chaim                                              Iiannoni
Germaine                                           Prodrick
Jada                                               Mc Mechan
Cyrille                                            Gomes
Pall                                               Videan
Esma                                               Poolton
Reginald                                           Dennidge
Jermaine                                           Bettenay
Christos                                           Jerrand
Demetria                                           Yonge
Georgiana                                          Whitechurch
Loree                                              Rosenbusch
Kiri                                               Tavernor
Lorant                                             Grattan
Vernon                                             McKeon
Inger                                              Kopps
Erda                                               Tink
Aurelie                                            Janca
Gerrilee                                           Kundt
Celisse                                            Taffarello
Osbert                                             Cantu
Gilberta                                           Gilfoy
Ofella                                             Wigelsworth
Fernanda                                           Maycey
Sibby                                              Cayley
Nikolai                                            Kleinmann
Georgia                                            Yanin
Devin                                              Ewers
Winfield                                           Tutchener
Julee                                              Remer
Maud                                               Oleszcuk
Agace                                              Chalker
Coretta                                            Hawe
Oralle                                             Driver
Nerty                                              Dobbinson
Siouxie                                            Cameron
Sallyann                                           Joselovitch
Maynard                                            Renwick
Nannette                                           Moorhead
Sherlocke                                          Gauche
Leann                                              Breddy
Hilly                                              Serraillier
Rockey                                             Freshwater
Phyllys                                            Duckers
Rikki                                              Annell
Elbertina                                          Canceller
Vick                                               McFetrich
Anallese                                           Olive
Diandra                                            Odhams
Nicky                                              Joscelin
Lief                                               Slatten
Danell                                             Leechman
Jemmie                                             McDavid
Eugenie                                            Placidi
Anatollo                                           Fairlaw
Felecia                                            Barnwill
Gayel                                              Bovaird
Sheila-kathryn                                     Skule
Skipper                                            Esch
Tailor                                             Dossett
Damon                                              Lis
Becki                                              Sarra
Freedman                                           Lanfare
Maurice                                            Sebastian
Myrna                                              Adess
Nester                                             Albro

91 rows selected. */



      
-- 9. Determine which type of vehicle is most preferred to be rented.
SELECT Spring23_S003_4_car.car_type as car_type, COUNT (Spring23_S003_4_car_rental_ride.ride_id) as NUM_OF_RIDES
FROM Spring23_S003_4_car, Spring23_S003_4_car_rental_ride
WHERE Spring23_S003_4_car_rental_ride.licence_pl_number = Spring23_S003_4_car.licence_pl_number
GROUP BY Spring23_S003_4_car.car_type
ORDER BY NUM_OF_RIDES DESC
FETCH FIRST 3 ROWS ONLY;



/* ---OUTPUT--- 

CAR_TYPE        NUM_OF_RIDES
--------------- ------------
Pickup Truck              36
Sedan                     17
SUV                       16

 */