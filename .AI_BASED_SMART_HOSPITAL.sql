CREATE DATABASE ai_smart_hospital;
USE ai_smart_hospital;

CREATE TABLE patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(15),
    address VARCHAR(200),
    date_of_birth DATE,
    gender VARCHAR(20),
    blood_group VARCHAR(10),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100),
    department_id INT,
    experience_years INT,
    contact_number VARCHAR(15),
    ai_assisted BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
        ON DELETE SET NULL
);

CREATE TABLE appointments (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    symptoms TEXT,
    ai_risk_score DECIMAL(5,2),
    ai_priority_level VARCHAR(50),
    status VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
        ON DELETE SET NULL,
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
        ON DELETE SET NULL
);

CREATE TABLE admissions (
    admission_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    ward VARCHAR(50),
    bed_number VARCHAR(20),
    bed_status VARCHAR(50),
    admission_date DATE,
    discharge_date DATE,
    ai_bed_allocation_score DECIMAL(5,2),
    status VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
        ON DELETE SET NULL
);

CREATE TABLE lab_tests (
    test_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    test_name VARCHAR(100),
    result TEXT,
    ai_interpretation TEXT,
    risk_flag VARCHAR(50),
    test_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
        ON DELETE SET NULL
);

CREATE TABLE medicines (
    medicine_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    stock INT,
    price DECIMAL(10,2),
    expiry_date DATE,
    ai_stock_prediction INT,
    low_stock_alert BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE invoices (
    invoice_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    estimated_amount DECIMAL(10,2),
    final_amount DECIMAL(10,2),
    status VARCHAR(50),
    invoice_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
        ON DELETE SET NULL
);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    invoice_id INT,
    amount DECIMAL(10,2),
    payment_method VARCHAR(50),
    payment_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (invoice_id) REFERENCES invoices(invoice_id)
        ON DELETE SET NULL
);

CREATE TABLE ai_diagnosis (
    diagnosis_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    symptoms TEXT,
    predicted_disease VARCHAR(100),
    confidence_score DECIMAL(5,2),
    recommended_treatment TEXT,
    ai_model_version VARCHAR(50),
    diagnosis_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
        ON DELETE SET NULL
);

CREATE TABLE health_monitoring (
    monitor_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    heart_rate INT,
    blood_pressure VARCHAR(20),
    oxygen_level INT,
    temperature DECIMAL(4,2),
    ai_alert_flag VARCHAR(50),
    recorded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
        ON DELETE SET NULL
);

CREATE TABLE system_logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    action_type VARCHAR(50),
    module_name VARCHAR(50),
    record_id INT,
    performed_by VARCHAR(50) DEFAULT 'Admin',
    log_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO departments (department_name, description) VALUES
('Cardiology','Heart and cardiovascular treatments'),
('Neurology','Brain and nervous system care'),
('Orthopedics','Bone and joint treatments'),
('Emergency','24x7 critical emergency services'),
('General Medicine','Primary healthcare services');

INSERT INTO doctors (name, specialization, department_id, experience_years, contact_number) VALUES
('Dr. Rahul Mehta','Cardiologist',1,12,'9876543210'),
('Dr. Anita Sharma','Neurologist',2,10,'9123456780'),
('Dr. Karan Singh','Orthopedic Surgeon',3,8,'9988776655'),
('Dr. Priya Verma','Emergency Specialist',4,9,'9090909090'),
('Dr. Amit Patel','Physician',5,7,'9898989898');

INSERT INTO patients (name,email,phone,address,date_of_birth,gender,blood_group) VALUES
('Rahul Sharma','rahul@gmail.com','9876543210','Delhi','1995-05-10','Male','B+'),
('Anita Verma','anita@gmail.com','9123456780','Noida','1992-08-15','Female','A+'),
('Karan Mehta','karan@gmail.com','9988776655','Mumbai','1988-03-22','Male','O+'),
('Priya Singh','priya@gmail.com','9090909090','Lucknow','1997-11-12','Female','AB+'),
('Amit Patel','amit@gmail.com','9898989898','Ahmedabad','1990-01-30','Male','B-');

INSERT INTO appointments 
(patient_id, doctor_id, appointment_date, symptoms, ai_risk_score, ai_priority_level, status) 
VALUES
(1,1,'2026-03-01','Chest pain and shortness of breath',82.50,'High','Completed'),
(2,2,'2026-03-02','Frequent headaches',45.20,'Medium','Scheduled'),
(3,3,'2026-03-10','Knee pain after injury',30.00,'Low','Completed'),
(4,4,'2026-03-15','High fever and weakness',75.00,'High','Completed'),
(5,5,'2026-03-20','General body fatigue',25.50,'Low','Scheduled');

INSERT INTO admissions 
(patient_id, ward, bed_number, bed_status, admission_date, discharge_date, ai_bed_allocation_score, status) 
VALUES
(1,'Cardiac Ward','C-101','Occupied','2026-03-01','2026-03-05',91.25,'Discharged'),
(4,'Emergency Ward','E-12','Occupied','2026-03-15',NULL,88.70,'Admitted');

INSERT INTO lab_tests 
(patient_id, test_name, result, ai_interpretation, risk_flag, test_date) 
VALUES
(1,'ECG','Abnormal rhythm detected','Possible arrhythmia detected. Immediate follow-up advised.','Critical','2026-03-01'),
(2,'MRI Brain','Normal scan','No abnormalities detected.','Normal','2026-03-02'),
(4,'Blood Test','High infection markers','Elevated WBC count indicating infection.','Warning','2026-03-15');

INSERT INTO medicines 
(name, stock, price, expiry_date, ai_stock_prediction, low_stock_alert) 
VALUES
('Aspirin',150,10.50,'2027-01-01',200,FALSE),
('Paracetamol',8,5.00,'2026-12-01',100,TRUE),
('Atorvastatin',50,25.00,'2027-06-15',80,FALSE),
('Antibiotic-X',5,120.00,'2026-09-20',60,TRUE);

INSERT INTO invoices 
(patient_id, estimated_amount, final_amount, status, invoice_date) 
VALUES
(1,15000.00,14800.00,'Paid','2026-03-05'),
(4,12000.00,12500.00,'Pending','2026-03-16');

INSERT INTO payments 
(invoice_id, amount, payment_method, payment_date) 
VALUES
(1,14800.00,'UPI','2026-03-05');

INSERT INTO ai_diagnosis 
(patient_id, symptoms, predicted_disease, confidence_score, recommended_treatment, ai_model_version, diagnosis_date) 
VALUES
(1,'Chest pain','Coronary Artery Disease',92.40,'Immediate angiography and medication','v1.0','2026-03-01'),
(4,'High fever','Severe Viral Infection',85.20,'IV antibiotics and monitoring','v1.0','2026-03-15');

INSERT INTO health_monitoring 
(patient_id, heart_rate, blood_pressure, oxygen_level, temperature, ai_alert_flag) 
VALUES
(1,110,'150/95',92,101.5,'Critical'),
(4,102,'140/90',94,100.2,'Warning'),
(2,72,'120/80',98,98.6,'Normal');

INSERT INTO system_logs (action_type, module_name, record_id) VALUES
('ADD','patients',1),
('ADD','appointments',1),
('ADD','lab_tests',1),
('ADD','invoices',1);