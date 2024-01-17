-- 1) Show first name, last name, and gender of patients who's gender is 'M'
select first_name, last_name from medical_data.patients
where gender = 'M';

-- 2) Show first name and last name of patients who does not have allergies.
select first_name, last_name from medical_data.patients
where allergies is null;

-- 3) Show first name of patients that start with the letter 'C'
select first_name from medical_data.patients
where first_name like 'C%';

-- 4) Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)
select first_name, last_name, weight from medical_data.patients
where weight BETWEEN 100 AND 120;

-- 5) Show first name and last name concatenated into one column to show their full name.
select first_name, last_name,concat(first_name,' ',last_name) as full_name
from medical_data.patients;

-- 6)Show first name, last name, and the full province name of each patient.
select  province_name,
	SUBSTRING_INDEX(province_name, ' ', 1) AS first_name,
    SUBSTRING_INDEX(province_name, ' ', -1) AS last_name
from medical_data.province_names;

-- 7)Show how many patients have a birth_date with 2010 as the birth year.
select count(patient_id) as total_no_of_patients_of_2010
from medical_data.patients
where year(birth_date) = 2010;

-- 8) Show the first_name, last_name, and height of the patient with the greatest height.
select first_name, last_name, height
from medical_data.patients
order by height desc
limit 1;

-- 9) Show all columns for patients who have one of the following patient_ids: 1,45,534,879,1000
select * from medical_data.patients
where patient_id in (1,45,534,879,1000);

-- 10) Show the total number of admissions
select count(patient_id) as Total_no_of_admission
from medical_data.admissions;

-- 11) Show all the columns from admissions where the patient was admitted and discharged on the same day.
select * from medical_data.admissions
where admission_date = discharge_date;

-- 12) Show the total number of admissions for patient_id 579.
select count(patient_id) as Total_no_of_admission
from medical_data.admissions
where patient_id = 579;

-- 13) Based on the cities that our patients live in, show unique cities that are in province_id 'NS'?
select distinct city from medical_data.patients p1
join medical_data.province_names p2
on p1.province_id = p2.province_id
where p2.province_id = 'NS';

-- 14) Write a query to find the first_name, last name and birth date of patients who have height more than 160 and weight more than 70
select first_name, last_name, birth_date
from medical_data.patients
where height > 160 and weight > 60;

-- 15) Show unique birth years from patients and order them by ascending.
SELECT DISTINCT YEAR(birth_date) AS unique_birth_years
FROM medical_data.patients
ORDER BY YEAR(birth_date) ASC;

-- 16) Show unique first names from the patients table which only occurs once in the list.
SELECT first_name
FROM medical_data.patients
GROUP BY first_name
HAVING COUNT(first_name) = 1;

-- 17) Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.
select patient_id, first_name from medical_data.patients
where first_name like 's%s' and length(first_name) >= 6;

-- 18) Show patient_id, first_name, last_name from patients whose diagnosis is 'Dementia'.   Primary diagnosis is stored in the admissions table.
select p.patient_id, p.first_name, p.last_name 
from medical_data.patients p
join medical_data.admissions a
on p.patient_id = a.patient_id
where a.diagnosis ='Dementia';

-- 19) Display every patient's first_name. Order the list by the length of each name and then by alphbetically.
select first_name from medical_data.patients
ORDER BY LENGTH(first_name), first_name;

-- 20) Show the total amount of male patients and the total amount of female patients in the patients table. Display the two results in the same row.
SELECT
    SUM(CASE WHEN gender = 'M' THEN 1 ELSE 0 END) AS total_male_patients,
    SUM(CASE WHEN gender = 'F' THEN 1 ELSE 0 END) AS total_female_patients
FROM medical_data.patients;

-- 21) Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.
select patient_id, count(patient_id) as times, diagnosis
from medical_data.admissions
group by patient_id,diagnosis
having count(diagnosis) > 1;

-- 22) Show the city and the total number of patients in the city. Order from most to least patients and then by city name ascending.
select city, count(patient_id) as total_patients from medical_data.patients
group by city
order by total_patients desc, city asc;

-- 23) Show first name, last name and role of every person that is either patient or doctor. The roles are either "Patient" or "Doctor"
select p.first_name as patient_first_name, p.last_name as patient_last_name, a.diagnosis,
	   d.first_name as doctor_first_name, d.last_name as doctor_last_name, d.specialty
from medical_data.patients p
join medical_data.admissions a
join medical_data.doctors d
on a.patient_id = p.patient_id and a.attending_doctor_id = doctor_id;

-- 24) Show all allergies ordered by popularity. Remove NULL values from query
select allergies, count(allergies) as popularity from medical_data.patients
group by allergies
order by popularity desc;

-- 25) Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.
select first_name, last_name, birth_date
from medical_data.patients
where year(birth_date) >= 1961 and year(birth_date) <= 1970
order by birth_date asc;

-- 26) We want to display each patient's full name in a single column. Their last_name in all upper letters must appear first, then first_name in all lower case letters. Separate the last_name and first_name with a comma. Order the list by the first_name in decending order    EX: SMITH,jane
select concat(upper(last_name),',',lower(first_name)) as full_name
from medical_data.patients
order by first_name desc;

-- 27) Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.
SELECT province_id, SUM(height) AS total_height
FROM medical_data.patients
GROUP BY province_id
HAVING SUM(height) >= 7000;

-- 28) Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'
select max(weight)-min(weight) as difference_of_weight 
from medical_data.patients
where last_name = 'maroni';

-- 29) Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.
select day(admission_date) as days, count(day(admission_date)) as admission
from medical_data.admissions
group by day(admission_date)
order by admission desc;

-- 30) Show all of the patients grouped into weight groups. Show the total amount of patients in each weight group. Order the list by the weight group decending. e.g. if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group, etc.
select case
	WHEN weight BETWEEN 0 AND 10 THEN '0-10'
    WHEN weight BETWEEN 11 AND 20 THEN '11-20'
    WHEN weight BETWEEN 21 AND 30 THEN '21-30'
    WHEN weight BETWEEN 31 AND 40 THEN '31-40'
    WHEN weight BETWEEN 41 AND 50 THEN '41-50'
    WHEN weight BETWEEN 51 AND 60 THEN '51-60'
    WHEN weight BETWEEN 61 AND 70 THEN '61-70'
    WHEN weight BETWEEN 71 AND 80 THEN '71-80'
    WHEN weight BETWEEN 81 AND 90 THEN '81-90'
    WHEN weight BETWEEN 91 AND 100 THEN '91-100'
    WHEN weight BETWEEN 101 AND 110 THEN '101-110'
    WHEN weight BETWEEN 111 AND 120 THEN '111-120'
    WHEN weight BETWEEN 121 AND 130 THEN '121-130'
    WHEN weight BETWEEN 131 AND 140 THEN '131-140'
    ELSE 'Other'
  END AS weight_group,
count(patient_id) as no_of_patients 
from medical_data.patients
group by weight_group
order by weight_group desc;

-- 31) Show patient_id, gender, weight, height, isObese from the patients table. Display isObese as a boolean 0 or 1. Obese is defined as weight(kg)/(height(m). Weight is in units kg. Height is in units cm.
select patient_id, weight, height,
case
	when (weight/power(height/100,2)) < 30.0 then 0
    else 1
end as Obese
from medical_data.patients;

-- 32) Show patient_id, first_name, last_name, and attending doctor's specialty. Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's first name is 'Lisa'. Check patients, admissions, and doctors tables for required information.
select a.patient_id, p.first_name, p.last_name, d.specialty as attending_doctor_specialty
from medical_data.doctors d
join medical_data.patients p
join medical_data.admissions a
on d.doctor_id = a.attending_doctor_id and a.patient_id = p.patient_id
where diagnosis = 'Epilepsy' and d.first_name = 'Lisa';

-- 33) All patients who have gone through admissions, can see their medical documents on our site. Those patients are given a temporary password after their first admission. Show the patient_id and temp_password.

  -- The password must be the following, in order:
    -- patient_id
    -- the numerical length of patient's last_name
    -- year of patient's birth_date
SELECT 
	a.patient_id,
	CONCAT(
        a.patient_id,
        LENGTH(p.last_name),
        YEAR(p.birth_date)
    ) AS temp_password
FROM medical_data.admissions a
join medical_data.patients p
on a.patient_id = p.patient_id
										-- END
