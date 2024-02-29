CREATE DATABASE PhanHeQuanLyHoatDong
GO
--sử dụng DB
USE PhanHeQuanLyHoatDong
GO

--tạo bảng
CREATE TABLE PhongBan 
(
	MaPhongBan				INT				NOT NULL PRIMARY KEY,
	TenPhongBan				NVARCHAR(50)	NOT NULL,
	SoluongNhanVien			INT				NOT NULL
)
GO

CREATE TABLE ChucVu
(
	MaCV					INT				NOT NULL PRIMARY KEY,
	TenCV					NVARCHAR(50)	NOT NULL
)
GO

CREATE TABLE QuyDinh
(
	MaQD					INT				IDENTITY(1,1) NOT NULL PRIMARY KEY,
	TenQD					NVARCHAR(50)	NOT NULL,
	NoidungQD				TEXT			NOT NULL,
	NgayCapNhat				DATE			
)
GO

CREATE TABLE LinhVuc
(
	MaLinhVuc				INT				NOT NULL PRIMARY KEY,
	TenLinhVuc				NVARCHAR(50)	NOT NULL
)
GO

CREATE TABLE ToChuc
(
	MaToChuc				CHAR(5) 		NOT NULL PRIMARY KEY,
	TenToChuc				NVARCHAR(50)	NOT NULL,
)
GO

CREATE TABLE NhanVien
(
	id_nhanvien				INT				IDENTITY(1,1) NOT NULL PRIMARY KEY,
	MSNV					INT				NOT NULL,
	HoTen					NVARCHAR(100)	NOT NULL,
	GioiTinh				NVARCHAR(10)	NOT NULL,
	NgaySinh				DATE			NOT NULL,
	DanToc					NVARCHAR(15)	NOT NULL,
	TonGiao					NVARCHAR(15)	NOT NULL,
	SoDienThoai				CHAR(10)		NOT NULL,
	Email					CHAR(100)		NOT NULL,
	CCCD					CHAR(12)		NOT NULL,
	NgayLamViec				DATE			NOT NULL,
	MaPhongBan				INT				NOT NULL FOREIGN KEY REFERENCES dbo.PhongBan (MaPhongBan),
	MaCV					INT				NOT NULL FOREIGN KEY REFERENCES dbo.ChucVu (MaCV),
)
GO

CREATE TABLE SinhVien
(
	id_sinhvien				INT				IDENTITY(1,1) NOT NULL PRIMARY KEY,
	MSSV					INT				NOT NULL,
	HoTen					NVARCHAR(100)	NOT NULL,
	GioiTinh				NVARCHAR(10)	NOT NULL,
	NgaySinh				DATE			NOT NULL,
	DanToc					NVARCHAR(15)	NOT NULL,
	TonGiao					NVARCHAR(15)	NOT NULL,
	SoDienThoai				CHAR(10)		NOT NULL,
	Email					CHAR(100)		NOT NULL,
	CCCD					CHAR(12)		NOT NULL,
	NganhHoc				NVARCHAR(50)	NOT NULL,
	Lop						CHAR(10)		NOT NULL,
	Khoahoc					INT				NOT NULL
)
GO


CREATE TABLE BanToChuc
(
	id_bantochuc			INT					IDENTITY(1,1) NOT NULL PRIMARY KEY,
	MaBTC					INT					NOT NULL,
	TenBTC					NVARCHAR(50)		NOT NULL,
	EmailBTC				CHAR(100)			NOT NULL,
	-- M? L?NH V?C KHÓA NGO?I
	MaToChuc				CHAR(5)				NOT NULL FOREIGN KEY REFERENCES dbo.ToChuc (MaToChuc)

)
GO

CREATE TABLE DonViQuanLy
(
	id_dvql					INT				IDENTITY(1,1) NOT NULL PRIMARY KEY,
	MaDVQL					INT				NOT NULL,
	TenDVQL					NVARCHAR(50)	NOT NULL,
	--M? T? CH?C KHÓA NGO?I
	MaToChuc				CHAR(5)			NOT NULL FOREIGN KEY REFERENCES dbo.ToChuc(MaToChuc)
)
GO

CREATE TABLE TaiKhoan
(
	MaTK					INT				IDENTITY(1,1) NOT NULL PRIMARY KEY,
	TenDangNhap				Char (50)		NOT NULL,
	MatKhau					Char (30)		NOT NULL,
	LoaiTK					Nvarchar (50)	NOT NULL,
	MSSV					Int				NULL FOREIGN KEY (MSSV) REFERENCES dbo.SinhVien(id_sinhvien),
	MaBTC					INT				NULL FOREIGN KEY (MaBTC) REFERENCES dbo.BanToChuc(id_bantochuc),
	MaDVQL					INT				NULL FOREIGN KEY (MaDVQL) REFERENCES dbo.DonViQuanLy(id_dvql),
	MSNV					Int				NULL FOREIGN KEY (MSNV) REFERENCES dbo.NhanVien(id_nhanvien)
)
GO

CREATE TABLE TrangThaiHoatDong
(
	MaTrangThai				INT				NOT NULL PRIMARY KEY,
	TenTrangThai			NVARCHAR(50)	NOT NULL
)
GO

CREATE TABLE HoatDong
(
	id_hoatdong				INT				IDENTITY(1,1) NOT NULL PRIMARY KEY,
	MaHD					INT				NOT NULL,
	TenHD					NVARCHAR(50)	NOT NULL,
	SoLuongSVmax			Int				NOT NULL,
	SoluongSV				Int				NOT NULL,
	NgayBD					Date			NOT NULL, 
	NgayKT					Date			NOT NULL,
	DiaDiem					NVARCHAR(15)	NOT NULL,
	LePhi					DECIMAL(19,0)	NOT NULL,
	MaLinhVuc				INT				NOT NULL FOREIGN KEY REFERENCES dbo.LinhVuc (MaLinhVuc),
	MaBTC					INT				NOT NULL FOREIGN KEY (MaBTC) REFERENCES dbo.BanToChuc(id_bantochuc),
	MaTrangThai				INT				NOT NULL FOREIGN KEY REFERENCES TrangThaiHoatDong (MaTrangThai),
	MaDVQL					INT				NOT NULL FOREIGN KEY (MaDVQL) REFERENCES dbo.DonViQuanLy (id_dvql)
	)
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhieuDangKyThamGiaHoatDong](
	[MaPDKTGHD]				[INT]				IDENTITY(1,1) NOT NULL,
	[MaHD]					[INT]				NOT NULL,
	[MSSV]					[INT]				NOT NULL ,
PRIMARY KEY CLUSTERED 
(
	[MaHD] ASC,
	[MSSV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE PhieuDangKyThamGiaHoatDong WITH CHECK ADD FOREIGN KEY ([MSSV]) REFERENCES SinhVien ([id_sinhvien])
GO
ALTER TABLE PhieuDangKyThamGiaHoatDong WITH CHECK ADD FOREIGN KEY ([MaHD]) REFERENCES HoatDong ([id_hoatdong])
GO

-- THÊM DỮ LIỆU VÀO SQL
--Bảng Sinh Viên
SET IDENTITY_INSERT [dbo].[SinhVien] ON 
GO
INSERT INTO dbo.SinhVien ([id_sinhvien], [MSSV], [HoTen], [GioiTinh], [NgaySinh], [DanToc], [TonGiao], [SoDienThoai], [Email], [CCCD], [NganhHoc], [Lop], [Khoahoc]) VALUES
(1,100001,N'Trương Thị Hạnh',N'Nữ','20020413',N'Kinh',N'Thiên Chúa Giáo','0948674965','hanhtruong.100001@ueh.edu.vn','138564123456',N'Quản trị kinh doanh','AD001',46),
(2,100002,N'Lê Đức Minh',N'Nam','20030109',N'Kinh',N'Phật Giáo ','0374562931','minhle.100002@ueh.edu.vn','134567821344',N'Tài chính','FN001',47),
(3,100003,N'Huỳnh Thị Hương',N'Nữ','20040503',N'Kinh',N'Không','0583946274','huonghuynh.100003@ueh.edu.vn','132464738382',N'Công nghệ phần mềm','ST001',48),
(4,100004,N'Văn Bang',N'Nam','20050305',N'Kinh',N'Không','0989876594','bangvan.100004@ueh.edu.vn','137584930798',N'Khoa học dữ liệu','DA001',49);
SET IDENTITY_INSERT [dbo].[SinhVien] OFF
GO

--Bảng Chức vụ
INSERT INTO dbo.ChucVu ([MaCV], [TenCV]) VALUES
(1, N'Nhân viên kỹ thuật'),
(2, N'Trưởng phòng kỹ thuật')
--Bảng Phòng ban
INSERT INTO dbo.PhongBan([MaPhongBan],[TenPhongBan],[SoluongNhanVien]) VALUES
(1,N'Phòng Công nghệ thông tin',10)
--Bảng Nhân viên
SET IDENTITY_INSERT [dbo].[NhanVien] ON 
GO
INSERT INTO dbo.NhanVien
([id_nhanvien],[MSNV],[HoTen],[GioiTinh],[NgaySinh],[DanToc],[TonGiao],[SoDienThoai],[Email],[CCCD],[NgayLamViec],[MaPhongBan],[MaCV]) VALUES
(1,200001, N'Võ Văn',N'Nam',CAST(N'19800101' AS Date),N'Kinh',N'Không','0958765978','vanvo@it.ueh.edu.vn','193847563012',CAST(N'20050912' AS Date),1,1),
(2,200002, N'Trương Hải',N'Nam',CAST(N'19880303' AS Date),N'Kinh',N'Không','0359374832','haitruong@it.ueh.edu.vn','193842463986',CAST(N'20150429' AS Date),1,2)
SET IDENTITY_INSERT [dbo].[Nhanvien] OFF
GO
--Bảng Tổ chức
INSERT INTO dbo.ToChuc ([MaToChuc],[TenToChuc]) VALUES
('D',N'Đoàn'),
('H',N'Hội Sinh Viên')
--Bảng Ban tổ chức
SET IDENTITY_INSERT [dbo].[BanToChuc] ON 
GO
INSERT INTO  dbo.BanToChuc ([id_bantochuc],[MaBTC],[TenBTC],[EmailBTC],[MaToChuc]) VALUES
(1,'300001',N'CLB Chuyện To Nhỏ','chuyentonho@ueh.edu.vn','D'),
(2,'300002',N'Đội Công Tác Xã Hội','ctxh@ueh.edu.vn','D'),
(3,'300003',N'Nhóm Hỗ Trợ Sinh Viên','ssg@ueh.edu.vn','D'),
(4,'300004',N'KTX 43-45','ktx4345@ueh.edu.vn','H'),
(5,'300005',N'KTX 135A','ktx135a@ueh.edu.vn','H')
SET IDENTITY_INSERT [dbo].[BanToChuc] OFF 
GO
--Bảng Đơn vị quản lý
SET IDENTITY_INSERT [dbo].[DonViQuanLy] ON 
GO
INSERT INTO dbo.DonViQuanLy ([id_dvql],[MaDVQL],[TenDVQL],[MaToChuc]) VALUES
(1,'400001',N'Đoàn Thanh Niên','D'),
(2,'400002',N'Hội Sinh Viên','H'),
(3,'400003',N'Phòng Chăm Sóc Và Hỗ Trợ Người Học','D'),
(4,'400004',N'Phòng Đào Tạo','D')
SET IDENTITY_INSERT [dbo].[DonViQuanLy] OFF 
GO
--Bảng Tài khoản
SET IDENTITY_INSERT [dbo].[TaiKhoan] ON
GO
INSERT INTO dbo.TaiKhoan ([MaTK],[TenDangNhap],[MatKhau],[LoaiTK],[MSSV],[MaBTC],[MaDVQL],[MSNV]) VALUES
(1,N'sinhvien01',N'123456',N'Sinh Viên',1,NULL,NULL,NULL),
(2,N'sinhvien02',N'111111',N'Sinh Viên',2,NULL,NULL,NULL),
(3,N'admin01',N'123456',N'Admin',NULL,NULL,NULL,1),
(4,N'doanthanhnien',N'123456',N'Đơn Vị Quản lý',NULL,NULL,1,NULL),
(5,N'hoisinhvien',N'123456',N'Đơn Vị Quản lý',NULL,NULL,2,NULL),
(6,N'dsa',N'123456',N'Đơn Vị Quản lý',NULL,NULL,3,NULL),
(7,N'phongdaotao',N'123456',N'Đơn Vị Quản lý',NULL,NULL,4,NULL),
(8,N'chuyentonho@ueh.edu.vn',N'123456',N'Ban Tổ Chức',NULL,1,NULL,NULL),
(9,N'ctxh@ueh.edu.vn',N'123456',N'Ban Tổ Chức',NULL,2,NULL,NULL),
(10,N'ssg@ueh.edu.vn',N'123456',N'Ban Tổ Chức',NULL,3,NULL,NULL),
(11,N'ktx4345@ueh.edu.vn',N'123456',N'Ban Tổ Chức',NULL,4,NULL,NULL),
(12,N'ktx135a@ueh.edu.vn',N'123456',N'Ban Tổ Chức',NULL,5,NULL,NULL)
SET IDENTITY_INSERT [dbo].[TaiKhoan] OFF
GO
--Bảng Lĩnh vực 
INSERT INTO dbo.LinhVuc ([MaLinhVuc],[TenLinhVuc]) VALUES
(1,N'Học tập'),
(2,N'Tình nguyện'),
(3,N'Phong trào'),
(4,N'Tổ chức Xây dựng Đoàn'),
(5,N'Tổ chức Xây dựng Hội sinh viên'),
(6,N'Công nghệ và Truyền thông số')
--Bảng Trạng Thái
INSERT INTO TrangThaiHoatDong ([MaTrangThai], [TenTrangThai]) VALUES
(1,N'Chờ duyệt'),
(2,N'Đã duyệt'),
(3,N'Bị từ chối')
--Bảng Hoạt động
SET IDENTITY_INSERT [dbo].[HoatDong] ON
GO
INSERT INTO dbo.HoatDong ([id_hoatdong],[MaHD],[TenHD],[SoLuongSVmax],[SoluongSV],[NgayBD],[NgayKT],[DiaDiem],[LePhi],[MaLinhVuc],[MaBTC], [MaTrangThai], [MaDVQL]) VALUES
(1,'1120022023',N'Xuân Tình Nguyện','50','1',CAST(N'20240125' AS Date),CAST(N'20240126' AS Date),N'Tiền Giang','200.000',2,2,1,1),
(2,'1120022024',N'Sức Trẻ Kinh Tế','3000','1500',CAST(N'20230326' AS Date),CAST(N'20230327' AS Date),N'Cơ sở N','10.000',1,3,1,1),
(3,'1120022025',N'Chuyến Xe Đoàn Viên','50','1',CAST(N'20240130' AS Date),CAST(N'20240208' AS Date),N'Đại học SPKT','200.000',2,2,2,1),
(4,'1120022026',N'Hội Trại','3000','100',CAST(N'20240326' AS Date),CAST(N'20240327' AS Date),N'Cơ sở N','10.000',1,3,2,1),
(5,'1120022027',N'Vui Hội Trăng Rằm','50','1',CAST(N'20240825' AS Date),CAST(N'20240826' AS Date),N'Tiền Giang','200.000',2,2,1,2),
(6,'1120022028',N'Chào Đón Tân Sinh Viên','3000','1500',CAST(N'20241020' AS Date),CAST(N'20241027' AS Date),N'Cơ sở N','10.000',1,3,1,2),
(7,'1120022029',N'Ngày Hội Nghiên Cứu Khoa Học','300','1',CAST(N'20240130' AS Date),CAST(N'20240208' AS Date),N'Cơ sở B','0',2,2,2,2),
(8,'1120022030',N'Lễ Trao Thưởng UEH500','3000','1500',CAST(N'20240320' AS Date),CAST(N'20240321' AS Date),N'Cơ sở A','0',1,3,2,2)
SET IDENTITY_INSERT [dbo].[HoatDong] OFF
GO

--Bảng Phiếu đăng ký tham gia hoạt động
SET IDENTITY_INSERT [dbo].[PhieuDangKyThamGiaHoatDong] ON
GO
INSERT INTO dbo.PhieuDangKyThamGiaHoatDong ([MaPDKTGHD],[MaHD],[MSSV]) VALUES
(100,1,1),
(102,1,2),
(103,2,1),
(104,2,2)
SET IDENTITY_INSERT [dbo].[PhieuDangKyThamGiaHoatDong] OFF
GO