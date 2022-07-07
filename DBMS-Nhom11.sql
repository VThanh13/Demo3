CREATE DATABASE HEQTCSDL2
GO
USE HEQTCSDL2
GO

-- TẠO BẢNG
		CREATE TABLE KHACHHANG(
		MaKH  INT CONSTRAINT MaKHIsKey PRIMARY KEY NOT NULL CONSTRAINT CheckMaKH  CHECK ( MaKH > 0),
		TenKH NVARCHAR(50) NOT NULL,
		NgaySinh DATE NULL,
		DiaChi NVARCHAR(50) NULL,
		GioiTinh NVARCHAR(5) NULL,
		SDT VARCHAR(10) NOT NULL,
		EMAIL VARCHAR(30) NOT NULL,
		UserName VARCHAR(16) NOT NULL,
		MatKhau VARCHAR(20) NOT NULL,
		)
		GO
		CREATE TABLE DICHVU(
		MaDV INT CONSTRAINT MaDVIsKey PRIMARY KEY NOT NULL CONSTRAINT CheckMaDV  CHECK ( MaDV > 0) ,
		TenDV NVARCHAR(30) NOT NULL,
		DonGiaDV INT DEFAULT 0 NOT NULL  CONSTRAINT CheckDonGiaDV  CHECK ( DonGiaDV >= 0 AND DonGiaDV <= 2000000)
		)
		GO
		CREATE TABLE HANGSANXUAT(
		MaHSX INT CONSTRAINT MaHSXIsKey PRIMARY KEY NOT NULL CONSTRAINT CheckMaHSX  CHECK ( MaHSX > 0),
		TenHSX NVARCHAR(20) NOT NULL,
		SLGhe INT DEFAULT 0 NOT NULL CONSTRAINT CheckSLGhe CHECK ( SLGhe >= 0 AND SLGhe <= 300)
		)
		GO
		CREATE TABLE VE(
		MaVE INT CONSTRAINT MaVEIsKey PRIMARY KEY NOT NULL CONSTRAINT CheckMaVE  CHECK ( MaVE > 0),
		MaCB INT NULL,
		MaMB INT NULL,
		MaKH INT NULL,
		MaDV INT NULL,
		MaHD INT NULL,
		Ghe INT NOT NULL,
		DonGiaVe INT DEFAULT 0 NOT NULL,
		IsHuyVe VARCHAR(5) DEFAULT 'NO' NOT NULL CONSTRAINT CheckIsHuyVe CHECK ( IsHuyVe = 'YES' OR  IsHuyVe = 'NO')

		)
		GO
		CREATE TABLE MAYBAY(
		MaMB INT CONSTRAINT MaMBIsKey PRIMARY KEY NOT NULL CONSTRAINT CheckMaMB  CHECK ( MaMB > 0),
		TenMB NVARCHAR(20) NOT NULL,
		MaHHK INT NULL,
		MaHSX INT NULL
		)
		GO
		CREATE TABLE HOADON(
		MaHD INT CONSTRAINT MaHDIsKey PRIMARY KEY NOT NULL CONSTRAINT CheckMaHD  CHECK ( MaHD > 0),
		NgayGD DATE NOT NULL,
		ThanhTien INT DEFAULT 0 NOT NULL,
		IsHuyHD VARCHAR(5) DEFAULT 'NO' NOT NULL CONSTRAINT CheckIsHuyHD CHECK ( IsHuyHD = 'YES' OR  IsHuyHD = 'NO')
		)
		GO
		CREATE TABLE CHUYENBAY(
		MaCB INT CONSTRAINT MaCBIsKey PRIMARY KEY NOT NULL CONSTRAINT CheckMaCB  CHECK ( MaCB > 0),
		NoiDi INT NULL,
		NoiDen INT NULL,
		ThoiGianBay INT NOT NULL CONSTRAINT CheckThoiGianBay CHECK ( ThoiGianBay >= 45),
		TrangThai VARCHAR(5) DEFAULT 'ON' NOT NULL CONSTRAINT CheckTrangThai CHECK ( TrangThai = 'ON' OR  TrangThai = 'OFF'),
		)
		GO
		CREATE TABLE CHITIETCHUYENBAY(
		MaCB INT NOT NULL,
		MaMB INT NOT NULL,
		NgayBay DATE NOT NULL,
		GioBay Time NOT NULL,
		DonGia INT DEFAULT 0 NOT NULL ,
		SoVe INT DEFAULT 0 NOT NULL ,
		SoVeDaDat INT DEFAULT 0 NOT NULL,
		TrangThaiCB VARCHAR(5) DEFAULT 'ON' NOT NULL CONSTRAINT CheckTrangThaiCB CHECK ( TrangThaiCB = 'ON' OR  TrangThaiCB = 'OFF'), 

		CONSTRAINT MACB_MAMB_IS_KEY PRIMARY KEY (MaCB, MaMB)
		)
		GO
		CREATE TABLE HANGHANGKHONG(
		MaHHK INT CONSTRAINT MaHHKIsKey PRIMARY KEY NOT NULL  CONSTRAINT CheckMaHHK  CHECK ( MaHHK > 0),
		TenHHK NVARCHAR(20) NOT NULL,
		DonGiaHHK INT DEFAULT 0 NOT NULL  CONSTRAINT CheckDonGiaHHK  CHECK ( DonGiaHHK >= 0 AND DonGiaHHK <= 1500000)

		)
		GO
		CREATE TABLE THANHPHO(
		MaTP INT CONSTRAINT MaTPIsKey PRIMARY KEY NOT NULL CONSTRAINT CheckMaTP  CHECK ( MaTP > 0),
		TenTP NVARCHAR(30) NOT NULL,
		IsLocked VARCHAR(5) DEFAULT 'NO' NOT NULL CONSTRAINT CheckIsLocked CHECK ( IsLocked = 'NO' OR  IsLocked = 'YES')
		)
		GO
		CREATE TABLE SANBAY(
		MaSB INT  CONSTRAINT MaSBIsKey PRIMARY KEY NOT NULL CONSTRAINT CheckMaSB  CHECK ( MaSB > 0),
		TenSB NVARCHAR(30) NOT NULL,
		MaTP INT NULL,
		IsLockedSB VARCHAR(5) DEFAULT 'NO' NOT NULL CONSTRAINT CheckIsLockedSB CHECK ( IsLockedSB = 'NO' OR  IsLockedSB = 'YES')
		)
		GO 
-- TẠO KHÓA 
		GO
		ALTER TABLE dbo.VE ADD CONSTRAINT FK_CHITIETCHUYENBAY FOREIGN KEY (MaCB, MaMB) REFERENCES dbo.CHITIETCHUYENBAY(MaCB, MaMB) ON DELETE SET NULL ON UPDATE CASCADE
		GO
		--ALTER TABLE dbo.VE ADD CONSTRAINT FK_MaChuyenBay FOREIGN KEY (MaCB) REFERENCES dbo.CHUYENBAY ON DELETE CASCADE
		GO
		ALTER TABLE dbo.VE ADD CONSTRAINT FK_MaKhachHang FOREIGN KEY (MaKH) REFERENCES dbo.KHACHHANG ON DELETE SET NULL ON UPDATE CASCADE
		GO
		ALTER TABLE dbo.VE ADD CONSTRAINT FK_MaDichVu FOREIGN KEY (MaDV) REFERENCES dbo.DICHVU ON DELETE SET NULL ON UPDATE CASCADE
		GO
		ALTER TABLE dbo.VE ADD CONSTRAINT FK_MaHoaDon FOREIGN KEY (MaHD) REFERENCES dbo.HOADON ON DELETE SET NULL ON UPDATE CASCADE
		GO
		ALTER TABLE dbo.MAYBAY ADD CONSTRAINT FK_MaHangHangKhong FOREIGN KEY (MaHHK) REFERENCES dbo.HANGHANGKHONG ON DELETE SET NULL  ON UPDATE CASCADE
		GO
		ALTER TABLE dbo.MAYBAY ADD CONSTRAINT FK_MaHangSanXuat FOREIGN KEY (MaHSX) REFERENCES dbo.HANGSANXUAT ON DELETE SET NULL ON UPDATE CASCADE
		GO
		ALTER TABLE dbo.CHITIETCHUYENBAY ADD CONSTRAINT FK_MaMayBayCTCB FOREIGN KEY (MaMB) REFERENCES dbo.MAYBAY  ON UPDATE CASCADE
		GO
		ALTER TABLE dbo.CHITIETCHUYENBAY ADD CONSTRAINT FK_MaCB FOREIGN KEY (MaCB) REFERENCES dbo.CHUYENBAY  ON UPDATE CASCADE
		GO
		ALTER TABLE dbo.SANBAY ADD CONSTRAINT FK_MaThanhPho FOREIGN KEY (MaTP) REFERENCES dbo.THANHPHO ON DELETE SET NULL ON UPDATE CASCADE
		GO
		ALTER TABLE dbo.CHUYENBAY ADD CONSTRAINT FK_MaSanBay1 FOREIGN KEY (NoiDen) REFERENCES dbo.SANBAY   ON DELETE SET NULL ON UPDATE CASCADE
		GO
		ALTER TABLE dbo.CHUYENBAY ADD CONSTRAINT FK_MaSanBay2 FOREIGN KEY (NoiDi) REFERENCES dbo.SANBAY  --ON DELETE SET NULL ON UPDATE CASCADE
		GO
-- RÀNG BUỘC NOT NULL
	-- BẢNG VÉ
		GO
		ALTER TABLE dbo.VE ALTER COLUMN MaMB INT NOT NULL
		GO
		ALTER TABLE dbo.VE ALTER COLUMN MaKH INT NOT NULL
		GO
		ALTER TABLE dbo.VE ALTER COLUMN MaDV INT NOT NULL
		GO
		ALTER TABLE dbo.VE ALTER COLUMN MaCB INT NOT NULL
		GO
		ALTER TABLE dbo.VE ALTER COLUMN MaHD INT NOT NULL
		GO
	
	-- BẢNG CHUYẾN BAY
		ALTER TABLE dbo.CHUYENBAY ALTER COLUMN NoiDen INT NOT NULL
		GO
		ALTER TABLE dbo.CHUYENBAY ALTER COLUMN NoiDi INT NOT NULL
		GO
-- TẠO TRIGGER 
	-- TRIGGER BẢNG KHÁCH HÀNG
		--1 TẠO TRIGGER ĐẢM BẢO USERNAME KHÔNG TRÙNG NHAU
		CREATE TRIGGER KIEMTRAUSERNAME ON dbo.KHACHHANG FOR UPDATE, INSERT AS
		BEGIN 
		DECLARE @USERNAME  VARCHAR(16),@TEMP  INT
		SELECT @USERNAME = INSERTED.UserName  FROM INSERTED 
		SELECT @TEMP = COUNT(*) FROM dbo.KHACHHANG 
		WHERE UserName = @USERNAME 
		IF (@TEMP >1)
		BEGIN 
		PRINT N'TÊN ĐĂNG NHẬP ĐÃ TỒN TẠI'
		ROLLBACK TRANSACTION
		END
		END
		GO

		--2 TẠO TRIGGER ĐẢM BẢO USERNAME ÍT NHẤT 6 KÍ TỰ 
		CREATE TRIGGER KIEMTRADODAIUSERNAME ON dbo.KHACHHANG FOR UPDATE, INSERT AS
		BEGIN
		DECLARE @USERNAME  VARCHAR(16)
		SELECT @USERNAME = INSERTED.UserName FROM INSERTED
		IF (LEN(@USERNAME) < 6)
		BEGIN
		PRINT N'TÊN ĐĂNG NHẬP ÍT NHẤT 6 KÍ TỰ'
		ROLLBACK TRANSACTION
		END
		END
		GO

		--3 TẠO TRIGGER ĐẢM BẢO PASSWORD ÍT NHẤT 8 KÍ TỰ 
		CREATE TRIGGER KIEMTRADODAIMATKHAU ON dbo.KHACHHANG FOR UPDATE, INSERT AS
		BEGIN
		DECLARE @PASSWORD  VARCHAR(20)
		SELECT @PASSWORD = INSERTED.MatKhau FROM INSERTED
		IF (LEN(@PASSWORD) < 8)
		BEGIN
		PRINT N'MẬT KHẨU ÍT NHẤT 8 KÍ TỰ '
		ROLLBACK TRANSACTION
		END
		END
		GO

		--4 TẠO TRIGGER ĐẢM BẢO MẬT KHẨU CHỨA KÍ TỰ HOA, THƯỜNG VÀ SỐ
		CREATE TRIGGER KIEMTRAMATKHAU ON dbo.KHACHHANG FOR UPDATE, INSERT AS
		BEGIN
		DECLARE @MATKHAU  NVARCHAR(20), @I  INT, @HOA  INT, @THUONG  INT, @SO  INT , @TEMP  INT
		SELECT @MATKHAU = INSERTED.MatKhau FROM INSERTED
		SELECT @I = 0, @HOA = 0, @THUONG = 0, @SO = 0, @TEMP = 0
		WHILE (@I < LEN(@MATKHAU)) -- DUYỆT THEO ĐỘ DÀI CHUỖI
		BEGIN
			SELECT @I = @I + 1 
			SELECT @TEMP = ASCII( SUBSTRING(@MATKHAU, @I, 1)) -- LẤY TỪNG KÍ TỰ
		-- KIỂM TRA THEO THỨ TỰ SỐ, CHỮ HOA, CHỮ THƯỜNG
			IF(@TEMP >= 48 AND @TEMP <= 57)
			SELECT @SO = @SO + 1
			ELSE	
				IF (@TEMP >= 65 AND @TEMP <= 90)
				SELECT @HOA = @HOA +1 
				ELSE
					IF (@TEMP >= 97 AND @TEMP <= 122)
					SELECT @THUONG = @THUONG +1 
		END
		IF (@HOA = 0 OR @THUONG = 0 OR @SO = 0)
		BEGIN
		PRINT (N'MẬT KHẨU PHẢI CHỨA KÍ TỰ HOA, THƯỜNG VÀ SỐ')
		ROLLBACK TRANSACTION
		END
		END
		GO

		--5 TẠO TRIGGER ĐẢM BẢO SỐ ĐIỆN THOẠI KHÁCH HÀNG KHÁC NHAU
		CREATE TRIGGER KIEMTRASDT ON dbo.KHACHHANG FOR UPDATE, INSERT AS
		BEGIN
		DECLARE @SDT  VARCHAR(10), @TEMP  INT
		SELECT @SDT = INSERTED.SDT FROM INSERTED
		SELECT @TEMP = COUNT(*) FROM dbo.KHACHHANG
		WHERE @SDT = SDT
		IF (@TEMP > 1)
		BEGIN
		PRINT N'SỐ ĐIỆN THOẠI ĐÃ TỒN TẠI'
		ROLLBACK TRANSACTION
		END
		END
		GO

		--6 TẠO TRIGGER ĐẢM BẢO EMAIL CỦA KHÁCH HÀNG PHẢI KHÁC NHAU
		CREATE TRIGGER KIEMTRAEMAILXUATHIEN ON dbo.KHACHHANG FOR UPDATE, INSERT AS
		BEGIN
		DECLARE @EMAIL  VARCHAR(30), @TEMP  INT
		SELECT @EMAIL = INSERTED.EMAIL FROM INSERTED
		SELECT @TEMP = COUNT(*) FROM dbo.KHACHHANG
		WHERE @EMAIL = EMAIL
		IF(@TEMP > 1)
		BEGIN
		PRINT(N'EMAIL ĐÃ TỒN TẠI')
		ROLLBACK TRANSACTION
		END
		END
		GO

		--7 TẠO TRIGGER ĐẢM BẢO EMAIL CÓ @gmail.com
		CREATE TRIGGER KIEMTRATENEMAIL ON dbo.KHACHHANG FOR UPDATE, INSERT AS
		BEGIN
		DECLARE @EMAIL  VARCHAR(30)
		SELECT @EMAIL = INSERTED.EMAIL FROM INSERTED
		IF (CHARINDEX('@gmail.com',@EMAIL) = 0)
		BEGIN
		PRINT N'EMAIL PHẢI CHỨA @gmail.com'
		ROLLBACK TRANSACTION
		END
		END
		GO

	-- TRIGGER RÀNG BUỘC CHUYẾN BAY
		--8 TẠO TRIGGER ĐẢM BẢO NƠI ĐI KHÁC VỚI NƠI ĐẾN
		CREATE TRIGGER KIEMTRANOIDINOIDEN ON dbo.CHUYENBAY FOR UPDATE, INSERT AS
		BEGIN 
		DECLARE @NOIDI  INT, @NOIDEN  INT
		SELECT @NOIDI = INSERTED.NoiDi, @NOIDEN = INSERTED.NoiDen  FROM INSERTED 
		IF (@NOIDI =  @NOIDEN)
		BEGIN 
		PRINT N'NƠI ĐI PHẢI KHÁC NƠI ĐẾN'
		ROLLBACK TRANSACTION
		END
		END
		GO

		--9 TẠO TRIGGER ĐẢM BẢO TRẠNG THÁI CỦA THÀNH PHỐ ẢNH HƯỞNG TỚI CHUYẾN BAY
		CREATE TRIGGER KIEMTRATRANGTHAITHANHPHO ON dbo.THANHPHO AFTER UPDATE AS
		BEGIN
		DECLARE @TRANGTHAI  NVARCHAR(5), @MATP  INT
		SELECT @TRANGTHAI = INSERTED.IsLocked, @MATP = INSERTED.MaTP FROM INSERTED
		IF(@TRANGTHAI = 'NO')
		-- CÂU LỆNH
		BEGIN
		UPDATE  dbo.SANBAY 
		SET IsLockedSB = 'NO'
		WHERE @MATP = MaTP
		END
		-- LỆNH ELSE
		ELSE
		BEGIN
		UPDATE  dbo.SANBAY 
		SET IsLockedSB = 'YES'
		WHERE @MATP = MaTP
		END
		--------
		END
		GO

		--10 TẠO TRIGGER ĐẢM BẢO TRẠNG THÁI CỦA THÀNH PHỐ ẢNH HƯỞNG TỚI CHUYẾN BAY
		CREATE TRIGGER KIEMTRATRANGTHAISANBAY ON dbo.SANBAY AFTER UPDATE AS
		BEGIN
		DECLARE @TRANGTHAI  NVARCHAR(5), @MASB  INT
		SELECT @TRANGTHAI = INSERTED.IsLockedSB, @MASB = INSERTED.MaSB FROM INSERTED
		IF(@TRANGTHAI = 'NO')
		-- CÂU LỆNH
		BEGIN
		UPDATE  dbo.CHUYENBAY 
		SET TrangThai = 'ON'
		WHERE ( @MASB = NoiDen OR @MASB = NoiDi ) OR NoiDen in (SELECT MaSB FROM SANBAY WHERE @TRANGTHAI = IsLockedSB) 
							OR NoiDi in (SELECT MaSB FROM SANBAY WHERE @TRANGTHAI = IsLockedSB)
		END
		-- LỆNH ELSE
		ELSE
		BEGIN
		UPDATE  dbo.CHUYENBAY 
		SET TrangThai = 'OFF'
		WHERE @MASB = NoiDen OR @MASB = NoiDi  OR NoiDen in (SELECT MaSB FROM SANBAY WHERE @TRANGTHAI = IsLockedSB) 
							OR NoiDi in (SELECT MaSB FROM SANBAY WHERE @TRANGTHAI = IsLockedSB)
		END
		-----
		END
		GO

		--11 TẠO TRIGGER ĐẢM BẢO TRẠNG THÁI CỦA CHUYẾN BAY ẢNH HƯỞNG TỚI CHI TIẾT CHUYẾN BAY
		CREATE TRIGGER KIEMTRATRANGTHAICHUYENBAY ON dbo.CHUYENBAY AFTER UPDATE AS
		BEGIN
		DECLARE @TRANGTHAI  NVARCHAR(5), @MACB  INT
		SELECT @TRANGTHAI = INSERTED.TrangThai, @MACB = INSERTED.MaCB FROM INSERTED
		IF(@TRANGTHAI = 'ON')
		-- CÂU LỆNH
		BEGIN
		UPDATE  dbo.CHITIETCHUYENBAY 
		SET TrangThaiCB = 'ON'
		WHERE @MACB = MaCB OR MaCB in (SELECT MaCB FROM CHUYENBAY WHERE @TRANGTHAI = TrangThai) 
		END
		-- LỆNH ELSE
		ELSE
		BEGIN
		UPDATE  dbo.CHITIETCHUYENBAY 
		SET TrangThaiCB = 'OFF'
		WHERE @MACB = MaCB OR MaCB in (SELECT MaCB FROM CHUYENBAY WHERE @TRANGTHAI = TrangThai) 
		END
		-----
		END
		GO

		--12 TẠO TRIGGER ĐẢM BẢO KHI SỐ VÉ ĐÃ ĐẶT = SỐ VÉ CHUYẾN BAY SẼ OFF
		CREATE TRIGGER KIEMTRACHITIETCHUYENBAY ON dbo.CHITIETCHUYENBAY AFTER UPDATE AS
		BEGIN
		DECLARE @SOVEDADAT  INT, @SOVE  INT, @MACB  INT
		SELECT @SOVEDADAT = INSERTED.SoVeDaDat, @SOVE = INSERTED.SoVe, @MACB = INSERTED.MaCB FROM INSERTED
		IF(@SOVEDADAT = @SOVE)
		BEGIN
		UPDATE  dbo.CHITIETCHUYENBAY 
		SET TrangThaiCB = 'OFF'
		WHERE @MACB = MaCB
		END
		END
		GO

		--13 TẠO TRIGGER ĐẢM BẢO VÉ TRONG CÙNG MỘT CHUYẾN BAY KHÔNG CHUNG SỐ GHẾ
		CREATE TRIGGER KIEMTRASOGHE ON dbo.VE FOR UPDATE, INSERT AS
		BEGIN
		DECLARE @GHE  INT, @MACB  INT, @MAMB  INT, @TEMP  INT
		SELECT @GHE = INSERTED.Ghe, @MACB = INSERTED.MaCB, @MAMB = INSERTED.MaMB  FROM INSERTED
		SELECT @TEMP = COUNT(*) FROM dbo.VE	
		WHERE @GHE = GHE AND @MACB = MACB AND @MAMB = MAMB
		IF(@TEMP > 1)
		BEGIN
		PRINT(N'GHẾ ĐÃ ĐƯỢC ĐẶT')
		ROLLBACK TRANSACTION
		END
		END
		GO

	-- TRIGGER UPDATE DỮ LIỆU TỰ ĐỘNG
		--14 TRIGGER THÊM CHI TIẾT CHYẾN BAY THÌ TỰ CẬP NHẬT ĐƠN GIÁ VÀ TỰ CẬP NHẬT SỐ VÉ
		CREATE TRIGGER KHOITAOGIACHUYEBAY ON dbo.CHITIETCHUYENBAY AFTER INSERT, UPDATE AS
		BEGIN
		DECLARE @MACB INT, @MAMB  INT, @DONGIANEW INT, @DONGIAOLD INT, @SOVENEW INT, @SOVEOLD INT
		SELECT @MAMB = INSERTED.MaMB, @MACB = INSERTED.MaCB,@DONGIAOLD = INSERTED.DonGia, @SOVEOLD = INSERTED.DonGia FROM INSERTED 
		SELECT @DONGIANEW = (SELECT DonGiaHHK FROM dbo.HANGHANGKHONG WHERE MaHHK = (SELECT MaHHK FROM dbo.MAYBAY WHERE @MAMB = MaMB)) -- GIÁ THEO HÃNG HÀNG KHÔNG
		SELECT @SOVENEW =(SELECT SLGhe FROM dbo.HANGSANXUAT WHERE MaHSX = (SELECT MaHSX FROM dbo.MAYBAY WHERE @MAMB = MaMB)) -- SỐ GHẾ CỦA HÃNG SẢN XUẤT
		IF(@SOVENEW != @SOVEOLD OR @DONGIAOLD != @DONGIANEW)
		BEGIN
		UPDATE dbo.CHITIETCHUYENBAY
		SET DonGia = 500000 + @DONGIANEW, SoVe = @SOVENEW  -- MẶC ĐỊNH PHÍ 500K CHO MỖI CHUYẾN BAY
		WHERE @MAMB = MaMB AND @MACB = MaCB
		END
		END
		GO

		--15 TRIGGER THAY ĐỔI GIÁ HÃNG HÀNG KHÔNG THÌ THAY ĐỔI GIÁ CHUYẾN BAY
		CREATE TRIGGER DOIGIAHHKDOIGIACHUYEBAY ON dbo.HANGHANGKHONG AFTER UPDATE AS
		BEGIN
		DECLARE @MAHHK  INT, @DONGIAOLD  INT, @DONGIANEW  INT
		SELECT @MAHHK = INSERTED.MaHHK, @DONGIANEW = INSERTED.DonGiaHHK, @DONGIAOLD = DELETED.DonGiaHHK FROM INSERTED,DELETED
		IF (@DONGIAOLD != @DONGIANEW)
		BEGIN
		UPDATE dbo.CHITIETCHUYENBAY
		SET DonGia = @DONGIANEW + 500000
		WHERE dbo.CHITIETCHUYENBAY.MaMB in (SELECT MaMB FROM dbo.MAYBAY WHERE MaHHK = @MaHHK) -- LẤY TẤT CẢ CÁC CHUYẾN BAY CÓ MÁY BAY CỦA HÃNG
		END
		END
		GO

		--16 TRIGGER HÃNG SẢN XUẤT THAY ĐỔI SỐ GHẾ TỰ CẬP NHẬT SỐ VÉ CHUYẾN BAY
		CREATE TRIGGER CAPNHATSOGHE ON dbo.HANGSANXUAT AFTER UPDATE AS
		BEGIN
		DECLARE @MAHSX  INT, @SLGHEOLD INT, @SLGHENEW INT
		SELECT @MAHSX = INSERTED.MaHSX ,  @SLGHEOLD = DELETED.SLGhe, @SLGHENEW = INSERTED.SLGhe FROM INSERTED,DELETED
		IF(@SLGHEOLD != @SLGHENEW)
		BEGIN
		UPDATE dbo.CHITIETCHUYENBAY
		SET SoVe = @SLGHENEW 
		WHERE  dbo.CHITIETCHUYENBAY.MaMB in (SELECT MaMB FROM dbo.MAYBAY WHERE MaHSX = @MAHSX) -- LẤY TẤT CẢ CÁC CHUYẾN BAY CÓ MÁY BAY CỦA HÃNG
		END
		END
		GO

--TRIGGER Phân quyền user
	--1. Tạo login và user mới
	CREATE TRIGGER PHANQUYENUSER ON dbo.KHACHHANG AFTER INSERT AS
	BEGIN TRAN
	DECLARE @TaiKhoan NVARCHAR(16), @MatKhau NVARCHAR(20), @query NVARCHAR(1000)
	SELECT @TaiKhoan = INSERTED.UserName, @MatKhau = INSERTED.MatKhau FROM INSERTED
	SELECT @query = N'create login '+ @TaiKhoan + ' with password ='+ char(39)+ @MatKhau + char(39) 
	exec sp_executesql @query
	SELECT @query = 'create user '+ @TaiKhoan + ' for login '+ @TaiKhoan
	exec sp_executesql @query
	exec sp_addrolemember 'User_role', @TaiKhoan
		
	IF(@@ERROR <>0)
					BEGIN
						RAISERROR('EROR', 16,1)
						ROLLBACK
						RETURN
					END
	COMMIT TRAN
	GO

	--2. Đổi tài khoản 
	CREATE TRIGGER UPDATEUSER ON dbo.KHACHHANG AFTER UPDATE AS
	BEGIN TRAN
	DECLARE @TaiKhoanCu NVARCHAR(16), @TaiKhoan NVARCHAR(16), @MatKhauCu NVARCHAR(20), @MatKhau NVARCHAR(20), @query NVARCHAR(1000)
	SELECT @TaiKhoanCu = DELETED.UserName, @MatKhauCu = DELETED.MatKhau, @TaiKhoan = INSERTED.UserName, @MatKhau = INSERTED.MatKhau FROM INSERTED, DELETED
	IF(@MatKhauCu != @MatKhau)
	BEGIN
		SELECT @query = N'ALTER LOGIN '+ @TaiKhoanCu + ' WITH PASSWORD ='+ char(39)+ @MatKhau + char(39)
		exec sp_executesql @query
	END
	IF(@TaiKhoanCu != @TaiKhoan)
	BEGIN
		SELECT @query = N'ALTER LOGIN '+ @TaiKhoanCu + ' WITH NAME ='+ @TaiKhoan
		exec sp_executesql @query
		SELECT @query = N'ALTER USER '+ @TaiKhoanCu + ' WITH NAME ='+ @TaiKhoan
		exec sp_executesql @query
	END
	IF(@@ERROR <>0)
					BEGIN
						RAISERROR('EROR', 16,1)
						ROLLBACK
						RETURN
					END
	COMMIT TRAN
	GO
	
	

-- TẠO CÁC VIEW
	--1. Lấy dữ liệu bảng chuyến bay
		CREATE VIEW INFOCHUYENBAY
		as
		select * from CHUYENBAY
		GO
		
		--2. Lấy dữ liệu bảng chi tiết chuyến bay
		CREATE VIEW INFOCHITIETCHUYENBAY
		as
		select * from CHITIETCHUYENBAY
		GO

		--3. Lấy dữ liệu bảng vé
		CREATE VIEW INFOVE
		as
			select * from VE
		GO
		
		--4. Lấy dữ liệu bảng khách hàng
		CREATE VIEW INFOKHACHHANG
		as
			select * from KHACHHANG
		GO

		--5. Lấy dữ liệu bảng dịch vụ
		CREATE VIEW INFODICHVU
		as
		select * from DICHVU
		GO

		
		--6. Lấy dữ liệu bảng máy bay
		CREATE VIEW INFOMAYBAY
		as
		select * from MAYBAY
		GO
	
	
		--7. Lấy dữ liệu bảng sân bay
		CREATE VIEW INFOSANBAY
		as
		select * from SANBAY 
		GO

		--8. Lấy dữ liệu bảng thành phố
		CREATE VIEW INFOTHANHPHO
		as
		select * from THANHPHO 
		GO
		
		--9. Lấy dữ liệu bảng hãng sản xuất
		CREATE VIEW INFOHANGSANXUAT
		as
		select * from HANGSANXUAT 
		GO

		--10. Lấy dữ liệu bảng hãng hàng không
		CREATE VIEW INFOHANGHANGKHONG
		as
		select * from HANGHANGKHONG 
		GO

		--11. Lấy dữ liệu bảng hóa đơn
		CREATE VIEW INFOHOADON
		as
		select * from HOADON 
		GO

	

		
-- Admin
	-- Procedure
		-- Bảng khách hàng
			--1. Thêm khách hàng
			CREATE PROCEDURE INSERTKHACHHANG
			@MaKH INT, 
			@TenKH NVARCHAR(50),
			@NgaySinh DATE,
			@DiaChi NVARCHAR(50) ,
			@GioiTinh NVARCHAR(5) ,
			@SDT VARCHAR(10) ,
			@EMAIL VARCHAR(30) ,
			@UserName VARCHAR(16) ,
			@MatKhau VARCHAR(20) 
			AS 
			BEGIN TRAN
				INSERT INTO KHACHHANG (MaKH, TenKH, NgaySinh , DiaChi, GioiTinh, SDT, EMAIL, UserName, MatKhau)
				VALUES ( @MaKH , @TenKH ,@NgaySinh, @DiaChi, @GioiTinh, @SDT ,@EMAIL, @UserName, @MatKhau)
				IF(@@ERROR <>0)
					BEGIN
						RAISERROR('EROR', 16,1)
						ROLLBACK
						RETURN
					END
			COMMIT TRAN
			GO
			
			--2. Sửa thông tin khách hàng
			CREATE PROCEDURE UPDATEKHACHHANG
			@MaKH INT, 
			@TenKH NVARCHAR(50),
			@NgaySinh DATE,
			@DiaChi NVARCHAR(50) ,
			@GioiTinh NVARCHAR(5) ,
			@SDT VARCHAR(10) ,
			@EMAIL VARCHAR(30) ,
			@UserName VARCHAR(16),
			@MatKhau VARCHAR(20) 
			AS 
			BEGIN TRAN
				UPDATE KHACHHANG
				SET 
				TenKH =@TenKH, NgaySinh =@NgaySinh, DiaChi =@DiaChi, GioiTinh =@GioiTinh, SDT = @SDT, EMAIL =@EMAIL, UserName =@UserName, MatKhau = @MatKhau
				WHERE MaKH =@MaKH
				IF(@@ERROR <>0)
					BEGIN
						RAISERROR('EROR', 16,1)
						ROLLBACK
						RETURN
					END
			COMMIT TRAN
			GO
			
			--3. Xóa khách hàng
			CREATE  PROCEDURE DELETEKHACHHANG
			@MaKH INT
			AS 
			BEGIN TRAN
				DELETE FROM KHACHHANG 
				WHERE MaKH = @MaKH
				IF(@@ERROR <>0)
					BEGIN
						RAISERROR('EROR', 16,1)
						ROLLBACK
						RETURN
					END
			COMMIT TRAN
			GO
			
			--4. Tìm khách hàng
			CREATE PROCEDURE FINDKHACHHANG
			@MaKH INT, 
			@TenKH NVARCHAR(50),
			@NgaySinh VARCHAR(50),
			@DiaChi NVARCHAR(50) ,
			@GioiTinh NVARCHAR(5) ,
			@SDT VARCHAR(10) ,
			@EMAIL VARCHAR(30) ,
			@UserName VARCHAR(16) ,
			@MatKhau VARCHAR(20) 
			AS 
			BEGIN
			SELECT KHACHHANG.* FROM KHACHHANG 
			WHERE (@MaKH = -1 OR KHACHHANG.MaKH  = @MaKH)
			AND (@TenKH = N'-1' OR KHACHHANG.TenKH LIKE '%'+ @TenKH +'%')
			AND (@NgaySinh = '-1' OR (Convert(varchar(50), KHACHHANG.NgaySinh, 126) like '%'+@NgaySinh +'%'))
			AND (@DiaChi = N'-1' OR KHACHHANG.DiaChi LIKE '%'+ @DiaChi +'%')
			AND (@GioiTinh = N'-1' OR KHACHHANG.GioiTinh LIKE '%'+ @GioiTinh +'%')
			AND (@SDT = '-1' OR KHACHHANG.SDT LIKE '%'+ @SDT +'%')
			AND (@EMAIL = '-1' OR KHACHHANG.EMAIL LIKE '%'+ @EMAIL +'%')
			AND (@UserName = '-1' OR KHACHHANG.UserName LIKE '%'+ @UserName +'%')
			AND (@MatKhau = '-1' OR KHACHHANG.MatKhau LIKE '%'+ @MatKhau +'%')
			END
			GO
						
		
		-- BẢNG DỊCH VỤ
			--5. Thêm dịch vụ
			CREATE PROCEDURE INSERTDICHVU
			@MaDV INT,
			@TenDV NVARCHAR(30),
			@DonGiaDV INT
			AS
			BEGIN TRAN
				INSERT INTO DICHVU (MaDV, TenDV, DonGiaDV)
				VALUES (@MaDV , @TenDV, @DonGiaDV)
				IF(@@ERROR <>0)
					BEGIN
						RAISERROR('EROR', 16,1)
						ROLLBACK
						RETURN
					END
			COMMIT TRAN
			GO
			
			--6. Sửa dịch vụ
			CREATE PROCEDURE UPDATEDICHVU
			@MaDV INT,
			@TenDV NVARCHAR(30),
			@DonGiaDV INT
			AS
			BEGIN TRAN
				UPDATE DICHVU
				SET TenDV =@TenDV, DonGiaDV =@DonGiaDV
				WHERE MaDV =@MaDV
				IF(@@ERROR <>0)
					BEGIN
						RAISERROR('EROR', 16,1)
						ROLLBACK
						RETURN
					END
			COMMIT TRAN 
			GO
			
			--7. Xóa dịch vụ
			CREATE PROCEDURE DELETEDICHVU
			@MaDV INT
			AS
			BEGIN TRAN
				DELETE FROM DICHVU
				WHERE MaDV =@MaDV
				IF(@@ERROR <>0)
					BEGIN
						RAISERROR('EROR', 16,1)
						ROLLBACK
						RETURN
					END
			COMMIT TRAN 
			GO
			
			--8. Tìm dịch vụ
			CREATE PROCEDURE FINDDICHVU
			@MaDV INT,
			@TenDV NVARCHAR(30),
			@DonGiaDV INT
			AS
			BEGIN
			SELECT DICHVU.* FROM DICHVU
			WHERE (@MaDV = -1 OR DICHVU.MaDV =@MaDV)
			AND (@TenDV = N'-1' OR DICHVU.TenDV like '%' + @TenDV +'%')
			AND (@DonGiaDV = -1 OR DICHVU.DonGiaDV = @DonGiaDV)
			END 
			GO

		--BẢNG HÃNG SẢN XUẤT
			--9. Thêm hãng sản xuất
			CREATE PROCEDURE INSERTHANGSANXUAT
			@MaHSX INT,
			@TenHSX NVARCHAR(20),
			@SLGhe INT
			AS
			BEGIN TRAN
				INSERT INTO HANGSANXUAT(MaHSX, TenHSX, SLGhe)
				VALUES (@MaHSX, @TenHSX,@SLGhe)
				IF(@@ERROR <>0)
					BEGIN
						RAISERROR('EROR', 16,1)
						ROLLBACK
						RETURN
					END
			COMMIT TRAN 
			GO
			--10. Sửa hãng sản xuất
			CREATE PROCEDURE UPDATEHANGSANXUAT
			@MaHSX INT,
			@TenHSX NVARCHAR(20),
			@SLGhe INT
			AS
			BEGIN TRAN
				UPDATE HANGSANXUAT
				SET TenHSX =@TenHSX, SLGhe =@SLGhe
				WHERE MaHSX =@MaHSX
				IF(@@ERROR <>0)
					BEGIN
						RAISERROR('EROR', 16,1)
						ROLLBACK
						RETURN
					END
			COMMIT TRAN 
			GO
			--11. Xóa hãng sản xuất
			CREATE PROCEDURE DELETEHANGSANXUAT
			@MaHSX INT
			AS
			BEGIN TRAN
				DELETE FROM HANGSANXUAT
				WHERE MaHSX =@MaHSX
				IF(@@ERROR <>0)
					BEGIN
						RAISERROR('EROR', 16,1)
						ROLLBACK
						RETURN
					END
			COMMIT TRAN
			GO
			--12. Tìm hãng sản xuất
			CREATE PROCEDURE FINDHANGSANXUAT
			@MaHSX INT,
			@TenHSX NVARCHAR(20),
			@SLGhe INT
			AS
			BEGIN
			SELECT HANGSANXUAT.* FROM HANGSANXUAT
			WHERE (@MaHSX = -1 OR HANGSANXUAT.MaHSX = @MaHSX)
			AND (@TenHSX = N'-1' OR HANGSANXUAT.TenHSX Like '%' + @TenHSX +'%')
			AND (@SLGhe = -1 OR HANGSANXUAT.SLGhe = @SLGhe)
			END 
			GO
			
		--BẢNG VÉ
			--13. Thêm vé
			CREATE PROCEDURE INSERTVE
			@MaVE INT,
			@MaCB INT,
			@MaMB INT,
			@MaKH INT,
			@MaDV INT,
			@MaHD INT,
			@Ghe INT,
			@IsHuyVe VARCHAR(5)
			AS
			BEGIN TRAN
				INSERT INTO VE ( MaVE, MaCB, MaMB, MaKH,MaDV,MaHD,Ghe, IsHuyVe)
				VALUES (@MaVE , @MaCB, @MaMB, @MaKH, @MaDV, @MaHD, @Ghe, @IsHuyVe)
				IF(@@ERROR <>0)
					BEGIN
						RAISERROR('EROR', 16,1)
						ROLLBACK
						RETURN
					END
			COMMIT TRAN 
			GO
			--14. Sửa vé
			CREATE PROCEDURE UPDATEVE
			@MaVE INT,
			@MaCB INT,
			@MaMB INT,
			@MaKH INT,
			@MaDV INT,
			@MaHD INT,
			@Ghe INT,
			@IsHuyVe VARCHAR(5)
			AS
			BEGIN TRAN
				UPDATE VE
				SET MaCB =@MaCB, MaMB = @MaMB, MaKH =@MaKH, MaDV =@MaDV, MaHD =@MaHD, Ghe = @Ghe, IsHuyVe = @IsHuyVe
				WHERE MaVE =@MaVE
				IF(@@ERROR <>0)
					BEGIN
						RAISERROR('EROR', 16,1)
						ROLLBACK
						RETURN
					END
			COMMIT TRAN 
			GO
			--15. Xóa vé
			CREATE PROCEDURE DELETEVE
			@MaVE INT
			AS
			BEGIN TRAN
				DELETE FROM VE
				WHERE MaVE =@MaVE
				IF(@@ERROR <>0)
					BEGIN
						RAISERROR('EROR', 16,1)
						ROLLBACK
						RETURN
					END
			COMMIT TRAN 
			GO
			--16. Tìm vé
			CREATE PROCEDURE FINDVE
			@MaVE INT,
			@MaCB INT,
			@MaMB INT,
			@MaKH INT,
			@MaDV INT,
			@MaHD INT,
			@Ghe INT,
			@IsHuyVe VARCHAR(5)
			AS
			BEGIN
			SELECT VE.* FROM VE
			WHERE (@MaVE = -1 OR VE.MaVE = @MaVE)
			AND (@MaCB = -1 OR VE.MaCB = @MaCB)
			AND (@MaMB = -1 OR VE.MaMB = @MaMB)
			AND (@MaKH = -1 OR VE.MaKH = @MaKH)
			AND (@MaDV = -1 OR VE.MaDV = @MaDV)
			AND (@MaHD = -1 OR VE.MaHD = @MaHD)
			AND (@Ghe = -1 OR VE.Ghe =  @Ghe)
			AND (@IsHuyVe = N'-1' OR VE.IsHuyVe = @IsHuyVe)
			END 
			GO

		--BẢNG MÁY BAY
			--17. Thêm máy bay
			CREATE PROCEDURE INSERTMAYBAY
			@MaMB INT,
			@TenMB NVARCHAR(20),
			@MaHHK INT,
			@MaHSX INT
			AS 
			BEGIN TRAN
				INSERT INTO MAYBAY (MaMB, TenMB, MaHHK, MaHSX)
				VALUES (@MaMB, @TenMB,@MaHHK, @MaHSX)
				IF(@@ERROR <>0)
					BEGIN
						RAISERROR('EROR', 16,1)
						ROLLBACK
						RETURN
					END
			COMMIT TRAN 
			GO
			--18. Sửa máy bay
			CREATE PROCEDURE UPDATEMAYBAY
			@MaMB INT,
			@TenMB NVARCHAR(20),
			@MaHHK INT,
			@MaHSX INT
			AS 
			BEGIN TRAN
				UPDATE MAYBAY
				SET TenMB=@TenMB, MaHHK= @MaHHK, MaHSX =@MaHSX
				WHERE MaMB =@MaMB
				IF(@@ERROR <>0)
					BEGIN
						RAISERROR('EROR', 16,1)
						ROLLBACK
						RETURN
					END
			COMMIT TRAN 
			GO
			--19. Xóa máy bay
			CREATE PROCEDURE DELETEMAYBAY
			@MaMB INT
			AS 
			BEGIN TRAN
				DELETE FROM MAYBAY
				WHERE MaMB =@MaMB
				IF(@@ERROR <>0)
					BEGIN
						RAISERROR('EROR', 16,1)
						ROLLBACK
						RETURN
					END
			COMMIT TRAN 
			GO
			--20. Tìm máy bay
			CREATE PROCEDURE FINDMAYBAY
			@MaMB INT,
			@TenMB NVARCHAR(20),
			@MaHHK INT,
			@MaHSX INT
			AS 
			BEGIN
			SELECT MAYBAY.* FROM MAYBAY
			WHERE (@MaMB = -1 OR MAYBAY.MaMB = @MaMB)
			AND (@TenMB = N'-1' OR MAYBAY.TenMB like '%' + @TenMB +'%')
			AND (@MaHHK = -1 OR MAYBAY.MaHHK = @MaHHK )
			AND (@MaHSX = -1 OR MAYBAY.MaHSX = @MaHSX)
			END 
			GO

		--BẢNG HÓA ĐƠN
			--21. Thêm hóa đơn 
			CREATE PROCEDURE INSERTHOADON
			@MaHD INT,
			@NgayGD DATE,
			@ThanhTien INT,
			@IsHuyHD VARCHAR(5)
			AS 
			BEGIN TRAN
				INSERT INTO HOADON(MaHD, NgayGD, ThanhTien, IsHuyHD)
				VALUES (@MaHD, @NgayGD, @ThanhTien, @IsHuyHD)
				IF(@@ERROR <>0)
					BEGIN
						RAISERROR('EROR', 16,1)
						ROLLBACK
						RETURN
					END
			COMMIT TRAN 
			GO
			--22. Sửa hóa đơn
			CREATE PROCEDURE UPDATEHOADON
			@MaHD INT,
			@NgayGD DATE,
			@ThanhTien INT,
			@IsHuyHD VARCHAR(5)
			AS 
			BEGIN TRAN
				UPDATE HOADON
				SET NgayGD =@NgayGD, ThanhTien= @ThanhTien, IsHuyHD = @IsHuyHD
				WHERE MaHD = @MaHD
				IF(@@ERROR <>0)
					BEGIN
						RAISERROR('EROR', 16,1)
						ROLLBACK
						RETURN
					END
			COMMIT TRAN 
			GO
			--23. Xóa hóa đơn 
			CREATE PROCEDURE DELETEHOADON
			@MaHD INT
			AS  
			BEGIN TRAN
				DELETE FROM HOADON
				WHERE MaHD =@MaHD
				IF(@@ERROR <>0)
					BEGIN
						RAISERROR('EROR', 16,1)
						ROLLBACK
						RETURN
					END
			COMMIT TRAN 
			GO
			--24. Tìm hóa đơn
			CREATE PROCEDURE FINDHOADON
			@MaHD INT,
			@NgayGD VARCHAR(50),
			@ThanhTien INT,
			@IsHuyHD VARCHAR(5)
			AS 
			BEGIN
			SELECT HOADON.* FROM HOADON
			WHERE (@MaHD = -1 OR HOADON.MaHD = @MaHD)
			AND (@NgayGD = N'-1' OR (Convert(varchar(50),  HOADON.NgayGD, 126) like '%'+@NgayGD +'%'))
			AND (@ThanhTien = -1 OR HOADON.ThanhTien =@ThanhTien)
			AND (@IsHuyHD = N'-1' OR HOADON.IsHuyHD = @IsHuyHD)
			END 
			GO

		--BẢNG CHUYẾN BAY
			--25. Thêm chuyến bay
			CREATE PROCEDURE INSERTCHUYENBAY
			@MaCB INT,
			@NoiDi INT,
			@NoiDen INT,
			@ThoiGianBay INT,
			@TrangThai VARCHAR(5)
			AS
			BEGIN TRAN
				INSERT INTO CHUYENBAY (MaCB,NoiDi, NoiDen,ThoiGianBay,TrangThai)
				VALUES (@MaCB, @NoiDi, @NoiDen, @ThoiGianBay, @TrangThai)
				IF(@@ERROR <>0)
					BEGIN
						RAISERROR('EROR', 16,1)
						ROLLBACK
						RETURN
					END
			COMMIT TRAN
			GO
			--26. Sửa chuyến bay
			CREATE PROCEDURE UPDATECHUYENBAY
			@MaCB INT,
			@NoiDi INT,
			@NoiDen INT,
			@ThoiGianBay INT,
			@TrangThai VARCHAR(5)
			AS
			BEGIN TRAN
				UPDATE CHUYENBAY
				SET NoiDi =@NoiDi, NoiDen= @NoiDen, ThoiGianBay= @ThoiGianBay, TrangThai =@TrangThai
				WHERE MaCB =@MaCB
				IF(@@ERROR <>0)
					BEGIN
						RAISERROR('EROR', 16,1)
						ROLLBACK
						RETURN
					END
			COMMIT TRAN
			GO
			--27. Xóa chuyến bay
			CREATE PROCEDURE DELETECHUYENBAY
			@MaCB INT
			AS
			BEGIN TRAN
				DELETE FROM CHUYENBAY
				WHERE MaCB =@MaCB
				IF(@@ERROR <>0)
					BEGIN
						RAISERROR('EROR', 16,1)
						ROLLBACK
						RETURN
					END
			COMMIT TRAN
			GO
			--28. Tìm chuyến bay
			CREATE PROCEDURE FINDCHUYENBAY
			@MaCB INT,
			@NoiDi INT,
			@NoiDen INT,
			@ThoiGianBay INT,
			@TrangThai VARCHAR(5)
			AS
			BEGIN
			SELECT CHUYENBAY.* FROM CHUYENBAY
			WHERE (@MaCB = -1 OR CHUYENBAY.MaCB =  @MaCB )
			AND (@NoiDi = -1 OR CHUYENBAY.NoiDi =  @NoiDi)
			AND (@NoiDen = -1 OR CHUYENBAY.NoiDen =  @NoiDen)
			AND (@ThoiGianBay = -1 OR CHUYENBAY.ThoiGianBay =  @ThoiGianBay)
			AND (@TrangThai = N'-1' OR CHUYENBAY.TrangThai = @TrangThai)
			END
			GO

		--BẢNG CHI TIẾT CHUYẾN BAY
			--29. Thêm chi tiết chuyến bay
			CREATE PROCEDURE INSERTCHITIETCHUYENBAY
			@MaCB INT,
			@MaMB INT,
			@NgayBay DATE,
			@GioBay Time,
			@DonGia INT,
			@SoVe INT,
			@SoVeDaDat INT,
			@TrangThaiCB VARCHAR(5)
			AS
			BEGIN TRAN
				INSERT INTO CHITIETCHUYENBAY(MaCB, MaMB,NgayBay,GioBay,DonGia,SoVe,SoVeDaDat,TrangThaiCB)
				VALUES (@MaCB, @MaMB, @NgayBay,@GioBay, @DonGia, @SoVe, @SoVeDaDat,@TrangThaiCB)
				IF(@@ERROR <>0)
					BEGIN
						RAISERROR('EROR', 16,1)
						ROLLBACK
						RETURN
					END
			COMMIT TRAN
			GO
			--30. Sửa chi tiết chuyến bay
			CREATE PROCEDURE UPDATECHITIETCHUYENBAY
			@MaCB INT,
			@MaMB INT,
			@NgayBay DATE,
			@GioBay Time,
			@DonGia INT,
			@SoVe INT,
			@SoVeDaDat INT,
			@TrangThaiCB VARCHAR(5)
			AS
			BEGIN TRAN
				UPDATE CHITIETCHUYENBAY
				SET MaMB =@MaMB, NgayBay=@NgayBay, GioBay =@GioBay, DonGia=@DonGia,SoVe =@SoVe,SoVeDaDat =@SoVeDaDat,TrangThaiCB =@TrangThaiCB
				WHERE MaCB =@MaCB AND MaMB = @MaMB
				IF(@@ERROR <>0)
					BEGIN
						RAISERROR('EROR', 16,1)
						ROLLBACK
						RETURN
					END
			COMMIT TRAN
			GO
			--31. Xóa chi tiết chuyến bay
			CREATE PROCEDURE DELETECHITIETCHUYENBAY
			@MaCB INT,
			@MaMB INT
			AS
			BEGIN TRAN
				DELETE FROM CHITIETCHUYENBAY
				WHERE MaCB =@MaCB AND MaMB = @MaMB
				IF(@@ERROR <>0)
					BEGIN
						RAISERROR('EROR', 16,1)
						ROLLBACK
						RETURN
					END
			COMMIT TRAN
			GO
			--32. Tìm chi tiết chuyến bay
			CREATE PROCEDURE FINDCHITIETCHUYENBAY
			@MaCB INT,
			@MaMB INT,
			@NgayBay VARCHAR(50),
			@GioBay VARCHAR(50),
			@DonGia INT,
			@SoVe INT,
			@SoVeDaDat INT,
			@TrangThaiCB VARCHAR(5)
			AS
			BEGIN
			SELECT CHITIETCHUYENBAY.* FROM CHITIETCHUYENBAY
			WHERE (@MaCB = -1 OR CHITIETCHUYENBAY.MaCB = @MaCB )
			AND (@MaMB = -1 OR CHITIETCHUYENBAY.MaMB = @MaMB)
			AND (@NgayBay = N'-1' OR  (Convert(varchar(50),  CHITIETCHUYENBAY.NgayBay, 126) like '%'+@NgayBay +'%'))
			AND (@GioBay = N'-1' OR  (Convert(varchar(50), CHITIETCHUYENBAY.GioBay, 126) like '%'+@GioBay +'%'))
			AND (@DonGia = -1 OR CHITIETCHUYENBAY.DonGia =  @DonGia )
			AND (@SoVe = -1 OR CHITIETCHUYENBAY.SoVe =  @SoVe )
			AND (@SoVeDaDat = -1 OR CHITIETCHUYENBAY.SoVeDaDat =  @SoVeDaDat)
			AND (@TrangThaiCB = N'-1' OR CHITIETCHUYENBAY.TrangThaiCB = @TrangThaiCB)
			END
			GO

		-- BẢNG HÃNG HÀNG KHÔNG
			--33. Thêm hãng hàng không
			CREATE PROCEDURE INSERTHANGHANGKHONG
			@MaHHK INT,
			@TenHHK NVARCHAR(20),
			@DonGiaHHK INT
			AS
			BEGIN TRAN
				INSERT INTO HANGHANGKHONG (MaHHK, TenHHK, DonGiaHHK)
				VALUES (@MaHHK, @TenHHK, @DonGiaHHK)
				IF(@@ERROR <>0)
					BEGIN
						RAISERROR('EROR', 16,1)
						ROLLBACK
						RETURN
					END
			COMMIT TRAN 
			GO
			--34. Sửa hãng hàng không
			CREATE PROCEDURE UPDATEHANGHANGKHONG
			@MaHHK INT,
			@TenHHK NVARCHAR(20),
			@DonGiaHHK INT
			AS
			BEGIN TRAN
				UPDATE HANGHANGKHONG
				SET TenHHK =@TenHHK, DonGiaHHK=@DonGiaHHK
				WHERE MaHHK =@MaHHK
				IF(@@ERROR <>0)
					BEGIN
						RAISERROR('EROR', 16,1)
						ROLLBACK
						RETURN
					END
			COMMIT TRAN 
			GO
			--35. Xóa hãng hàng không
			CREATE PROCEDURE DELETEHANGHANGKHONG
			@MaHHK INT
			AS
			BEGIN TRAN
				DELETE FROM HANGHANGKHONG
				WHERE MaHHK=@MaHHK
				IF(@@ERROR <>0)
					BEGIN
						RAISERROR('EROR', 16,1)
						ROLLBACK
						RETURN
					END
			COMMIT TRAN 
			GO
			--36. Tìm hãng hàng không
			CREATE PROCEDURE FINDHANGHANGKHONG
			@MaHHK INT,
			@TenHHK NVARCHAR(20),
			@DonGiaHHK INT
			AS
			BEGIN
			SELECT HANGHANGKHONG.* FROM HANGHANGKHONG
			WHERE (@MaHHK = -1 OR HANGHANGKHONG.MaHHK = @MaHHK)
			AND (@TenHHK = N'-1' OR HANGHANGKHONG.TenHHK like '%' + @TenHHK +'%')
			AND (@DonGiaHHK = -1 OR HANGHANGKHONG.DonGiaHHK = @DonGiaHHK )
			END 
			GO

		--BẢNG THÀNH PHỐ
			--37. Thêm thành phố
			CREATE PROCEDURE INSERTTHANHPHO
			@MaTP INT,
			@TenTP NVARCHAR(30),
			@IsLocked VARCHAR(5)
			AS
			BEGIN TRAN
				INSERT INTO THANHPHO (MaTP, TenTP, IsLocked)
				VALUES (@MaTP, @TenTP, @IsLocked)
				IF(@@ERROR <>0)
					BEGIN
						RAISERROR('EROR', 16,1)
						ROLLBACK
						RETURN
					END
			COMMIT TRAN
			GO
			--38. Sửa thành phố
			CREATE PROCEDURE UPDATETHANHPHO
			@MaTP INT,
			@TenTP NVARCHAR(30),
			@IsLocked VARCHAR(5)
			AS
			BEGIN TRAN
				UPDATE THANHPHO
				SET TenTP =@TenTP, IsLocked= @IsLocked
				WHERE MaTP= @MaTP
				IF(@@ERROR <>0)
					BEGIN
						RAISERROR('EROR', 16,1)
						ROLLBACK
						RETURN
					END
			COMMIT TRAN
			GO
			--39. Xóa thành phố
			CREATE PROCEDURE DELETETHANHPHO
			@MaTP INT
			AS
			BEGIN TRAN
				DELETE FROM THANHPHO
				WHERE MaTP = @MaTP
				IF(@@ERROR <>0)
					BEGIN
						RAISERROR('EROR', 16,1)
						ROLLBACK
						RETURN
					END
			COMMIT TRAN
			GO
			--40. Tìm thành phố
			CREATE PROCEDURE FINDTHANHPHO
			@MaTP INT,
			@TenTP NVARCHAR(30),
			@IsLocked VARCHAR(5)
			AS
			BEGIN 
			SELECT THANHPHO.* FROM THANHPHO
			WHERE (@MaTP = -1 OR THANHPHO.MaTP =  @MaTP )
			AND (@TenTP = N'-1' OR THANHPHO.TenTP like '%' + @TenTP +'%')
			AND (@IsLocked = N'-1' OR THANHPHO.IsLocked = @IsLocked)
			END
			GO

		--BẢNG SÂN BAY
			--41. Thêm sân bay
			CREATE PROCEDURE INSERTSANBAY
			@MaSB INT,
			@MaTP INT,
			@TenSB NVARCHAR(30),
			@IsLockedSB VARCHAR(5)
			AS
			BEGIN TRAN
				INSERT INTO SANBAY (MaSB, MaTP,TenSB, IsLockedSB)
				VALUES (@MaSB, @MaTP,@TenSB, @IsLockedSB)
				IF(@@ERROR <>0)
					BEGIN
						RAISERROR('EROR', 16,1)
						ROLLBACK
						RETURN
					END
			COMMIT TRAN 
			GO
			--42. Sửa sân bay
			CREATE PROCEDURE UPDATESANBAY
			@MaSB INT,
			@MaTP INT,
			@TenSB NVARCHAR(30),
			@IsLockedSB VARCHAR(5)
			AS
			BEGIN TRAN
				UPDATE SANBAY
				SET TenSB = @TenSB, IsLockedSB =@IsLockedSB
				WHERE MaSB =@MaSB
				IF(@@ERROR <>0)
					BEGIN
						RAISERROR('EROR', 16,1)
						ROLLBACK
						RETURN
					END
			COMMIT TRAN 
			GO
			--43. Xóa sân bay
			CREATE PROCEDURE DELETESANBAY
			@MaSB INT
			AS
			BEGIN TRAN
				DELETE FROM SANBAY
				WHERE MaSB =@MaSB
				IF(@@ERROR <>0)
					BEGIN
						RAISERROR('EROR', 16,1)
						ROLLBACK
						RETURN
					END
			COMMIT TRAN 
			GO
			--44. Tìm sân bay
			CREATE PROCEDURE FINDSANBAY
			@MaSB INT,
			@TenSB NVARCHAR(30),
			@MaTP INT,
			@IsLockedSB VARCHAR(5)
			AS
			BEGIN 
			SELECT SANBAY.* FROM SANBAY
			WHERE (@MaSB = -1 OR SANBAY.MaSB =  @MaSB )
			AND (@TenSB = N'-1' OR SANBAY.TenSB like '%' + @TenSB +'%')
			AND (@MaTP = -1 OR SANBAY.MaTP = @MaTP)
			AND (@IsLockedSB = N'-1' OR SANBAY.IsLockedSB = @IsLockedSB)
			END 
			GO
	

-- User
	--Function
		--1. Tính tổng tiền hóa đơn
		create function	THANHTIEN
		(
			@maHD int
		)
		returns int
		as
		begin
			declare @tongtien int= (select sum(DonGiaVE) from VE  where @maHD = VE.MaHD and VE.IsHuyVe = 'NO')
			return @tongtien
		end
		go
		--drop function THANHTIEN
		
		--2. Tự động tăng mã hóa đơn
		create function	TAOHOADON
		()
		returns int
		as
		begin
			declare @maHD int = 1, @check int
			select @check = count(*) from HOADON
			if(@check > 0)
			begin
				select @maHD = (select max(MaHD) from HOADON ) + 1
			end			
			return @maHD
		end
		go
		--drop function TAOHOADON

		--3. Tự động tăng mã vé
		create function	TAOVE
		()
		returns int
		as
		begin
			declare @maVe int=  1, @check int
			select @check = count(*) from VE 
			if(@check > 0)
			begin
				select @maVe = (select max(MaVE) from VE ) + 1
			end		
			return @maVe
		end
		go
		-- drop FUNCTION TAOVE
		
		--4. Lấy mã vé
		create function	LAYMAVE
		(
			@maHD int
		)
		returns int
		as
		begin
			declare @MaVE int= (select top 1 MaVE from VE where  @maHD = VE.MaHD) 
															 
			return @MaVE
		end
		go
		
		--5. Lấy mã máy bay
		create function	LAYMAMB
		(
			@maVe int
		)
		returns int
		as
		begin
			declare @MaMB int= (select MaMB from VE where  @maVe = VE.MaVE) 
															 
			return @MaMB
		end
		go

		--6. Lấy mã chuyến bay
		create function	LAYMACB
		(
			@maVe int
		)
		returns int
		as
		begin
			declare @MaCB int= (select MaCB from VE where  @maVe = VE.MaVE) 
															 
			return @MaCB
		end
		go
		
		--7. Lấy ngày bay
		create function	LAYNGAYBAY
		(
			@maMB int,
			@maCB int
		)
		returns Date
		as
		begin
			declare @Ngay Date= (select NgayBay from CHITIETCHUYENBAY where CHITIETCHUYENBAY.MaMB = @maMB and CHITIETCHUYENBAY.MaCB = @maCB) 
															 
			return @Ngay
		end
		go


		--8. Thay đôi số vé đã đặt
		create function	THAYDOISOVEDADAT
		(
			@n int,
			@maMB int,
			@maCB int
		)
		returns int
		as
		begin
			declare @SoVeDaDat int= (select SoVeDaDat from CHITIETCHUYENBAY CTCB where @maCB = CTCB.MaCB AND @maMB = CTCB.MaMB) 
															 
			return @SoVeDaDat + @n
		end
		go

		--9. Bảng nơi đi
		create function SANBAY_THANHPHO_NOIDI()
		returns table
		as
		return SELECT SANBAY.MaSB AS SB_DI, THANHPHO.TenTP AS TP_DI FROM SANBAY left join THANHPHO on THANHPHO.MaTP = SANBAY.MaTP
		go

		

		--10. Bảng nơi đến
		create function SANBAY_THANHPHO_NOIDEN()
		returns table
		as
		return SELECT SANBAY.MaSB AS SB_DEN, THANHPHO.TenTP AS TP_DEN FROM SANBAY left join THANHPHO on THANHPHO.MaTP = SANBAY.MaTP
		go
		
		--11. Kiểm tra trạng thái hóa đơn
		create function TRANGTHAI
		(
			@NgayGD Date,
			@maHD int
		)
		returns int
		as
		begin
		declare  @TrangThai int,
				@curDate date,
				@betweenDate int,
				@maVe int
		select @maVe = (select dbo.LAYMAVE(@maHD))
		select @curDate = (select dbo.LAYNGAYBAY((select dbo.LAYMAMB(@maVe)),(select dbo.LAYMACB(@maVe))))
		select @betweenDate = (select DATEDIFF(day, @NgayGD ,@curDate))
		IF(@betweenDate > 1)
			select @TrangThai = 0
		ELSE
			select @TrangThai = 1

		RETURN @TrangThai
		end 
		go

		--12. Lấy số vé của hóa đơn
		create function SoVeCuaHoaDon()
		returns table
		as
		return Select MaHD , Count(MaVE) as SLVE  from VE group by MaHD
		go
		
		--13. Lấy bảng hóa đơn có trạng thái
		create function TRANGTHAIHOADON()
		returns table
		as
		return
			SELECT HOADON.MaHD, NgayGD, ThanhTien, S.SLVE, IsHuyHD , TrangThai = (select dbo.TRANGTHAI(HOADON.NgayGD, HOADON.MaHD)) FROM( HOADON left join dbo.SoVeCuaHoaDon() S on HOADON.MaHD = S.MaHD )

		GO

		--14. Lấy mã khách hàng
		CREATE FUNCTION LAYMAKHACH
		(
			@UserName VARCHAR(16)
		)
		RETURNS INT
		AS
		BEGIN
			DECLARE @MAKHACH INT = (SELECT MaKH FROM KHACHHANG WHERE KHACHHANG.UserName = @UserName)
			RETURN @MAKHACH
		END
		GO

		--15. Tăng mã khách hàng tự động
		CREATE FUNCTION TAOKHACH()
		RETURNS INT
		AS
		BEGIN
			DECLARE @MAKHACH INT = 1, @check int
			select @check = count(*) from KHACHHANG 
			if(@check > 0)
			
			begin
				select @MAKHACH = (SELECT MAX(MaKH) FROM KHACHHANG) + 1
			end		
			
			RETURN @MAKHACH
		END
		GO

		--16. Lấy thông tin của khách hàng
		CREATE FUNCTION GETINFOUSER
		(
			@UserName VARCHAR(16)
		)
		RETURNS TABLE
		AS
		RETURN (SELECT * FROM KHACHHANG WHERE KHACHHANG.UserName = @UserName)
		GO

		
		--17. Chọn máy bay theo hãng sản xuất
		CREATE FUNCTION CHONMAYBAY
		(
			@MaCB INT,
			@tenHHK NVARCHAR(20),
			@ngayBay Date,
			@gioBay Time
		)
		RETURNS INT
		AS
		BEGIN
			DECLARE @MaMB INT = (SELECT TOP 1 CHITIETCHUYENBAY.MaMB FROM (CHITIETCHUYENBAY LEFT JOIN
				(MAYBAY LEFT JOIN HANGHANGKHONG ON MAYBAY.MaHHK = HANGHANGKHONG.MaHHK ) ON CHITIETCHUYENBAY.MaMB = MAYBAY.MaMB) 
				WHERE HANGHANGKHONG.TenHHK = @tenHHK AND MaCB = @MaCB AND CHITIETCHUYENBAY.NgayBay = @ngayBay AND CHITIETCHUYENBAY.GioBay = @gioBay)
			RETURN @MaMB
		END
		GO

		
		--select dbo.CHONMAYBAY(2,N'VIETNAM Airline','9/18/2021','15:30')
		--exec DATVE 1, 3,, N'VIP', , 

		--18. Lấy mã chuyến bay
		CREATE FUNCTION CHONCHUYENBAY
		(
			@tenNoiDi NVARCHAR(30),
			@tenNoiDen NVARCHAR(30)
		)
		RETURNS INT
		AS
		BEGIN
			DECLARE @MaCB INT = (SELECT TOP 1 MaCB FROM 
					((CHUYENBAY LEFT JOIN dbo.SANBAY_THANHPHO_NOIDI() Q on CHUYENBAY.NoiDi = Q.SB_DI)
						 LEFT JOIN dbo.SANBAY_THANHPHO_NOIDEN() P on CHUYENBAY.NoiDen = P.SB_DEN) 
						 WHERE @tenNoiDi = TP_DI AND @tenNoiDen = TP_DEN)
			RETURN @MaCB
		END
		GO
		--select dbo.CHONCHUYENBAY(N'Hà Nội', N'Đà Nẵng')
		
		
		--19. Lấy ra tổng giá tiền đặt vé

		CREATE FUNCTION PRICEDV(
			@tenDV nvarchar(50)
		)
		RETURNS int
		AS
		BEGIN
		declare @price int
		set @price = (select DonGiaDV from DICHVU where TenDV = @tenDV)
		RETURN @price;
		end
		go

		--20.Lấy thông tin cho các combobox form booking
		CREATE FUNCTION LAYTHONGTIN()
		RETURNS  table
		AS
		return (SELECT Q.TP_DI, P.TP_DEN,TenMB, TenHHK, NgayBay, GioBay, ThoiGianBay,GioDen=DATEADD(mi,ThoiGianBay, cast(NgayBay as datetime) + cast(GioBay as datetime)), DonGia from 
					(((((CHUYENBAY LEFT JOIN dbo.SANBAY_THANHPHO_NOIDI() Q on CHUYENBAY.NoiDi = Q.SB_DI)
						 LEFT JOIN dbo.SANBAY_THANHPHO_NOIDEN() P on CHUYENBAY.NoiDen = P.SB_DEN) 
						 left join CHITIETCHUYENBAY on CHITIETCHUYENBAY.MaCB = CHUYENBAY.MaCB) 
						 left join MAYBAY on MAYBAY.MaMB = CHITIETCHUYENBAY.MaMB)
						 left join HANGHANGKHONG on MAYBAY.MaHHK = HANGHANGKHONG.MaHHK  )
						WHERE CHUYENBAY.TrangThai = 'ON')
		GO

--Các view riêng
		--1: HIỂN THỊ CHI TIẾT CÁC CHUYẾN BAY ĐANG 'ON' 
		CREATE VIEW CHUYENBAYHOATDONG AS SELECT CHUYENBAY.MaCB,TenMB,TenHHK, TP_DI, TP_DEN, NgayBay, GioBay, ThoiGianBay,DonGia, SoVe, SoVeTrong = SoVe - SoVeDaDat, GioDen=DATEADD(mi,ThoiGianBay, cast(NgayBay as datetime) + cast(GioBay as datetime)) 
			FROM (((CHITIETCHUYENBAY left join CHUYENBAY on CHITIETCHUYENBAY.MaCB = CHUYENBAY.MaCB) 
					left join (MAYBAY inner join HANGHANGKHONG on MAYBAY.MaHHK = HANGHANGKHONG.MaHHK)
					on CHITIETCHUYENBAY.MaMB = MAYBAY.MaMB)
					left join dbo.SANBAY_THANHPHO_NOIDI() Q on CHUYENBAY.NoiDi = Q.SB_DI)
					left join dbo.SANBAY_THANHPHO_NOIDEN() P on CHUYENBAY.NoiDen = P.SB_DEN
			WHERE CHITIETCHUYENBAY.TrangThaiCB = 'ON'
		GO

		
		--2: HIEN LICH SU GIAO DICH CHO KHACH HANG
		CREATE VIEW LICHSUGIAODICH AS SELECT distinct KHACHHANG.MaKH, S.MaHD, S.NgayGD, TP_DI, TP_DEN, NgayBay, GioBay, ThanhTien, S.SLVE , GioDen=DATEADD(mi,ThoiGianBay, cast(NgayBay as datetime) + cast(GioBay as datetime)),TenDV, S.TrangThai, S.IsHuyHD
			FROM ((((((KHACHHANG left join VE on KHACHHANG.MaKH = VE.MaKH)
				left join DICHVU on VE.MaDV = DICHVU.MaDV)
				left join dbo.TRANGTHAIHOADON() S on VE.MaHD = S.MaHD) 
				left join CHITIETCHUYENBAY on CHITIETCHUYENBAY.MaCB = VE.MaCB AND CHITIETCHUYENBAY.MaMB = VE.MaMB)
				left join CHUYENBAY on CHITIETCHUYENBAY.MaCB = CHUYENBAY.MaCB )
				left join dbo.SANBAY_THANHPHO_NOIDI() Q on CHUYENBAY.NoiDi = Q.SB_DI)
				left join dbo.SANBAY_THANHPHO_NOIDEN() P on CHUYENBAY.NoiDen = P.SB_DEN
			where S.IsHuyHD = 'NO'									
		GO
		--drop view LICHSUGIAODICH
		--SELECT * FROM LICHSUGIAODICH

	--Procedure
	  --1. Thêm 1 vé mới
		create proc BOOK_VE
			@maMB int,
			@maKH int, 
			@maDV int,
			@maCB int,
			@maHD int
		as
		begin 
			declare @GiaDichVu int = (select DonGiaDV from DICHVU where MaDV = @maDV)
			declare @GiaCB int= (select DonGia from CHITIETCHUYENBAY where MaCB = @maCB and MaMB = @maMB )
			declare @ThanhTien int = (@GiaDichVu + @GiaCB)
			declare @maVE int = (select dbo.TAOVE())
			declare @SLGhe int = (select SLGhe from MAYBAY left join HANGSANXUAT on MAYBAY.MaHSX = HANGSANXUAT.MaHSX where MaMB = @maMB )
			declare @flag int = 0
			while (@flag = 0)
				begin
					declare @setGhe int = (select FLOOR(RAND()* @SLGhe + 500))
					declare @TEMP int = ( SELECT COUNT(*) FROM dbo.VE WHERE @setGhe = GHE AND @maCB = MACB AND @maMB = MAMB)
					if (@TEMP > 1)
						begin
						print 'Sai'
						end
					else
						begin
						print 'Dung'
						break
						end	
				end
			insert into VE (MaVE,MaMB,MaKH,MaDV,MaCB,MaHD,Ghe, DonGiaVE) values (@maVE, @maMB ,@maKH , @maDV ,@maCB ,@maHD, @setGhe, @ThanhTien)
		end 
		go
		
		

	  --2. Đặt vé
		create proc  DATVE
		(
			@n int,
			@maKH int,
			@tenNoiDi NVARCHAR(30),
			@tenNoiDen NVARCHAR(30), 
			@tenDV NVARCHAR(30),
			@tenHHK NVARCHAR(20),
			@ngayBay Date,
			@gioBay Time
		)
		as 
		begin 
			declare @maHD int = (select dbo.TAOHOADON())
			declare @maCB int = (select dbo.CHONCHUYENBAY(@tenNoiDi,@tenNoiDen))
			declare @maMB int = (select dbo.CHONMAYBAY(@maCB,@tenHHK, @ngayBay, @gioBay ))
			declare @maDV int = (select MaDV from DICHVU where @tenDV = TenDV) 
			insert into HOADON(MaHD,NgayGD) values (@maHD, (select GETDATE()))
			declare  @ThanhTien int = 0
			declare @maVe int = (select dbo.LAYMAVE(@maHD))
			declare @i int = @n
			while(@i > 0)
				begin
				exec BOOK_VE @maMB ,@maKH , @maDV,@maCB ,@maHD
				select @i = @i - 1
				end 
			select @ThanhTien = ( select dbo.THANHTIEN( @maHD ))
			update HOADON set  HOADON.ThanhTien =  @ThanhTien  where MaHD= @maHD
			update CHITIETCHUYENBAY set SoVeDaDat = (select dbo.THAYDOISOVEDADAT(@n, @maMB , @maCB)) where CHITIETCHUYENBAY.MaCB = @maCB and CHITIETCHUYENBAY.MaMB = @maMB

		end 
		go
		--select MaDV from DICHVU where N'VIP'= TenDV
		--exec DATVE 1, 3, N'Hà Nội', N'Đà Nẵng', N'VIP', N'VIETNAM Airline', '9/18/2021','15:30'
		--select * from VE
		 
	--3. Hủy hóa đơn
		create proc HUYHOADON
			@maHD int
		as
		begin
		  declare @TEMP int = ( SELECT COUNT(*) FROM dbo.VE	WHERE @maHD = MaHD AND VE.IsHuyVe = 'NO')
		  if(exists (select * from HOADON where HOADON.MaHD = @maHD))
			begin
			declare  @ngayDatVe date,
					 @curDate date,
					 @betweenDate int,
					 @maVe int,
					 @maCB int,
					 @maMB int
					 
			set @ngayDatVe = (select NgayGD from  HOADON where HOADON.MaHD = @maHD)
			set @maVe = (select dbo.LAYMAVE(@maHD))
			set @maCB = (select dbo.LAYMACB(@maVe))
			set @maMB = ( select dbo.LAYMAMB(@maVe))
			set @curDate = (select dbo.LAYNGAYBAY(@maMB,@maCB))
			set @betweenDate = (select DATEDIFF(day,@ngayDatVe, @curDate ))

			if (@betweenDate > 1)
				begin
					update VE set VE.IsHuyVe = 'YES' where VE.MaHD = @maHD
					update HOADON set  HOADON.IsHuyHD =  'YES'  where MaHD= @maHD 
					update CHITIETCHUYENBAY set SoVeDaDat = (select dbo.THAYDOISOVEDADAT( -@TEMP,@maMB, @maCB)) where CHITIETCHUYENBAY.MaCB = @maCB and CHITIETCHUYENBAY.MaMB = @maMB
					print 'Quy khach huy ve thanh cong'
				end
			else
				print 'Da qua thoi gian quy dinh huy ve'
			end
		  else 
			print 'Khong ton tai ve hop le, vui long kiem tra lai!'
		end 
		go
		
		--exec HUYHOADON 4
		--drop proc HUYVE
		--exec HUYVE  3,14,30
		
	--4. Tìm kiếm 
		--4.1 Tìm trong trang tìm kiếm
			CREATE PROCEDURE SearchInfoChuyenBay
			@DonGiaMin INT,
			@DonGiaMax INT,
			@NoiDi NVARCHAR(20),
			@NoiDen NVARCHAR(20),
			@GioBay VARCHAR(50),
			@NgayBay VARCHAR(50),
			@HangHangKhong NVARCHAR(20)
			AS
			BEGIN
			SELECT *
			FROM CHUYENBAYHOATDONG
			WHERE (@NgayBay = N'-1' OR  (Convert(varchar(50),  NgayBay, 126) like '%'+@NgayBay +'%'))
			AND (@GioBay = N'-1' OR  (Convert(varchar(50), GioBay, 126) like '%'+@GioBay +'%'))
			AND (@HangHangKhong = N'-1' OR TenHHK like '%' + @HangHangKhong +'%' )
			AND	(@DonGiaMin = -1 OR DonGia >= @DonGiaMin)
			AND (@DonGiaMax = -1 OR DonGia <= @DonGiaMax)
			AND (@NoiDi = N'-1' OR TP_DI like '%'+ @NoiDi + '%')
			AND (@NoiDen = N'-1' OR TP_DEN like '%'+ @NoiDen + '%')
			END
			GO
			
		--4.2 Tìm trong giỏ hàng
			CREATE PROCEDURE SearchInfoHoaDon
			@DonGiaMin INT,
			@DonGiaMax INT,
			@NoiDi NVARCHAR(20),
			@NoiDen NVARCHAR(20),
			@TrangThai INT,
			@MaKH INT
			AS
			BEGIN
			SELECT * FROM LICHSUGIAODICH
			WHERE MaKH = @MaKH
			AND (@DonGiaMin = -1 OR ThanhTien >= @DonGiaMin)
			AND (@DonGiaMax = -1 OR ThanhTien <= @DonGiaMax)
			AND (@NoiDi = N'-1' OR TP_DI like '%'+ @NoiDi + '%')
			AND (@NoiDen = N'-1' OR TP_DEN like '%'+ @NoiDen + '%')
			AND (@TrangThai = N'-1' OR TrangThai = @TrangThai)
			END
			GO
			
	--5. Tạo tài khoản mới
		CREATE PROC SIGNINUSER 
		@TenKH NVARCHAR(20),
		@UserName VARCHAR(16),
		@MatKhau VARCHAR(20),
		@EMAIL VARCHAR(30),
		@SDT VARCHAR(10)
		AS
		BEGIN TRAN
			DECLARE @MaKH INT = (SELECT dbo.TAOKHACH())
			INSERT INTO KHACHHANG(MaKH,TenKH,UserName,MatKhau,EMAIL,SDT) VALUES (@MaKH,@TenKH,@UserName,@MatKhau,@EMAIL,@SDT)
			IF(@@ERROR <>0)
				BEGIN
					RAISERROR('EROR', 16,1)
					ROLLBACK
					RETURN
				END
		COMMIT TRAN
		GO

		
	--6. Đổi mật khẩu người dùng
		CREATE PROC CHANGEPASSWORD 
		@UserName VARCHAR(16),
		@OldPass VARCHAR(20),
		@MatKhau VARCHAR(20)
		AS
		BEGIN TRAN
			DECLARE @MatKhauCu VARCHAR(20) = (SELECT MatKhau FROM KHACHHANG WHERE KHACHHANG.UserName = @UserName)
			IF(@OldPass = @MatKhauCu)
			BEGIN
				IF(@MatKhau = @MatKhauCu)
					BEGIN
						PRINT('Mật khẩu mới phải khác mật khẩu cũ')
						RETURN
					END
				UPDATE KHACHHANG SET MatKhau = @MatKhau WHERE KHACHHANG.UserName = @UserName
				IF(@@ERROR <>0)
					BEGIN
						RAISERROR('EROR', 16,1)
						ROLLBACK
						RETURN
					END
			END
		COMMIT TRAN
		GO
	--7. Cập nhật thông tin người dùng
		CREATE PROC UPDATEINFOUSER 
		@TenKH NVARCHAR(50),
		@NgaySinh DATE,
		@DiaChi NVARCHAR(50),
		@GioiTinh NVARCHAR(5),
		@SDT VARCHAR(10),
		@EMAIL VARCHAR(30),
		@UserNameMoi VARCHAR(16),
		@UserNameCu VARCHAR(16)
		AS
		BEGIN TRAN
			UPDATE KHACHHANG SET TenKH = @TenKH, NgaySinh = @NgaySinh, DiaChi = @DiaChi,
					GioiTinh = @GioiTinh, SDT = @SDT, EMAIL = @EMAIL, UserName = @UserNameMoi 
					WHERE KHACHHANG.UserName = @UserNameCu
			IF(@@ERROR <>0)
				BEGIN
					RAISERROR('EROR', 16,1)
					ROLLBACK
					RETURN
				END
		COMMIT TRAN
		GO
				
	--8 HIỂN THỊ KHÁCH HÀNG
		CREATE PROCEDURE SHOWKHACHHANG
			@UserName VARCHAR(16) 
		AS 
		BEGIN
		SELECT KHACHHANG.* FROM KHACHHANG 
		WHERE (@UserName = UserName)
		END
		GO

		--exec SHOWKHACHHANG 'TKKH001'

		--exec UPDATEINFOUSER N'NGUYỄN VĂN THÀNH', '2001-03-01', N'Sài Gòn', N'Nữ', '12345645', 'HI@gmail.com', 'vanthanh', 'TKKH001'
--Phân quyền User;
	--Admin
		--tạo login
		create login Admin with password = 'Admin123' 
		GO
		--Cấp quyền tạo login 
		exec sp_addsrvrolemember Admin, sysadmin
		go
		--Map login ---> user 
		create user Admin for login Admin
		go
		--Tạo role
		create role Admin_role
		go
		--Cấp quyền trên bảng
		GRANT SELECT, INSERT, UPDATE, DELETE ON VE TO Admin_role
		GO
		GRANT SELECT, INSERT, UPDATE, DELETE ON CHUYENBAY TO Admin_role 
		GO
		GRANT SELECT, INSERT, UPDATE, DELETE ON CHITIETCHUYENBAY TO Admin_role 
		GO
		GRANT SELECT, INSERT, UPDATE, DELETE ON DICHVU TO Admin_role 
		GO
		GRANT SELECT, INSERT, UPDATE, DELETE ON HANGHANGKHONG TO Admin_role 
		GO
		GRANT SELECT, INSERT, UPDATE, DELETE ON HANGSANXUAT TO Admin_role 
		GO
		GRANT SELECT, INSERT, UPDATE, DELETE ON HOADON TO Admin_role 
		GO
		GRANT SELECT, INSERT, UPDATE, DELETE ON KHACHHANG TO Admin_role 
		GO
		GRANT SELECT, INSERT, UPDATE, DELETE ON MAYBAY TO Admin_role 
		GO
		GRANT SELECT, INSERT, UPDATE, DELETE ON SANBAY TO Admin_role 
		GO
		GRANT SELECT, INSERT, UPDATE, DELETE ON THANHPHO TO Admin_role 
		GO
		--Cấp quyền trên view
		GRANT SELECT ON INFOVE TO Admin_role
		GO
		GRANT SELECT ON INFOCHUYENBAY TO Admin_role 
		GO
		GRANT SELECT ON INFOCHITIETCHUYENBAY TO Admin_role 
		GO
		GRANT SELECT ON INFODICHVU TO Admin_role 
		GO
		GRANT SELECT ON INFOHANGHANGKHONG TO Admin_role 
		GO
		GRANT SELECT ON INFOHANGSANXUAT TO Admin_role 
		GO
		GRANT SELECT ON INFOHOADON TO Admin_role 
		GO
		GRANT SELECT ON INFOKHACHHANG TO Admin_role 
		GO
		GRANT SELECT ON INFOMAYBAY TO Admin_role 
		GO
		GRANT SELECT ON INFOSANBAY TO Admin_role 
		GO
		GRANT SELECT ON INFOTHANHPHO TO Admin_role 
		GO

		--Cấp quyền trên Procedure
		--1
		GRANT EXEC ON INSERTKHACHHANG TO Admin_role 
		GO
		GRANT EXEC ON UPDATEKHACHHANG TO Admin_role
		GO
		GRANT EXEC ON DELETEKHACHHANG TO Admin_role 
		GO
		GRANT EXEC ON FINDKHACHHANG TO Admin_role
		GO
		--2
		GRANT EXEC ON INSERTVE TO Admin_role
		GO
		GRANT EXEC ON UPDATEVE TO Admin_role
		GO
		GRANT EXEC ON DELETEVE TO Admin_role
		GO
		GRANT EXEC ON FINDVE TO Admin_role
		GO
		--3
		GRANT EXEC ON INSERTCHUYENBAY TO Admin_role
		GO
		GRANT EXEC ON UPDATECHUYENBAY TO Admin_role
		GO
		GRANT EXEC ON DELETECHUYENBAY TO Admin_role
		GO
		GRANT EXEC ON FINDCHUYENBAY TO Admin_role
		GO
		--4
		GRANT EXEC ON INSERTCHITIETCHUYENBAY TO Admin_role
		GO
		GRANT EXEC ON UPDATECHITIETCHUYENBAY TO Admin_role
		GO
		GRANT EXEC ON DELETECHITIETCHUYENBAY TO Admin_role
		GO
		GRANT EXEC ON FINDCHITIETCHUYENBAY TO Admin_role
		GO
		--5
		GRANT EXEC ON INSERTDICHVU TO Admin_role
		GO
		GRANT EXEC ON UPDATEDICHVU TO Admin_role
		GO
		GRANT EXEC ON DELETEDICHVU TO Admin_role
		GO
		GRANT EXEC ON FINDDICHVU TO Admin_role
		GO
		--6
		GRANT EXEC ON INSERTHANGHANGKHONG TO Admin_role
		GO
		GRANT EXEC ON UPDATEHANGHANGKHONG TO Admin_role
		GO
		GRANT EXEC ON DELETEHANGHANGKHONG TO Admin_role
		GO
		GRANT EXEC ON FINDHANGHANGKHONG TO Admin_role
		GO
		--7
		GRANT EXEC ON INSERTHANGSANXUAT TO Admin_role
		GO
		GRANT EXEC ON UPDATEHANGSANXUAT TO Admin_role
		GO
		GRANT EXEC ON DELETEHANGSANXUAT TO Admin_role
		GO
		GRANT EXEC ON FINDHANGSANXUAT TO Admin_role
		GO
		--8
		GRANT EXEC ON INSERTHOADON TO Admin_role
		GO
		GRANT EXEC ON UPDATEHOADON TO Admin_role
		GO
		GRANT EXEC ON DELETEHOADON TO Admin_role
		GO
		GRANT EXEC ON FINDHOADON TO Admin_role
		GO
		--9
		GRANT EXEC ON INSERTMAYBAY TO Admin_role
		GO
		GRANT EXEC ON UPDATEMAYBAY TO Admin_role
		GO
		GRANT EXEC ON DELETEMAYBAY TO Admin_role
		GO
		GRANT EXEC ON FINDMAYBAY TO Admin_role
		GO
		--10
		GRANT EXEC ON INSERTSANBAY TO Admin_role
		GO
		GRANT EXEC ON UPDATESANBAY TO Admin_role
		GO
		GRANT EXEC ON DELETESANBAY TO Admin_role
		GO
		GRANT EXEC ON FINDSANBAY TO Admin_role
		GO
		--11
		GRANT EXEC ON INSERTTHANHPHO TO Admin_role
		GO
		GRANT EXEC ON UPDATETHANHPHO TO Admin_role
		GO
		GRANT EXEC ON DELETETHANHPHO TO Admin_role
		GO
		GRANT EXEC ON FINDTHANHPHO TO Admin_role
		GO
		--Cấp role cho user
		exec sp_addrolemember 'Admin_role', 'Admin'
		GO

	--User 
		--Tạo role
		create role User_role
		go
		
		--Cấp quyền trên bảng
		GRANT SELECT, INSERT, UPDATE ON VE TO User_role 
		GO
		GRANT SELECT ON CHUYENBAY TO User_role 
		GO
		GRANT SELECT ON CHITIETCHUYENBAY TO User_role 
		GO
		GRANT SELECT ON DICHVU TO User_role 
		GO
		GRANT SELECT ON HANGHANGKHONG TO User_role 
		GO
		GRANT SELECT ON HANGSANXUAT TO User_role 
		GO
		GRANT SELECT, INSERT, UPDATE ON HOADON TO User_role 
		GO
		GRANT SELECT, INSERT, UPDATE ON KHACHHANG TO User_role 
		GO
		GRANT SELECT ON MAYBAY TO User_role 
		GO
		GRANT SELECT ON SANBAY TO User_role 
		GO
		GRANT SELECT ON THANHPHO TO User_role 
		GO
		--Cấp quyền trên view
		GRANT SELECT ON LICHSUGIAODICH TO User_role 
		GO
		GRANT SELECT ON CHUYENBAYHOATDONG TO User_role 
		GO
		
		--Cấp quyền trên Procedure
		GRANT EXEC ON BOOK_VE TO User_role
		GO
		GRANT EXEC ON DATVE TO User_role
		GO
		GRANT EXEC ON HUYHOADON TO User_role 
		GO
		GRANT EXEC ON SearchInfoChuyenBay TO User_role
		GO
		GRANT EXEC ON SearchInfoHoaDon TO User_role
		GO
		GRANT EXEC ON SIGNINUSER TO User_role
		GO
		GRANT EXEC ON CHANGEPASSWORD TO User_role 
		GO
		GRANT EXEC ON UPDATEINFOUSER TO User_role
		GO
		GRANT EXEC ON SHOWKHACHHANG TO User_role 
		GO
		--Cấp quyền trên Function
		--1
		GRANT exec on THANHTIEN TO User_role 
		GO
		--2
		GRANT exec on TAOHOADON TO User_role 
		GO
		--3
		GRANT exec on TAOVE TO User_role 
		GO
		--4
		GRANT exec on LAYMAVE TO User_role 
		GO
		--5
		GRANT exec on LAYMAMB TO User_role 
		GO
		--6
		GRANT exec on LAYMACB TO User_role 
		GO
		--7
		GRANT exec on LAYNGAYBAY TO User_role 
		GO
		--8
		GRANT exec on THAYDOISOVEDADAT TO User_role 
		GO
		--9
		GRANT select on SANBAY_THANHPHO_NOIDI TO User_role 
		GO
		--10
		GRANT select on SANBAY_THANHPHO_NOIDEN TO User_role 
		GO
		--11
		GRANT exec on TRANGTHAI TO User_role 
		GO
		--12
		GRANT select on TRANGTHAIHOADON TO User_role 
		GO
		--13
		GRANT select on SoVeCuaHoaDon TO User_role 
		GO
		--14
		GRANT exec on LAYMAKHACH TO User_role 
		GO
		--15
		GRANT exec on TAOKHACH TO User_role 
		GO
		--16
		GRANT select on GETINFOUSER TO User_role 
		GO
		--17
		GRANT exec on CHONMAYBAY TO User_role 
		GO
		--18
		GRANT exec on CHONCHUYENBAY TO User_role 
		GO
		--19
		GRANT exec on PRICEDV TO User_role 
		GO
		--20
		GRANT select on LAYTHONGTIN TO User_role 
		GO

--THÊM DỮ LIỆU
	-- THÀNH PHỐ
			INSERT INTO THANHPHO(MaTP, TenTP, IsLocked ) values (1, N'HÀ NỘI', 'NO')
			INSERT INTO THANHPHO(MaTP, TenTP, IsLocked ) values (2, N'HỒ CHÍ MINH', 'NO')
			INSERT INTO THANHPHO(MaTP, TenTP, IsLocked ) values (3, N'ĐÀ NẴNG', 'NO')
			INSERT INTO THANHPHO(MaTP, TenTP, IsLocked ) values (4, N'QUẢNG NINH', 'NO')
			INSERT INTO THANHPHO(MaTP, TenTP, IsLocked ) values (5, N'HẢI PHÒNG', 'NO')
			INSERT INTO THANHPHO(MaTP, TenTP, IsLocked ) values (6, N'NGHỆ AN', 'NO')
			INSERT INTO THANHPHO(MaTP, TenTP, IsLocked ) values (7, N'HUẾ', 'NO')
			INSERT INTO THANHPHO(MaTP, TenTP, IsLocked ) values (8, N'KHÁNH HÒA', 'NO')
			INSERT INTO THANHPHO(MaTP, TenTP, IsLocked ) values (9, N'ĐÀ LẠT', 'NO')
			INSERT INTO THANHPHO(MaTP, TenTP, IsLocked ) values (10, N'BÌNH ĐỊNH', 'NO')
			INSERT INTO THANHPHO(MaTP, TenTP, IsLocked ) values (11, N'CẦN THƠ', 'NO')
			INSERT INTO THANHPHO(MaTP, TenTP, IsLocked ) values (12, N'THANH HÓA', 'NO')
			INSERT INTO THANHPHO(MaTP, TenTP, IsLocked ) values (13, N'QUẢNG BÌNH', 'NO')
			INSERT INTO THANHPHO(MaTP, TenTP, IsLocked ) values (14, N'QUẢNG NAM', 'NO')
			INSERT INTO THANHPHO(MaTP, TenTP, IsLocked ) values (15, N'PHÚ YÊN', 'NO')
			INSERT INTO THANHPHO(MaTP, TenTP, IsLocked ) values (16, N'DAK LAK', 'NO')
			INSERT INTO THANHPHO(MaTP, TenTP, IsLocked ) values (17, N'KIÊN GIANG', 'NO')
			INSERT INTO THANHPHO(MaTP, TenTP, IsLocked ) values (18, N'CÀ MAU', 'NO')
			INSERT INTO THANHPHO(MaTP, TenTP, IsLocked ) values (19, N'BÀ RỊA VŨNG TÀU', 'NO')
			INSERT INTO THANHPHO(MaTP, TenTP, IsLocked ) values (20, N'ĐIỆN BIÊN', 'NO')
			INSERT INTO THANHPHO(MaTP, TenTP, IsLocked ) values (21, N'GIA LAI', 'NO')
			GO
	-- SÂN BAY
			INSERT INTO SANBAY(MaSB, MaTP, TenSB,IsLockedSB) values (1,1, N'QUỐC TẾ NỘI BÀI', 'NO')
			INSERT INTO SANBAY(MaSB, MaTP, TenSB,IsLockedSB) values (2,2, N'QUỐC TẾ TÂN SƠN NHẤT', 'NO')
			INSERT INTO SANBAY(MaSB, MaTP, TenSB,IsLockedSB) values (3,3, N'QUỐC TẾ ĐÀ NẴNG', 'NO')
			INSERT INTO SANBAY(MaSB, MaTP, TenSB,IsLockedSB) values (4,4, N'QUỐC TẾ VÂN ĐỒN', 'NO')
			INSERT INTO SANBAY(MaSB, MaTP, TenSB,IsLockedSB) values (5,5, N'QUỐC TẾ CÁT BI', 'NO')
			INSERT INTO SANBAY(MaSB, MaTP, TenSB,IsLockedSB) values (6,6, N'QUỐC TẾ VINH', 'NO')
			INSERT INTO SANBAY(MaSB, MaTP, TenSB,IsLockedSB) values (7,7, N'QUỐC TẾ PHÚ BÀI', 'NO')
			INSERT INTO SANBAY(MaSB, MaTP, TenSB,IsLockedSB) values (8,8, N'QUỐC TẾ CAM RANH', 'NO')
			INSERT INTO SANBAY(MaSB, MaTP, TenSB,IsLockedSB) values (9,9, N'QUỐC TẾ LIÊN KHƯƠNG', 'NO')
			INSERT INTO SANBAY(MaSB, MaTP, TenSB,IsLockedSB) values (10,10, N'QUỐC TẾ PHÙ CÁT', 'NO')
			INSERT INTO SANBAY(MaSB, MaTP, TenSB,IsLockedSB) values (11,11, N'QUỐC TẾ CẦN THƠ', 'NO')
			INSERT INTO SANBAY(MaSB, MaTP, TenSB,IsLockedSB) values (12,12, N'THỌ XUÂN', 'NO')
			INSERT INTO SANBAY(MaSB, MaTP, TenSB,IsLockedSB) values (13,13, N'ĐỒNG HỚI', 'NO')
			INSERT INTO SANBAY(MaSB, MaTP, TenSB,IsLockedSB) values (14,14, N'CHU LAI', 'NO')
			INSERT INTO SANBAY(MaSB, MaTP, TenSB,IsLockedSB) values (15,15, N'TUY HÒA', 'NO')
			INSERT INTO SANBAY(MaSB, MaTP, TenSB,IsLockedSB) values (16,16, N'BUÔN MA THUỘT', 'NO')
			INSERT INTO SANBAY(MaSB, MaTP, TenSB,IsLockedSB) values (17,17, N'RẠCH GIÁ', 'NO')
			INSERT INTO SANBAY(MaSB, MaTP, TenSB,IsLockedSB) values (18,17, N'QUỐC TẾ PHÚ QUỐC', 'NO')
			INSERT INTO SANBAY(MaSB, MaTP, TenSB,IsLockedSB) values (19,18, N'CÀ MAU', 'NO')
			INSERT INTO SANBAY(MaSB, MaTP, TenSB,IsLockedSB) values (20,19, N'CÔN ĐẢO', 'NO')
			INSERT INTO SANBAY(MaSB, MaTP, TenSB,IsLockedSB) values (21,20, N'ĐIỆN BIÊN PHỦ', 'NO')
			INSERT INTO SANBAY(MaSB, MaTP, TenSB,IsLockedSB) values (22,21, N'PLEIKU', 'NO')
			GO
	-- DỊCH VỤ
			INSERT INTO DICHVU (MaDV, TenDV,DonGiaDV) values (1, N'VIP',300000)
			INSERT INTO DICHVU (MaDV, TenDV,DonGiaDV) values (3, N'NORMAL',100000)
			GO
	-- HÃNG SẢN XUẤT
			INSERT INTO HANGSANXUAT(MaHSX, TenHSX, SLGhe) values (1,N'BOEING 787',274)
			INSERT INTO HANGSANXUAT(MaHSX, TenHSX, SLGhe) values (2,N'AIRBUS A350',300)
			INSERT INTO HANGSANXUAT(MaHSX, TenHSX, SLGhe) values (3,N'AIRBUS A321',184)
			INSERT INTO HANGSANXUAT(MaHSX, TenHSX, SLGhe) values (4,N'AIRBUS A330',280)
			INSERT INTO HANGSANXUAT(MaHSX, TenHSX, SLGhe) values (5,N'BOEING 737',200)
			INSERT INTO HANGSANXUAT(MaHSX, TenHSX, SLGhe) values (6,N'AIRBUS A321 NEO',240)
			INSERT INTO HANGSANXUAT(MaHSX, TenHSX, SLGhe) values (7,N'AIRBUS A320 NEO',194)
			INSERT INTO HANGSANXUAT(MaHSX, TenHSX, SLGhe) values (8,N'EMBRAER',116)
			GO
	-- HÃNG HÀNG KHÔNG
			INSERT INTO HANGHANGKHONG(MaHHK, TenHHK, DonGiaHHK) values (1, N'VIETNAM AIRLINE', 300000)
			INSERT INTO HANGHANGKHONG(MaHHK, TenHHK, DonGiaHHK) values (2, N'VIETJET AIR', 200000)
			INSERT INTO HANGHANGKHONG(MaHHK, TenHHK, DonGiaHHK) values (3, N'JETSTAR PACIFIC', 350000)
			INSERT INTO HANGHANGKHONG(MaHHK, TenHHK, DonGiaHHK) values (4, N'BAMBOO AIRWAY', 250000)
			GO

	-- MÁY BAY : TÊN MÁY BAY = "KÍ HIỆU HÃNG MÁY BAY" + "KÍ HIỆU HÃNG SẢN XUẤT" + "SỐ THỨ TỰ"
		-- VIETNAM AIRLINE
			INSERT INTO MAYBAY(MaMB,TenMB,MaHHK, MaHSX) values (1,'VAB787001',1,1)
			INSERT INTO MAYBAY(MaMB,TenMB,MaHHK, MaHSX) values (2,'VAB787002',1,1)
			INSERT INTO MAYBAY(MaMB,TenMB,MaHHK, MaHSX) values (3,'VAB787003',1,1)
			INSERT INTO MAYBAY(MaMB,TenMB,MaHHK, MaHSX) values (4,'VAB787004',1,1)
			INSERT INTO MAYBAY(MaMB,TenMB,MaHHK, MaHSX) values (5,'VAB787005',1,1)
			INSERT INTO MAYBAY(MaMB,TenMB,MaHHK, MaHSX) values (6,'VAB787006',1,1)
			INSERT INTO MAYBAY(MaMB,TenMB,MaHHK, MaHSX) values (7,'VAB787007',1,1)
			INSERT INTO MAYBAY(MaMB,TenMB,MaHHK, MaHSX) values (8,'VAB787008',1,1)
			INSERT INTO MAYBAY(MaMB,TenMB,MaHHK, MaHSX) values (9,'VAB787009',1,1)
			INSERT INTO MAYBAY(MaMB,TenMB,MaHHK, MaHSX) values (10,'VAB787009',1,1)
			INSERT INTO MAYBAY(MaMB,TenMB,MaHHK, MaHSX) values (11,'VAB737001',1,5)
			INSERT INTO MAYBAY(MaMB,TenMB,MaHHK, MaHSX) values (12,'VAB737002',1,5)
			INSERT INTO MAYBAY(MaMB,TenMB,MaHHK, MaHSX) values (13,'VAB737003',1,5)
			INSERT INTO MAYBAY(MaMB,TenMB,MaHHK, MaHSX) values (14,'VAB737004',1,5)
			INSERT INTO MAYBAY(MaMB,TenMB,MaHHK, MaHSX) values (15,'VAB737005',1,5)
			INSERT INTO MAYBAY(MaMB,TenMB,MaHHK, MaHSX) values (16,'VAA350001',1,2)
			INSERT INTO MAYBAY(MaMB,TenMB,MaHHK, MaHSX) values (17,'VAA350002',1,2)
			INSERT INTO MAYBAY(MaMB,TenMB,MaHHK, MaHSX) values (18,'VAA350003',1,2)
			INSERT INTO MAYBAY(MaMB,TenMB,MaHHK, MaHSX) values (19,'VAA350004',1,2)
			INSERT INTO MAYBAY(MaMB,TenMB,MaHHK, MaHSX) values (20,'VAA350005',1,2)
			INSERT INTO MAYBAY(MaMB,TenMB,MaHHK, MaHSX) values (21,'VAA350006',1,2)
			INSERT INTO MAYBAY(MaMB,TenMB,MaHHK, MaHSX) values (22,'VAA350007',1,2)
			INSERT INTO MAYBAY(MaMB,TenMB,MaHHK, MaHSX) values (23,'VAA321001',1,3)
			INSERT INTO MAYBAY(MaMB,TenMB,MaHHK, MaHSX) values (24,'VAA321002',1,3)
			INSERT INTO MAYBAY(MaMB,TenMB,MaHHK, MaHSX) values (25,'VAA321003',1,3)
			INSERT INTO MAYBAY(MaMB,TenMB,MaHHK, MaHSX) values (26,'VAA321004',1,3)
			INSERT INTO MAYBAY(MaMB,TenMB,MaHHK, MaHSX) values (27,'VAA321005',1,3)
			INSERT INTO MAYBAY(MaMB,TenMB,MaHHK, MaHSX) values (28,'VAA321006',1,3)
			INSERT INTO MAYBAY(MaMB,TenMB,MaHHK, MaHSX) values (29,'VAA321007',1,3)
			INSERT INTO MAYBAY(MaMB,TenMB,MaHHK, MaHSX) values (30,'VAA321008',1,3)
			INSERT INTO MAYBAY(MaMB,TenMB,MaHHK, MaHSX) values (31,'VAA320N001',1,7)
			INSERT INTO MAYBAY(MaMB,TenMB,MaHHK, MaHSX) values (32,'VAA320N002',1,7)
			INSERT INTO MAYBAY(MaMB,TenMB,MaHHK, MaHSX) values (33,'VAA320N003',1,7)
			INSERT INTO MAYBAY(MaMB,TenMB,MAHHK, MaHSX) values (34,'VAA320N004',1,7)
			INSERT INTO MAYBAY(MaMB,TenMB,MAHHK, MaHSX) values (35,'VAA320N005',1,7)
			GO
		-- VIETJET AIR
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (36,'VAJA321001',2,3)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (37,'VAJA321002',2,3)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (38,'VAJA321003',2,3)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (39,'VAJA321004',2,3)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (40,'VAJA321005',2,3)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (41,'VAJA321006',2,3)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (42,'VAJA321007',2,3)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (43,'VAJA321008',2,3)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (44,'VAJA321N001',2,6)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (45,'VAJA321N002',2,6)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (46,'VAJA321N003',2,6)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (47,'VAJA321N004',2,6)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (48,'VAJA321N005',2,6)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (49,'VAJA321N006',2,6)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (50,'VAJA321N007',2,6)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (51,'VAJA321N008',2,6)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (52,'VAJA321N009',2,6) 
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (53,'VAJA321N010',2,6)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (54,'VAJA330001',2,4)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (55,'VAJA330002',2,4)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (56,'VAJA330003',2,4)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (57,'VAJA330004',2,4)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (58,'VAJA330005',2,4)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (59,'VAJA330006',2,4)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (60,'VAJA330007',2,4)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (61,'VAJA330008',2,4) 
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (62,'VAJA330009',2,4)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (63,'VAJA330010',2,4)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (64,'VAJA330011',2,4)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (65,'VAJA330012',2,4)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (66,'VAJA330013',2,4)
			GO
		-- JETSTAR PACIFIC
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (67,'JPA330001',3,4)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (68,'JPA330002',3,4)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (69,'JPA330003',3,4)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (70,'JPA330004',3,4)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (71,'JPA330005',3,4)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (72,'JPA330006',3,4)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (73,'JPA330007',3,4)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (74,'JPA330008',3,4)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (75,'JPA330009',3,4)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (76,'JPA330010',3,4)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (77,'JPA330011',3,4)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (78,'JPA350001',3,2)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (79,'JPA350002',3,2)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (80,'JPA350003',3,2)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (81,'JPA350004',3,2)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (82,'JPA350005',3,2)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (83,'JPA350006',3,2)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (84,'JPA350007',3,2)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (85,'JPA350008',3,2)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (86,'JPA321N001',3,6)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (87,'JPA321N002',3,6)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (88,'JPA321N003',3,6)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (89,'JPA321N004',3,6)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (90,'JPA321N005',3,6)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (91,'JPA321N006',3,6)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (92,'JPA321N007',3,6)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (93,'JPA321N008',3,6)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (94,'JPA321N009',3,6)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (95,'JPA321N010',3,6)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (96,'JPA321N011',3,6)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (97,'JPA321N012',3,6)
			GO
		-- BAMBOO AIRWAY
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (98,'BAA321N001',4,6)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (99,'BAA321N002',4,6)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (100,'BAA321N003',4,6)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (101,'BAA321N004',4,6)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (102,'BAA321N005',4,6)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (103,'BAA320N001',4,7)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (104,'BAA320N002',4,7)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (105,'BAA320N003',4,7)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (106,'BAA320N004',4,7)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (107,'BAA320N005',4,7)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (108,'BAA320N006',4,7)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (109,'BAA320N007',4,7)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (110,'BAA320N008',4,7)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (111,'BAEMBR001',4,8)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (112,'BAEMBR002',4,8)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (113,'BAEMBR003',4,8)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (114,'BAEMBR004',4,8)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (115,'BAEMBR005',4,8)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (116,'BAEMBR006',4,8)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (117,'BAEMBR007',4,8)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (118,'BAEMBR008',4,8)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (119,'BAB787001',4,1)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (120,'BAB787002',4,1)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (121,'BAB787003',4,1)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (122,'BAB787004',4,1)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (123,'BAB787005',4,1)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (124,'BAB787006',4,1)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (125,'BAB787007',4,1)
			INSERT INTO MAYBAY(MaMB,TenMB, MAHHK, MaHSX) values (126,'BAB787008',4,1)
			GO
	-- CHUYẾN BAY
			INSERT INTO CHUYENBAY(MaCB, NoiDi, NoiDen,ThoiGianBay,TrangThai) values (1, 1, 2,120,'ON')
			INSERT INTO CHUYENBAY(MaCB, NoiDi, NoiDen,ThoiGianBay,TrangThai) values (2,1, 3,90 ,'ON')
			INSERT INTO CHUYENBAY(MaCB, NoiDi, NoiDen,ThoiGianBay,TrangThai) values (3, 3, 2,150 ,'ON')
			INSERT INTO CHUYENBAY(MaCB, NoiDi, NoiDen,ThoiGianBay,TrangThai) values (4, 7, 12 ,120 ,'ON')
			INSERT INTO CHUYENBAY(MaCB, NoiDi, NoiDen,ThoiGianBay,TrangThai) values (5, 17, 20,120,'ON')
			INSERT INTO CHUYENBAY(MaCB, NoiDi, NoiDen,ThoiGianBay,TrangThai) values (6,16, 13,90 ,'ON')
			INSERT INTO CHUYENBAY(MaCB, NoiDi, NoiDen,ThoiGianBay,TrangThai) values (7, 21, 4,150 ,'ON')
			INSERT INTO CHUYENBAY(MaCB, NoiDi, NoiDen,ThoiGianBay,TrangThai) values (8, 1, 22 ,120 ,'ON')
			INSERT INTO CHUYENBAY(MaCB, NoiDi, NoiDen,ThoiGianBay,TrangThai) values (9, 15, 2,120,'ON')
			INSERT INTO CHUYENBAY(MaCB, NoiDi, NoiDen,ThoiGianBay,TrangThai) values (10,17, 19,90 ,'ON')
			INSERT INTO CHUYENBAY(MaCB, NoiDi, NoiDen,ThoiGianBay,TrangThai) values (11, 1, 6,150 ,'ON')
			INSERT INTO CHUYENBAY(MaCB, NoiDi, NoiDen,ThoiGianBay,TrangThai) values (12, 10, 2 ,120 ,'ON')
			INSERT INTO CHUYENBAY(MaCB, NoiDi, NoiDen,ThoiGianBay,TrangThai) values (13, 3, 8,120,'ON')
			INSERT INTO CHUYENBAY(MaCB, NoiDi, NoiDen,ThoiGianBay,TrangThai) values (14,12, 5,90 ,'ON')
			INSERT INTO CHUYENBAY(MaCB, NoiDi, NoiDen,ThoiGianBay,TrangThai) values (15, 12, 18,150 ,'ON')
			INSERT INTO CHUYENBAY(MaCB, NoiDi, NoiDen,ThoiGianBay,TrangThai) values (16, 8, 2 ,120 ,'ON')
			GO
	-- CHI TIẾT CHUYẾN BAY
			INSERT INTO CHITIETCHUYENBAY(MaCB, MaMB, NgayBay, GioBay,TrangThaiCB) values (1, 1, '2021-09-18', '15:30:00','ON')
			INSERT INTO CHITIETCHUYENBAY(MaCB, MaMB, NgayBay, GioBay,TrangThaiCB) values (2, 3, '2021-09-16', '17:30:00','ON')
			INSERT INTO CHITIETCHUYENBAY(MaCB, MaMB, NgayBay, GioBay,TrangThaiCB) values (3, 14, '2021-10-12', '10:30:00','ON')
			INSERT INTO CHITIETCHUYENBAY(MaCB, MaMB, NgayBay, GioBay,TrangThaiCB) values (4, 26, '2021-02-22', '07:45:00','ON')
			INSERT INTO CHITIETCHUYENBAY(MaCB, MaMB, NgayBay, GioBay,TrangThaiCB) values (2, 21, '2021-12-23', '15:30:00','ON')
			INSERT INTO CHITIETCHUYENBAY(MaCB, MaMB, NgayBay, GioBay,TrangThaiCB) values (2, 33, '2021-09-10', '15:45:00','ON')
			INSERT INTO CHITIETCHUYENBAY(MaCB, MaMB, NgayBay, GioBay,TrangThaiCB) values (3, 104, '2021-04-23', '16:30:00','ON')
			INSERT INTO CHITIETCHUYENBAY(MaCB, MaMB, NgayBay, GioBay,TrangThaiCB) values (5, 86, '2021-11-21', '09:00:00','ON')
			INSERT INTO CHITIETCHUYENBAY(MaCB, MaMB, NgayBay, GioBay,TrangThaiCB) values (7, 92, '2021-08-27', '23:30:00','ON')
			INSERT INTO CHITIETCHUYENBAY(MaCB, MaMB, NgayBay, GioBay,TrangThaiCB) values (9, 36, '2021-07-14', '23:45:00','ON')
			INSERT INTO CHITIETCHUYENBAY(MaCB, MaMB, NgayBay, GioBay,TrangThaiCB) values (8, 17, '2021-01-27', '01:30:00','ON')
			INSERT INTO CHITIETCHUYENBAY(MaCB, MaMB, NgayBay, GioBay,TrangThaiCB) values (13, 86, '2021-01-04', '01:45:00','ON')
			INSERT INTO CHITIETCHUYENBAY(MaCB, MaMB, NgayBay, GioBay,TrangThaiCB) values (15, 11, '2021-01-16', '23:00:00','ON')
			INSERT INTO CHITIETCHUYENBAY(MaCB, MaMB, NgayBay, GioBay,TrangThaiCB) values (16, 35, '2021-02-28', '13:00:00','ON')
			INSERT INTO CHITIETCHUYENBAY(MaCB, MaMB, NgayBay, GioBay,TrangThaiCB) values (12, 114, '2021-06-17', '18:45:00','ON')
			INSERT INTO CHITIETCHUYENBAY(MaCB, MaMB, NgayBay, GioBay,TrangThaiCB) values (10, 120, '2021-03-24', '21:00:00','ON')
			INSERT INTO CHITIETCHUYENBAY(MaCB, MaMB, NgayBay, GioBay,TrangThaiCB) values (6, 47, '2021-03-18', '23:45:00','ON')
			INSERT INTO CHITIETCHUYENBAY(MaCB, MaMB, NgayBay, GioBay,TrangThaiCB) values (6, 94, '2021-04-15', '16:30:00','ON')
			INSERT INTO CHITIETCHUYENBAY(MaCB, MaMB, NgayBay, GioBay,TrangThaiCB) values (10, 25, '2021-10-12', '17:30:00','ON')
			INSERT INTO CHITIETCHUYENBAY(MaCB, MaMB, NgayBay, GioBay,TrangThaiCB) values (12, 27, '2021-11-21', '19:30:00','ON')

			INSERT INTO CHITIETCHUYENBAY(MaCB, MaMB, NgayBay, GioBay,TrangThaiCB) values (11, 81, '2021-07-24', '20:00:00','ON')
			INSERT INTO CHITIETCHUYENBAY(MaCB, MaMB, NgayBay, GioBay,TrangThaiCB) values (12, 32, '2021-07-21', '20:30:00','ON')
			INSERT INTO CHITIETCHUYENBAY(MaCB, MaMB, NgayBay, GioBay,TrangThaiCB) values (13, 14, '2021-11-24', '21:30:00','ON')
			INSERT INTO CHITIETCHUYENBAY(MaCB, MaMB, NgayBay, GioBay,TrangThaiCB) values (4, 62, '2021-12-04', '22:30:00','ON')
			INSERT INTO CHITIETCHUYENBAY(MaCB, MaMB, NgayBay, GioBay,TrangThaiCB) values (8, 71, '2021-11-03', '21:45:00','ON')
			INSERT INTO CHITIETCHUYENBAY(MaCB, MaMB, NgayBay, GioBay,TrangThaiCB) values (8, 53, '2021-04-23', '17:00:00','ON')
			INSERT INTO CHITIETCHUYENBAY(MaCB, MaMB, NgayBay, GioBay,TrangThaiCB) values (3, 24, '2021-06-04', '22:45:00','ON')
			INSERT INTO CHITIETCHUYENBAY(MaCB, MaMB, NgayBay, GioBay,TrangThaiCB) values (5, 66, '2021-07-01', '20:30:00','ON')
			INSERT INTO CHITIETCHUYENBAY(MaCB, MaMB, NgayBay, GioBay,TrangThaiCB) values (6, 13, '2021-07-31', '23:45:00','ON')
			INSERT INTO CHITIETCHUYENBAY(MaCB, MaMB, NgayBay, GioBay,TrangThaiCB) values (6, 34, '2021-08-31', '23:30:00','ON')
			INSERT INTO CHITIETCHUYENBAY(MaCB, MaMB, NgayBay, GioBay,TrangThaiCB) values (8, 44, '2021-10-01', '06:00:00','ON')
			INSERT INTO CHITIETCHUYENBAY(MaCB, MaMB, NgayBay, GioBay,TrangThaiCB) values (8, 22, '2021-04-26', '09:45:00','ON')
			INSERT INTO CHITIETCHUYENBAY(MaCB, MaMB, NgayBay, GioBay,TrangThaiCB) values (9, 19, '2021-10-24', '18:45:00','ON')
			INSERT INTO CHITIETCHUYENBAY(MaCB, MaMB, NgayBay, GioBay,TrangThaiCB) values (10, 30, '2021-02-24', '20:30:00','ON')
			INSERT INTO CHITIETCHUYENBAY(MaCB, MaMB, NgayBay, GioBay,TrangThaiCB) values (11, 10, '2021-09-13', '16:45:00','ON')
			INSERT INTO CHITIETCHUYENBAY(MaCB, MaMB, NgayBay, GioBay,TrangThaiCB) values (10, 16, '2021-03-20', '12:00:00','ON')
			INSERT INTO CHITIETCHUYENBAY(MaCB, MaMB, NgayBay, GioBay,TrangThaiCB) values (7, 43, '2021-02-07', '19:45:00','ON')
			INSERT INTO CHITIETCHUYENBAY(MaCB, MaMB, NgayBay, GioBay,TrangThaiCB) values (9, 54, '2021-04-28', '18:30:00','ON')
			INSERT INTO CHITIETCHUYENBAY(MaCB, MaMB, NgayBay, GioBay,TrangThaiCB) values (15, 76, '2021-07-14', '17:00:00','ON')
			INSERT INTO CHITIETCHUYENBAY(MaCB, MaMB, NgayBay, GioBay,TrangThaiCB) values (12, 66, '2021-06-28', '19:30:00','ON')
			GO
	--DỮ LIỆU TEST
	
	-- KHÁCH HÀNG
		/*
			INSERT INTO KHACHHANG(MaKH, TenKH,NgaySinh,DiaChi,GioiTinh,SDT,EMAIL,UserName,MatKhau) values (1, N'NGUYỄN VĂN THÀNH','2001-03-01',N'GIA LAI',N'NAM','12345','HI@gmail.com' ,'TKKH001','1234Abcd')
			INSERT INTO KHACHHANG(MaKH, TenKH,NgaySinh,DiaChi,GioiTinh,SDT,EMAIL,UserName,MatKhau) values (2, N'NGUYỄN TẤN KIỆT','2001-01-04',N'PHÚ YÊN',N'NAM','15541' , 'HA@gmail.com','TKKH002','1234Abcd')
			INSERT INTO KHACHHANG(MaKH, TenKH,NgaySinh,DiaChi,GioiTinh,SDT,EMAIL,UserName,MatKhau) values (3, N'ĐÀM LƯU TRUNG HIẾU','2001-03-17',N'ĐAK LAK',N'NAM','45221', 'HU@gmail.com','TKKH003','1234Abcd')
			GO
	*/