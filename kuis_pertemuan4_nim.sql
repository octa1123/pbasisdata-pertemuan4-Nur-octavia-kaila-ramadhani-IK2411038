CREATE DATABASE IF NOT EXISTS db_pertemuan4;
USE db_pertemuan4;

CREATE TABLE mahasiswa (
    nim VARCHAR(15) PRIMARY KEY,
    nama VARCHAR(100),
    nilai_akhir INT
);

INSERT INTO mahasiswa (nim, nama, nilai_akhir) VALUES
('230001','Andi',88),
('230002','Budi',76),
('230003','Citra',68),
('230004','Dewi',55),
('230005','Eka',40);

DROP PROCEDURE IF EXISTS cek_kelulusan_if;

DELIMITER //

CREATE PROCEDURE cek_kelulusan_if(IN p_nim VARCHAR(15))
BEGIN
    DECLARE v_nama VARCHAR(100);
    DECLARE v_nilai INT;
    DECLARE v_grade CHAR(1);
    DECLARE v_status VARCHAR(50);

    SELECT nama, nilai_akhir
    INTO v_nama, v_nilai
    FROM mahasiswa
    WHERE nim = p_nim;

    IF v_nilai >= 85 THEN
        SET v_grade = 'A';
        SET v_status = 'Lulus Sangat Baik';
    ELSEIF v_nilai >= 75 THEN
        SET v_grade = 'B';
        SET v_status = 'Lulus Baik';
    ELSEIF v_nilai >= 65 THEN
        SET v_grade = 'C';
        SET v_status = 'Lulus Cukup';
    ELSEIF v_nilai >= 50 THEN
        SET v_grade = 'D';
        SET v_status = 'Tidak Lulus';
    ELSE
        SET v_grade = 'E';
        SET v_status = 'Tidak Lulus';
    END IF;

    SELECT
        p_nim AS nim,
        v_nama AS nama,
        v_nilai AS nilai_akhir,
        v_grade AS grade,
        v_status AS status_kelulusan;
END //

DELIMITER ;