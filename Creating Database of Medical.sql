create database Medical_Data;

create table Medical_data.admissions(
	patient_id int,
    admission_date date,
    discharge_date date,
    diagnosis text,
    attending_doctor_id int
    );

create table Medical_data.doctors(
	first_name text,
    last_name text,
    specialty text,
    doctor_id int
    );
    
create table Medical_data.patients(
	first_name text,
    last_name text,
    gender varchar(1),
    birth_date date,
    city text,
    allergies text,
    height int,
    weight int,
    province_id char(2),
    patient_id int
    );
    
    create table Medical_data.province_names(
	province_name text,
    province_id char(2)
    );