-- ============================================================
-- Migration: 001_create_student_table.sql
-- Description: Create the student table for storing student
--              enrollment and academic information.
-- Date: 2026-04-06
-- ============================================================

-- =========================
-- UP (apply migration)
-- =========================

CREATE TABLE student (
  id            INT           PRIMARY KEY AUTO_INCREMENT,
  first_name    VARCHAR(100)  NOT NULL,
  last_name     VARCHAR(100)  NOT NULL,
  email         VARCHAR(255)  NOT NULL UNIQUE,
  phone         VARCHAR(20)   DEFAULT NULL,
  date_of_birth DATE          NOT NULL,
  gender        VARCHAR(10)   NOT NULL CHECK (gender IN ('male', 'female', 'other')),
  enrollment_date DATE        NOT NULL DEFAULT (CURRENT_DATE),
  major         VARCHAR(150)  NOT NULL,
  gpa           DECIMAL(3, 2) DEFAULT NULL CHECK (gpa >= 0.00 AND gpa <= 4.00),
  status        VARCHAR(20)   NOT NULL DEFAULT 'active'
                              CHECK (status IN ('active', 'graduated', 'suspended')),
  created_at    TIMESTAMP     DEFAULT CURRENT_TIMESTAMP,
  updated_at    TIMESTAMP     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  -- Indexes for frequently queried columns
  INDEX idx_student_email (email),
  INDEX idx_student_last_name (last_name),
  INDEX idx_student_major (major),
  INDEX idx_student_status (status),
  INDEX idx_student_enrollment_date (enrollment_date)
);

-- =========================
-- DOWN (rollback migration)
-- =========================

-- DROP TABLE IF EXISTS student;
