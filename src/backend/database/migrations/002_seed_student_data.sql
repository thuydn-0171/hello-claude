-- ============================================================
-- Migration: 002_seed_student_data.sql
-- Description: Insert sample data into the student table.
-- Date: 2026-04-06
-- ============================================================

-- =========================
-- UP (apply migration)
-- =========================

INSERT INTO student (first_name, last_name, email, phone, date_of_birth, gender, enrollment_date, major, gpa, status)
VALUES
  ('Nguyen', 'Minh Anh', 'minh.anh@university.edu', '+84-912-345-678', '2003-05-14', 'female', '2021-09-01', 'Computer Science', 3.72, 'active'),
  ('Tran', 'Duc Huy',   'duc.huy@university.edu',   '+84-987-654-321', '2002-11-28', 'male',   '2020-09-01', 'Electrical Engineering', 3.45, 'active'),
  ('Le', 'Thanh Thao',  'thanh.thao@university.edu', '+84-909-111-222', '2001-01-10', 'female', '2019-09-01', 'Business Administration', 3.88, 'graduated');

-- =========================
-- DOWN (rollback migration)
-- =========================

-- DELETE FROM student WHERE email IN (
--   'minh.anh@university.edu',
--   'duc.huy@university.edu',
--   'thanh.thao@university.edu'
-- );
