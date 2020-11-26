-- tables
-- Table: agreements_tracking
CREATE TABLE agreements_tracking (
    agreements_tacking_id int NOT NULL,
    from_tutoring_session_id int NOT NULL,
    to_tutoring_session_id int NOT NULL,
    tutoring_agreement_id int NOT NULL,
    CONSTRAINT agreements_tracking_pk PRIMARY KEY (agreements_tacking_id)
);
-- Table: agreements_types
CREATE TABLE agreements_types (
    agreement_type_id int NOT NULL,
    title varchar(100) NOT NULL,
    description varchar(500) NOT NULL,
    hide char(1) NOT NULL,
    CONSTRAINT agreements_types_pk PRIMARY KEY (agreement_type_id)
);
-- Table: tutoring_agreements
CREATE TABLE tutoring_agreements (
    tutoring_agreement_id int NOT NULL,
    tutoring_session_id int NOT NULL,
    title varchar(100) NOT NULL,
    description varchar(500) NOT NULL,
    type int NOT NULL,
    done char(1) NOT NULL,
    created_at date NOT NULL,
    last_update date NOT NULL,
    CONSTRAINT tutoring_agreements_pk PRIMARY KEY (tutoring_agreement_id)
);
-- Table: tutoring_sessions
CREATE TABLE tutoring_sessions (
    tutoring_session_id int NOT NULL,
    tutor_id int NOT NULL,
    student_id int NOT NULL,
    title varchar(100) NOT NULL,
    description varchar(500) NOT NULL,
    session_date date NOT NULL,
    state char(1) NOT NULL,
    archived char(1) NOT NULL,
    session_url varchar(250) NOT NULL,
    CONSTRAINT tutoring_sessions_pk PRIMARY KEY (tutoring_session_id)
);
-- foreign keys
-- Reference: agreements_tracking_from_tutoring_sessions (table: agreements_tracking)
ALTER TABLE agreements_tracking
ADD CONSTRAINT agreements_tracking_from_tutoring_sessions 
FOREIGN KEY (from_tutoring_session_id) REFERENCES tutoring_sessions (tutoring_session_id) NOT DEFERRABLE INITIALLY IMMEDIATE;
-- Reference: agreements_tracking_to_tutoring_sessions (table: agreements_tracking)
ALTER TABLE agreements_tracking
ADD CONSTRAINT agreements_tracking_to_tutoring_sessions 
FOREIGN KEY (to_tutoring_session_id) REFERENCES tutoring_sessions (tutoring_session_id) NOT DEFERRABLE INITIALLY IMMEDIATE;
-- Reference: agreements_tracking_tutoring_agreements (table: agreements_tracking)
ALTER TABLE agreements_tracking
ADD CONSTRAINT agreements_tracking_tutoring_agreements 
FOREIGN KEY (tutoring_agreement_id) REFERENCES tutoring_agreements (tutoring_agreement_id) NOT DEFERRABLE INITIALLY IMMEDIATE;
-- Reference: tutoring_agreements_tutoring_sessions (table: tutoring_agreements)
ALTER TABLE tutoring_agreements
ADD CONSTRAINT tutoring_agreements_tutoring_sessions 
FOREIGN KEY (tutoring_session_id) REFERENCES tutoring_sessions (tutoring_session_id) NOT DEFERRABLE INITIALLY IMMEDIATE;
-- Reference: tutoring_agreements_types_of_agreements (table: tutoring_agreements)
ALTER TABLE tutoring_agreements
ADD CONSTRAINT tutoring_agreements_types_of_agreements 
FOREIGN KEY (type) REFERENCES agreements_types (agreement_type_id) NOT DEFERRABLE INITIALLY IMMEDIATE;
COMMIT;