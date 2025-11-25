---------------------------------------------------------
-- TẠO DATABASE
---------------------------------------------------------
IF DB_ID('ToaThuocDB') IS NOT NULL
    DROP DATABASE ToaThuocDB;
GO
CREATE DATABASE ToaThuocDB;
GO
USE ToaThuocDB;
GO


---------------------------------------------------------
-- TEMPLATE CHUNG CHO CÁC BẢNG:
-- Thêm: NgayTao, NgayCapNhat, Active
---------------------------------------------------------
-- Dùng DEFAULT GETDATE(), Active = 1
---------------------------------------------------------


---------------------------------------------------------
-- 1. BENHNHAN
---------------------------------------------------------
CREATE TABLE BenhNhan
(
    MaSoBenhNhan INT IDENTITY(1,1) PRIMARY KEY,
    MaBN AS ('BN' + RIGHT('000000000' + CAST(MaSoBenhNhan AS VARCHAR(9)), 9)) PERSISTED,

    HoTen NVARCHAR(100),
    NgaySinh DATE,
    DiaChi NVARCHAR(200),
    GioiTinh NVARCHAR(10),

    NgayTao DATETIME DEFAULT GETDATE(),
    NgayCapNhat DATETIME NULL,
    Active BIT DEFAULT 1
);
GO


---------------------------------------------------------
-- 2. HOSOBENHAN
---------------------------------------------------------
CREATE TABLE HoSoBenhAn
(
    MaSoHoSoBenhAn INT IDENTITY(1,1) PRIMARY KEY,
    MaHoSoBenhAn AS ('HS' + RIGHT('00000000' + CAST(MaSoHoSoBenhAn AS VARCHAR(8)), 8)) PERSISTED,

    MaBenhNhan INT,
    MaKhoa INT,
    ChanDoan NVARCHAR(200),
    ICD NVARCHAR(20),
    MaBacSi INT,

    NgayTao DATETIME DEFAULT GETDATE(),
    NgayCapNhat DATETIME NULL,
    Active BIT DEFAULT 1
);
GO


---------------------------------------------------------
-- 3. DONTHUOC
---------------------------------------------------------
CREATE TABLE DonThuoc
(
    MaSoDonThuoc INT IDENTITY(1,1) PRIMARY KEY,

    MaDonThuoc AS (RIGHT('000000000000' + CAST(MaSoDonThuoc AS VARCHAR(12)), 12)) PERSISTED,
    IDToaThuoc AS (RIGHT('0000000' + CAST(MaSoDonThuoc AS VARCHAR(7)), 7)) PERSISTED,

    MaHoSoBenhAn INT,
    MaBacSi INT,
    NgayDonThuoc DATE,
    LoiDan NVARCHAR(300),
    TaiKham BIT,
    NgayTaiKham DATE,
    ChanDoan NVARCHAR(200),
    MaICD NVARCHAR(20),
    LoaiToaThuoc NVARCHAR(50),

    NgayTao DATETIME DEFAULT GETDATE(),
    NgayCapNhat DATETIME NULL,
    Active BIT DEFAULT 1
);
GO


---------------------------------------------------------
-- 4. CHITIETTOATHUOC
---------------------------------------------------------
CREATE TABLE ChiTietToaThuoc
(
    MaSoChiTietToaThuoc INT IDENTITY(1,1) PRIMARY KEY,

    IDToaThuoc VARCHAR(10),
    MaDonThuoc VARCHAR(12),
    MaThuoc VARCHAR(20),

    DonViTinh NVARCHAR(50),
    PhuongThucSuDung NVARCHAR(100),
    DonViSuDung NVARCHAR(50),
    SoLuongLan INT,
    SoLuong DECIMAL(10,2),
    GhiChuCachUong NVARCHAR(300),

    NgayTao DATETIME DEFAULT GETDATE(),
    NgayCapNhat DATETIME NULL,
    Active BIT DEFAULT 1
);
GO


---------------------------------------------------------
-- 5. THUOC
---------------------------------------------------------
CREATE TABLE Thuoc
(
    MaSoThuoc INT IDENTITY(1,1) PRIMARY KEY,
    MaThuoc AS ('T' + RIGHT('0000' + CAST(MaSoThuoc AS VARCHAR(4)), 4)) PERSISTED,

    TenThuocVaHamLuong NVARCHAR(200),
    DonViTinh NVARCHAR(50),
    PhuongThucSuDung NVARCHAR(100),
    KhongConTonDeLanh BIT,
    KhongConSuDungTaiThoiDiemNay BIT,

    NgayTao DATETIME DEFAULT GETDATE(),
    NgayCapNhat DATETIME NULL,
    Active BIT DEFAULT 1
);
GO


---------------------------------------------------------
-- 6. PHUONGTHUCSUDUNG
---------------------------------------------------------
CREATE TABLE PhuongThucSuDung
(
    MaSoPhuongThucSuDung INT IDENTITY(1,1) PRIMARY KEY,
    MaPhuongThucSuDung VARCHAR(20),
    TenPhuongThucSuDung NVARCHAR(100),

    NgayTao DATETIME DEFAULT GETDATE(),
    NgayCapNhat DATETIME NULL,
    Active BIT DEFAULT 1
);
GO


---------------------------------------------------------
-- 7. ICD
---------------------------------------------------------
CREATE TABLE ICD
(
    MaSoICD INT IDENTITY(1,1) PRIMARY KEY,
    MaICD VARCHAR(20),
    MoTaICD NVARCHAR(200),

    NgayTao DATETIME DEFAULT GETDATE(),
    NgayCapNhat DATETIME NULL,
    Active BIT DEFAULT 1
);
GO


---------------------------------------------------------
-- 8. DONVI
---------------------------------------------------------
CREATE TABLE DonVi
(
    MaSoDonVi INT IDENTITY(1,1) PRIMARY KEY,
    TenDonVi NVARCHAR(100),
    PhanLoai NVARCHAR(50),

    NgayTao DATETIME DEFAULT GETDATE(),
    NgayCapNhat DATETIME NULL,
    Active BIT DEFAULT 1
);
GO



---------------------------------------------------------
-- INSERT DỮ LIỆU MẪU
---------------------------------------------------------

INSERT INTO BenhNhan (HoTen, NgaySinh, DiaChi, GioiTinh) VALUES
(N'Nguyễn Văn A', '1985-01-10', N'Hà Nội', N'Nam'),
(N'Trần Thị B',   '1990-05-22', N'Hồ Chí Minh', N'Nữ'),
(N'Lê Văn C',     '1978-11-03', N'Đà Nẵng', N'Nam'),
(N'Hoàng Thị D',  '2000-09-18', N'Hải Phòng', N'Nữ'),
(N'Phạm Văn E',   '1995-02-14', N'Cần Thơ', N'Nam');
GO


INSERT INTO PhuongThucSuDung (MaPhuongThucSuDung, TenPhuongThucSuDung) VALUES
('UONG', N'Uống'),
('XIT',  N'Xịt'),
('BOI',  N'Bôi ngoài da'),
('TIEM', N'Tiêm'),
('NGAM', N'Ngậm');
GO


INSERT INTO DonThuoc 
(MaHoSoBenhAn, MaBacSi, NgayDonThuoc, LoiDan, TaiKham, NgayTaiKham, ChanDoan, MaICD, LoaiToaThuoc)
VALUES
(1, 101, '2025-01-01', N'Uống nhiều nước', 0, NULL, N'Cảm cúm', 'J00', N'Toa thường'),
(2, 102, '2025-01-03', N'Hạn chế lạnh', 1, '2025-01-10', N'Viêm họng', 'J02', N'Toa tái khám'),
(3, 103, '2025-01-05', N'Tránh đồ cay', 0, NULL, N'Đau dạ dày', 'K29', N'Toa thường'),
(4, 104, '2025-01-08', N'Kiểm tra huyết áp hằng ngày', 1, '2025-01-15', N'Cao huyết áp', 'I10', N'Toa tái khám'),
(5, 105, '2025-01-11', N'Kiêng đường', 1, '2025-01-18', N'Tiểu đường type 2', 'E11', N'Toa điều trị');
GO


INSERT INTO ChiTietToaThuoc 
(IDToaThuoc, MaDonThuoc, MaThuoc, DonViTinh, PhuongThucSuDung, DonViSuDung, SoLuongLan, SoLuong, GhiChuCachUong)
VALUES
('0000001', '000000000001', 'T0001', N'viên', N'Uống', N'viên/lần', 3, 10, N'Sáng - trưa - chiều'),
('0000002', '000000000002', 'T0002', N'gói', N'Hòa tan', N'gói/lần', 2, 5, N'Sau ăn'),
('0000003', '000000000003', 'T0003', N'viên', N'Uống', N'viên/lần', 2, 14, N'Tối'),
('0000004', '000000000004', 'T0004', N'viên', N'Uống', N'viên/lần', 1, 30, N'Sáng'),
('0000005', '000000000005', 'T0005', N'chai', N'Xịt', N'lần', 3, 1, N'Sáng trưa chiều');
GO


INSERT INTO Thuoc 
(TenThuocVaHamLuong, DonViTinh, PhuongThucSuDung, KhongConTonDeLanh, KhongConSuDungTaiThoiDiemNay)
VALUES
(N'Paracetamol 500mg', N'viên', N'Uống', 0, 0),
(N'Vitamin C 500mg',   N'viên', N'Uống', 0, 0),
(N'Men tiêu hóa',       N'gói', N'Uống', 0, 0),
(N'Thuốc ho Prospan',   N'chai', N'Uống', 0, 0),
(N'Natri Clorid 0.9%',  N'chai', N'Xịt', 0, 0);
GO


INSERT INTO ICD (MaICD, MoTaICD) VALUES
('J00', N'Cảm cúm'),
('J02', N'Viêm họng'),
('K29', N'Viêm dạ dày'),
('I10', N'Tăng huyết áp'),
('E11', N'Tiểu đường type 2'),
('E03', N'Suy giáp'),
('E66', N'Béo phì'),
('G43', N'Đau nửa đầu (migraine)'),
('I20', N'Đau thắt ngực'),
('I50', N'Suy tim'),
('K52', N'Viêm ruột không đặc hiệu'),
('L03', N'Viêm mô tế bào'),
('M79', N'Đau cơ'),
('R05', N'Ho'),
('R42', N'Chóng mặt'),
('A09', N'Tiêu chảy'),
('B34', N'Nhiễm virus không đặc hiệu'),
('J18', N'Viêm phổi'),
('J45', N'Hen phế quản'),
('K21', N'Trào ngược dạ dày thực quản'),
('M54', N'Đau lưng'),
('N39', N'Nhiễm trùng tiết niệu'),
('R51', N'Đau đầu'),
('R50', N'Sốt không rõ nguyên nhân'),
('H10', N'Viêm kết mạc');
GO



INSERT INTO Thuoc 
(TenThuocVaHamLuong, DonViTinh, PhuongThucSuDung, KhongConTonDeLanh, KhongConSuDungTaiThoiDiemNay)
VALUES
-- Thuốc cơ bản
(N'Ibuprofen 400mg', N'viên', N'Uống', 0, 0),
(N'Omeprazol 20mg', N'viên', N'Uống', 0, 0),
(N'Metformin 500mg', N'viên', N'Uống', 0, 0),
(N'Amoxicillin 500mg', N'viên', N'Uống', 0, 0),
(N'Cefixim 200mg', N'viên', N'Uống', 0, 0),

-- Kháng viêm – giảm đau
(N'Diclofenac 50mg', N'viên', N'Uống', 0, 0),
(N'Meloxicam 7.5mg', N'viên', N'Uống', 0, 0),

-- Thuốc dạng gói
(N'Oresol', N'gói', N'Hòa nước uống', 0, 0),
(N'Acemuc 200mg', N'gói', N'Uống', 0, 0),

-- Thuốc siro
(N'Atussin siro', N'chai', N'Uống', 0, 0),
(N'Bromhexin siro', N'chai', N'Uống', 0, 0),

-- Thuốc xịt & nhỏ
(N'Natri Clorid 0.9% xịt mũi', N'chai', N'Xịt', 0, 0),
(N'Xanh Methylen 1%', N'chai', N'Bôi', 0, 0),
(N'Thuốc nhỏ mắt Natri Clorid 0.9%', N'chai', N'Nhỏ mắt', 0, 0),

-- Thuốc bôi da
(N'Hydrocortison 1%', N'tuýp', N'Bôi', 0, 0),
(N'Fucidin 2%', N'tuýp', N'Bôi', 0, 0),
(N'Ketoconazol 2%', N'tuýp', N'Bôi', 0, 0),

-- Thuốc tiêm
(N'Vitamin B1 100mg/ml', N'ống', N'Tiêm', 0, 0),
(N'Ceftriaxon 1g', N'lọ', N'Tiêm', 0, 0),

-- Thuốc ho – cảm cúm
(N'Decolgen', N'viên', N'Uống', 0, 0),
(N'Clorpheniramin 4mg', N'viên', N'Uống', 0, 0),

-- Thuốc dạ dày
(N'Esomeprazol 40mg', N'viên', N'Uống', 0, 0),
(N'Gaviscon', N'gói', N'Uống', 0, 0),

-- Thuốc bổ
(N'Vitamin 3B', N'viên', N'Uống', 0, 0),
(N'Calci D3', N'viên', N'Uống', 0, 0);
GO