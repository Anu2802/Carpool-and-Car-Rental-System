--- Team 4
---Members : Amanul Rahiman Attar 1002071319
---          Abhishek Joshi 1002050821
---          Anushka Chandrakant Pawar 1002071263
---          Sayali Suresh Shirbahadurkar 1002069366


--- Create Persons Table ---
create table  Spring23_S003_4_persons(   p_id varchar(10), 
                                        f_name varchar(50) not null, 
                                        l_name varchar(50) not null,  
                                        strt_add varchar(150) not null, 
                                        apt# varchar(20),
                                        city varchar(50) not null,
                                        state varchar(50) not null,
                                        zipcode varchar(5) not null,
                                        email varchar(50) unique not null,
                                        dob date,
                                        phn# char(10) unique not null,
                                        check (regexp_like(phn#, '[1-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')),
                                        primary key(p_id)
                                    );

--- Create Carpool_Owner Table ---
create table  Spring23_S003_4_carpool_owner( cpo_id varchar(10), 
                                            dl_no varchar(50) unique not null, 
                                            name_on_acc varchar(150) not null,  
                                            acc# varchar(20),
                                            route# char(9),
                                            bank_name varchar(50) not null,
                                            p_id varchar(10) unique not null,
                                            primary key(cpo_id),
                                            foreign key (p_id) references Spring23_S003_4_persons on delete cascade
                                           );

--- Create Carpool Rider Table ---                                              
create table Spring23_S003_4_carpool_rider( carpool_rider_id varchar(10) not null, 
                                            stud_id varchar(20),
                                            p_id varchar(10)unique not null,
                                            primary key(carpool_rider_id),
                                            foreign key (p_id) references Spring23_S003_4_persons on delete cascade
                                            );

--- Create Carpool Rider Debit Table ---                                   
create table Spring23_S003_4_carpool_rider_debit(carpool_rider_id varchar(10) not null,
                                                name_on_card varchar(50)not null,
                                                card# varchar(20)not null,
                                                exp_dt date not null,
                                                CVV varchar(5) not null,
                                                primary key (carpool_rider_id,name_on_card,card#,exp_dt,CVV),
                                                foreign key (carpool_rider_id) references Spring23_S003_4_carpool_rider on delete cascade
                                                );        

--- Create Car Renter Table ---                                             
create table Spring23_S003_4_car_renter (renter_id VARCHAR(10)not null,
                                        stud_id varchar(20),
                                        dl_no varchar(50) unique not null,
                                        p_id varchar (10) unique not null,
                                        primary key(renter_id),
                                        foreign key (p_id) references Spring23_S003_4_persons on delete cascade
                                        );

--- Create Car Renter Debit Table ---  
create table Spring23_S003_4_car_renter_debit(renter_id varchar(10) not null,
                                                name_on_card varchar(50) not null,
                                                card# varchar(20)not null,
                                                exp_dt date not null,
                                                CVV varchar(5) not null,
                                                primary key (renter_id,name_on_card,card#,exp_dt,CVV),
                                                foreign key (renter_id) references Spring23_S003_4_car_renter on delete cascade
                                                );

--- Create Rental Car Owner Table ---  
create table Spring23_S003_4_rental_car_owner( cro_id varchar(10)not null, 
                                                name_on_acc varchar(150) not null,  
                                                acc# varchar(20),
                                                route# char(9),
                                                bank_name varchar(50) not null,
                                                p_id varchar(10)unique not null,
                                                primary key(cro_id),
                                                foreign key (p_id) references Spring23_S003_4_persons on delete cascade
                                                );
--- Create Car Table ---                                                 
create table Spring23_S003_4_car ( licence_pl_number varchar(15) not null,
                                   car_type  varchar(15),
                                   car_make  varchar(20),
                                   no_of_seat int,
                                   insurance_end_date date,
                                   cro_id varchar(10) unique,
                                   cpo_id varchar(10) unique,
                                   available_from date,
                                   available_to date,
                                   primary key(licence_pl_number),
                                   foreign key (cro_id) references Spring23_S003_4_rental_car_owner on delete cascade,
                                   foreign key (cpo_id) references Spring23_S003_4_carpool_owner on delete cascade
                                  ); 

--- Create Carpool Ride Table ---                                   
create table Spring23_S003_4_carpool_ride(cr_id varchar(15) not null,
                                           source varchar(70) not null,
                                           destination varchar(70) not null,
                                           date_of_ride date not null,
                                           start_time varchar(8) not null,
                                           end_time varchar(8) not null,
                                           cpo_id varchar(15) not null,
                                           licence_pl_number varchar(20) not null,
                                           primary key(cr_id), 
                                           foreign key (cpo_id) references Spring23_S003_4_carpool_owner on delete cascade,
                                           foreign key (licence_pl_number) references Spring23_S003_4_car on delete cascade
                                         );
                                         
--- Create Car Rental Ride Table ---                                           
create table Spring23_S003_4_car_rental_ride(ride_id varchar(15) not null,
                                              pickup_loc varchar(70) ,
                                              pickup_time varchar(8),
                                              drop_time varchar(8) ,
                                              car_rent_date date ,
                                              fare int not null,
                                              licence_pl_number varchar(20) not null,
                                              primary key(ride_id), 
                                              foreign key (licence_pl_number) references Spring23_S003_4_car on delete cascade
                                              );
                                              
--- Create Payment Record Table ---                                        
create table Spring23_S003_4_payment_record(pay_id varchar(15) not null,
											pay_time varchar(8) not null,
											pay_date date not null,
											amt_received int not null,
											amt_paid int not null,
											amt_received_from varchar(50),
											amt_paid_to varchar(50),
											cpo_id varchar(10),
											renter_id varchar(10),
											cro_id varchar(10),
											primary key(pay_id),
											foreign key (cpo_id) references Spring23_S003_4_carpool_owner on delete cascade,
											foreign key (renter_id) references Spring23_S003_4_car_renter on delete cascade,
											foreign key (cro_id) references Spring23_S003_4_rental_car_owner on delete cascade);
                                            
--- Create Pays Fare Table ---  
create table Spring23_S003_4_pays_fare(carpool_rider_id varchar(15) not null,
										pay_id varchar(15) not null,
										primary key(carpool_rider_id,pay_id),
										foreign key (carpool_rider_id) references Spring23_S003_4_carpool_rider on delete cascade,
										foreign key (pay_id) references Spring23_S003_4_payment_record on delete cascade
                                        );

--- Create Is Member Table ---    
create table Spring23_S003_4_is_member( cr_id varchar(15)not null,
										carpool_rider_id varchar(15)not null,
                                        fare int,
										primary key(cr_id,carpool_rider_id),
										foreign key (cr_id) references Spring23_S003_4_carpool_ride on delete cascade,
										foreign key (carpool_rider_id) references Spring23_S003_4_carpool_rider on delete cascade
                                        );

--- Create Is Renter Of Table ---
create table Spring23_S003_4_is_renter_of(ride_id varchar(15) not null,
											renter_id varchar(15) not null,
											primary key(ride_id,renter_id),
											foreign key (ride_id) references Spring23_S003_4_car_rental_ride on delete cascade,
											foreign key (renter_id) references Spring23_S003_4_car_renter on delete cascade
                                            );
