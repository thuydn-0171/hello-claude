-- Migration: 001_create_teacher_table.sql
-- Description: Create teacher table for storing instructor information
-- Date: 2026-04-06

-- ============================================================
-- UP
-- ============================================================

CREATE TABLE teacher (
  id            INT           PRIMARY KEY AUTO_INCREMENT,
  first_name    VARCHAR(100)  NOT NULL,
  last_name     VARCHAR(100)  NOT NULL,
  email         VARCHAR(255)  NOT NULL UNIQUE,
  phone         VARCHAR(20)   DEFAULT NULL,
  department    VARCHAR(150)  NOT NULL,
  hire_date     DATE          NOT NULL,
  status        VARCHAR(20)   NOT NULL DEFAULT 'active'
                              CHECK (status IN ('active', 'on_leave', 'retired')),
  credentials   TEXT          DEFAULT NULL,
  office_location VARCHAR(100) DEFAULT NULL,
  bio           TEXT          DEFAULT NULL,
  created_at    TIMESTAMP     DEFAULT CURRENT_TIMESTAMP,
  updated_at    TIMESTAMP     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  -- Indexes
  INDEX idx_teacher_email (email),
  INDEX idx_teacher_department (department),
  INDEX idx_teacher_status (status),
  INDEX idx_teacher_last_name (last_name),
  INDEX idx_teacher_hire_date (hire_date)
);

-- ============================================================
-- DOWN
-- ============================================================

-- DROP TABLE IF EXISTS teacher;
