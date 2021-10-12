create database TIEMGIATLA
on primary (name= QuanLyGiatLa_data, filename='D:\CNPM\TIEMGIATLA\TIEMGIATLA_data.mdf', size=20 MB, maxsize=100 MB, filegrowth=2MB)
log on (name= QuanLyGiatLalog, filename='D:\CNPM\TIEMGIATLA\TIEMGIATLA_log.ldf', size=10 MB, maxsize= 50 MB, filegrowth=1MB);

create table KHACHHANG(
MakH int not null primary key,
Hoten nvarchar(30),
Ngaysinh date,
SDT nvarchar(15) unique not null,
Diachi nvarchar(50));

insert into KHACHHANG(MaKH, Hoten, Ngaysinh, SDT, Diachi)
values ('1', N'nguyễn duy tú', '1999-10-11', '123456789', N'Vĩnh Phúc');
insert into KHACHHANG(MaKH, Hoten, Ngaysinh, SDT, Diachi)
values ('2', N'nguyễn xuân nghĩa', '1999-03-02', '0392917944', N'Thanh Hóa');
insert into KHACHHANG(MaKH, Hoten, Ngaysinh, SDT, Diachi)
values ('3', N'vũ quốc tuấn', '1999-10-07', '1234522389', N'Hà Nội');
create table Nhanvien(
MaNV int not null primary key,
Hoten nvarchar(30),
Ngaysinh date,
SDT nvarchar(15) unique not null,
Diachi nvarchar(50));
insert into Nhanvien(MaNV, Hoten, Ngaysinh, SDT, Diachi)
values ('1', N'nguyễn', '1999-04-08', '2361764124', N'Vĩnh Phúc');
insert into Nhanvien(MaNV, Hoten, Ngaysinh, SDT, Diachi)
values ('2', N'quốc', '1999-07-08', '2361761224', N'Hà Nội');
insert into Nhanvien(MaNV, Hoten, Ngaysinh, SDT, Diachi)
values ('3', N'Xuân', '1999-12-08', '236164124', N'Thanh Hóa');
--bảng đồ giặt 
Create table HANGHOA
(MaHH int not null primary key,  
TenHang nvarchar(50),
DichVu nvarchar(50),
SoLuong decimal(5,1), 
NgayNhan datetime,
NgayTra datetime,
MaKH int, 
MaNV int, 
ConNo int default 0,
TrangThai nvarchar(50));
insert into HANGHOA(MaHH, TenHang, DichVu, SoLuong, NgayNhan, NgayTra, MaKH, MaNV, ConNo, TrangThai)
values ('1', N'áo khoác', N'Giat', '4', '2019-10-29', '2019-10-30', '1', '3', '10000', N'còn hàng');
insert into HANGHOA(MaHH, TenHang, DichVu, SoLuong, NgayNhan, NgayTra, MaKH, MaNV, ConNo, TrangThai)
values ('2', N'áo sơ mi', N'Là', '4', '2019-10-29', '2019-11-01', '2', '2', '0', N'còn hàng');
insert into HANGHOA(MaHH, TenHang, DichVu, SoLuong, NgayNhan, NgayTra, MaKH, MaNV, ConNo, TrangThai)
values ('3', N'quần', N'Sấy', '4', '2019-10-29', '2019-10-30', '1', '3', '0', N'đã trả');
create table Banggia(
Dichvu nvarchar(50) not null unique,
Dongia int not null,
Constraint pk_BANGGIA primary key (Dichvu));
insert into Banggia(Dichvu, Dongia)
values (N'Giat', '30000');
insert into Banggia(Dichvu, Dongia)
values (N'Là', '20000');
insert into Banggia(Dichvu, Dongia)
values (N'Sấy', '10000');
create table Chamcong(
Id int not null primary key,
MaNV int not null,
Ngaylv datetime not null,
GioBD int,
PhutBD int,
GioKT int,
PhutKT int);
insert into Chamcong(Id, MaNV, Ngaylv, GioBD, PhutBD, GioKT, PhutKT)
values ('1', '1', '2019-10-02 08:30:00', '8', '30', '15', '30');
insert into Chamcong(Id, MaNV, Ngaylv, GioBD, PhutBD, GioKT, PhutKT)
values ('2', '2', '2019-10-03 08:30:00', '8', '30', '15', '30');
insert into Chamcong(Id, MaNV, Ngaylv, GioBD, PhutBD, GioKT, PhutKT)
values ('3', '3', '2019-10-04 08:30:00', '8', '30', '15', '30');
create table username(
_User nvarchar(30) not null unique,
_Pass nvarchar(50) not null,
_type nvarchar(20),
Constraint pk_USERNAME primary key (_User));
insert into username(_User, _Pass, _type)
values (N'ADMIN', '123456', N'ADMIN');
insert into username(_User, _Pass, _type)
values (N'Nhanvien', '123456', N'Nhanvien');
alter table HANGHOA add constraint fk_HANGHOA_MaKH foreign key (MaKH) references KHACHHANG(MaKH)on delete cascade on update cascade;		
alter table HANGHOA add constraint fk_HANGHOA_MaBG foreign key (DichVu) references BANGGIA(DichVu) on delete cascade on update cascade;
alter table HANGHOA add constraint fk_HANGHOA_MaNV foreign key (MaNV) references NHANVIEN(MaNV) on delete cascade on update cascade;
alter table CHAMCONG add constraint fk_CHAMCONG_MaNV foreign key (MaNV) references NHANVIEN(MaNV) on delete cascade on update cascade;
use TIEMGIATLA -- tim tên khách hàng
go
create procedure TimTen(@ten nvarchar(20)) 
as
Select * from KHACHHANG where KHACHHANG.HoTen like ('%'+@ten+'%');

dbo.TimTen[Tú]; -- trả về.

use TIEMGIATLA
go
create procedure thongkengay(@ngay int, @thang int, @nam int) -- thông tin đồ giặt theo ngày.
as
select
CONVERT(varchar(30),HANGHOA.NgayNhan,103) as 'Ngaynhan', HANGHOA.Dichvu, sum(HANGHOA.Soluong) as 'Soluong', sum(HANGHOA.Soluong*BANGGIA.DonGia) as 'Thanhtien' 
from HANGHOA, BANGGIA
Where HANGHOA.DichVu = BANGGIA.DichVu and DAY(HANGHOA.NgayNhan) = @ngay and month(HANGHOA.NgayNhan) = @thang and year(HANGHOA.NgayNhan) = @nam
group by CONVERT(varchar(30),HANGHOA.NgayNhan,103),HANGHOA.Dichvu;
dbo.thongkengay[29102019]; -- chưa ra
use TIEMGIATLA
go
create procedure thongkethang(@thang int, @nam int) 
as
select
CONVERT(varchar(30),HANGHOA.NgayNhan,103) as 'Ngaynhan', HANGHOA.Dichvu, sum(HANGHOA.Soluong) as 'Soluong', sum(HANGHOA.Soluong*BANGGIA.DonGia) as 'Thanhtien'
from HANGHOA, BANGGIA
Where HANGHOA.DichVu = BANGGIA.DichVu and month(HANGHOA.NgayNhan) = @thang and year(HANGHOA.NgayNhan) = @nam
group by CONVERT(varchar(30),HANGHOA.NgayNhan,103),HANGHOA.Dichvu;
dbo.thongkethang -- chưa ra
use TIEMGIATLA
go
create procedure thongkekhachno(@thang int, @nam int) -- Hàm tra về khách nợ.
as
select
HANGHOA.MaKH, CONVERT(varchar(30),HANGHOA.NgayNhan,103) as 'Ngaynhan', HANGHOA.Dichvu, sum(ConNo) as 'Thanhtien'
from HANGHOA, BANGGIA
Where HANGHOA.DichVu = BANGGIA.DichVu and HANGHOA.ConNo > 0 and month(HANGHOA.NgayNhan) = @thang and year(HANGHOA.NgayNhan) = @nam
group by HANGHOA.MaKH, CONVERT(varchar(30),HANGHOA.NgayNhan,103),HANGHOA.Dichvu; -- 
use TIEMGIATLA
go
create view HH_HangHoa -- Tạo khung hình view.
as
select MaHH, TenHang, Banggia.Dichvu, SoLuong, NgayNhan, NgayTra, Khachhang.MakH, Nhanvien.MaNV, Conno, TrangThai
from HANGHOA, Khachhang, Banggia, Nhanvien
where HANGHOA.DichVu=Banggia.Dichvu
and HANGHOA.MaKH=Khachhang.MakH
and HANGHOA.MaNV=Nhanvien.MaNV
select *from HH_HangHoa; -- câu lệnh trả về vieww.
use TIEMGIATLA
go
create view CC_ChamCong -- Tạo khung hình .
as
select Id, Nhanvien.MaNV, Ngaylv, GioBD, PhutBD, GioKT, PhutKT
from Chamcong, Nhanvien
where Chamcong.MaNV=Nhanvien.MaNV
select * from CC_ChamCong; -- tra về view.
use TIEMGIATLA
go
create view BG_Banggia -- Khung hình
as
select Dichvu, Dongia
from Banggia
select * from BG_Banggia; -- Tra về
use TIEMGIATLA
go
create view NV_Nhanvien -- Khung hinh
as
select MaNV, Hoten, SDT, Diachi
from Nhanvien
select * from NV_Nhanvien; -- tra về
use TIEMGIATLA
go
create view KH_Khachhang -- Khung hình
as
select Makh, Hoten, SDT, Diachi
from Khachhang
select * from KH_Khachhang; -- Tra về
create function ktsdtnv(@sdt nvarchar(11)) -- Hàm kiêm tra sdt nhân viên đê trả về tên nhân viên.
returns varchar(3)
as
BEGIN
declare @kt varchar(3); 
IF(@sdt in (select sdt from Nhanvien)) set @kt = 'No'
else set @kt = 'Yes';
return @kt 
END;
create function ktsdtkh(@sdt nvarchar(11)) -- Kiêm tra sdt khach hàng đê trả về thông tin khách hàng.
returns varchar(3) 
as 
BEGIN 
declare @kt varchar(3);
IF(@sdt in (select sdt from KHACHHANG)) set @kt = 'No';
else set @kt = 'Yes';
return @kt
END;
create function ktdv(@tendv nvarchar(30))  -- Tra về thông tin cua dịch vụ.
returns varchar(3) 
as 
BEGIN 
declare @kt varchar(3);
IF(@tendv in (select DichVu from BANGGIA)) set @kt = 'No';
else set @kt = 'Yes';
return @kt
END;
create function ktuser(@name nvarchar(30)) -- Trả về thông tin đăng nhập
returns nvarchar(3)
as 
BEGIN 
declare @kt nvarchar(3); 
IF(@name in (select _user from USERNAME)) set @kt = 'No';
else set @kt = 'Yes';
return @kt
END;
create function hotennv(@manv int) -- Trả về thông tin nhân viên
returns nvarchar(30)
as 
BEGIN 
declare @ht nvarchar(30);
select @ht = HoTen
from NHANVIEN
where NHANVIEN.MaNV = @manv
return @ht
END;
create function hotenKH(@makh int) -- Trả về thông tin khach hàng.
returns nvarchar(100)
as
BEGIN
declare @ht nvarchar(30);
select @ht = HoTen
from  KHACHHANG
where KHACHHANG.MaKH = @makh
return @ht
END;
create function thanhtien(@dichvu nvarchar(30), @sl decimal(5,1)) -- Trả về Tiền của đơn hàng.
returns decimal(20,0)
as
BEGIN
declare @tien decimal(20,0); 
select @tien = DonGia*@sl
from BANGGIA
where BANGGIA.DichVu like @dichvu
return @tien 
END;
create proc ChamCongNV -- Thủ tục chấm công nhân viên
as
Select CHAMCONG.Id, NHANVIEN.MaNV, NHANVIEN.HoTen, CHAMCONG.NgayLV, GioBD, PhutBD, GioKT, PhutKT
From CHAMCONG, NHANVIEN
Where CHAMCONG.MaNV  = NHANVIEN.MaNV;
create proc tonggiolv(@manv int, @thang int, @nam int) -- Thủ tục tính tông giờ làm 
as 
select SUM(Giobd) as Giobd, SUM(Phutbd) as Phutbd, SUM(giokt) as Giokt, SUM(Phutkt) as Phutkt
from CHAMCONG
where MONTH(ngaylv) = @thang and year(ngaylv) = @nam and MaNV = @manv;
Insert into USERNAME Values(N'admin',N'admin32',N'Admin');    -- thêm thông tin đăng nhập 
Insert into USERNAME Values(N'abc',N'123',N'Thanh vien');
Delete from USERNAME; -- xóa phân quyền đăng nhập 
CREATE PROC dbo.phanquyen
@user nvarchar(10), @pass nvarchar(10),@type nvarchar(10)

As begin
insert into username(_User, _Pass, _type) values (@user, @pass, @type)
exec sp_addlogin @user,@user exec sp_grantdbaccess @user,@user
if(@user)='ADMIN'
begin exec sp_addrolemember 'ADMIN',@user end
else
begin exec sp_addrolemember 'NHANVIEN',@user end
end
CREATE PROC dbo.them_login
@user nvarchar(10),@pass nvarchar(50)
as begin transaction
declare @themlog nvarchar(300)
set @themlog ='create login ['+@user+'] with password= '''+@pass+''+',default_database=[QL_KS]' exec (@themlog)
declare @themuser nvarchar(300)
set @themuser ='create user ['+@user+'] for login= ['+@user+']'
exec (@themuser) commit transaction  ;
end --lỗi-- 
CREATE PROC dbo.xoaquyen
@user nchar(10),
@pass nvarchar(50)
as begin
delete from username where (_User = @user) and
(@pass =_Pass ) exec sp_droplogin  @user exec sp_dropuser @user
end

GRANT ALL ON Khachhang TO ADMIN
GRANT ALL ON Nhanvien TO ADMIN
GRANT ALL ON HANGHOA TO ADMIN
GRANT ALL ON Banggia TO ADMIN
GRANT ALL ON Chamcong TO ADMIN
GRANT ALL ON username TO ADMIN

GRANT ALL ON Khachhang TO NHANVIEN
GRANT ALL ON Hanghoa TO NHANVIEN
GRANT ALL ON Chamcong TO NHANVIEN
GRANT ALL ON Banggia TO NHANVIEN
create trigger dele_ChamCong
on NhanVien
for delete
as
begin
delete from Chamcong
where MaNV=(select MaNV from deleted)
print N'Xóa thành công ....'
end