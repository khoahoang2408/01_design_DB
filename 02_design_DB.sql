SELECT * FROM furama.villa;
CREATE TABLE KhachHang(
    idKhachHang INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    idLoaiKhach int NOT NULL ,
    hoTen varchar(50) not NULL ,
    ngaySinh date not null,
    soCmt int not null,
    sdt int not null,
    email varchar(50) not null,
    diaChi varchar(50),
    FOREIGN KEY (idLoaiKhach) REFERENCES LoaiKhachHang(idLoaiKhach)
);
create table LoaiKhachHang(
	idLoaiKhach int  NOT NULL PRIMARY KEY AUTO_INCREMENT,
    tenLoaiKhach varchar(50)
);
create table ViTri(
	idViTri INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    tenViTri varchar(50)
);
create table TrinhDo(
	idTrinhDo INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    trinhDo varchar(50)
);
create table BoPhan(
	idBoPhan INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    tenBoPhan varchar(50)
);
create table NhanVien(
	idNhanVien INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    hoTen varchar(50) not null,
    idViTri int not null,
    idTrinhDo int not null,
    idBoPhan int not null,
    ngaySinh date not null,
    soCMT int not null,
    luong int not null,
    sdt int not null,
    email varchar(50),
    diaChi varchar(50),
     FOREIGN KEY (idViTri) REFERENCES ViTri(idViTri),
	 FOREIGN KEY (idTrinhDo) REFERENCES TrinhDo(idTrinhDo),
	 FOREIGN KEY (idBoPhan) REFERENCES BoPhan(idBoPhan)
);
create table KieuThue(
	idKieuThue int not null primary key auto_increment,
    tenKieuThue varchar(50) not null,
    gia int not null
);
create table LoaiDichVu(
	idLoaiDichVu int not null primary key auto_increment,
    tenLoaiDichVu varchar(50)
);
create table DichVu(
	idDichVu int not null primary key auto_increment,
    tenDichVu varchar(50) not null,
    dienTich int not null,
    soTang int not null,
    soNguoiToiDa int not null,
    chiPhiThue int not null,
    trangThai varchar(50),
    idKieuThue int not null,
    idLoaiDichVu int not null,
    foreign key (idKieuThue) references KieuThue(idKieuThue),
    foreign key (idLoaiDichVu) references LoaiDichVu(idLoaiDichVu)
);
create table DichVuDiKem(
    idDichVuDiKem int not null primary key auto_increment,
    tenDichVuDiKem varchar(50)not null,
    gia int not null,
    donVi varchar(50) not null,
    trangThaiKhaDung varchar(50)
);
create table HopDongChitiet(
	idHopDongChiTiet int not null primary key auto_increment,
    idDichVuDiKem int not null,
    idHopDong int not null,
    soLuong int not null,
    foreign key (idHopDong) references HopDong(idHopDong),
    foreign key (idDichVuDiKem) references DichVuDiKem(idDichVuDiKem)
);
create table HopDong(
	idHopDong int not null primary key auto_increment,
    idNhanVien int not null,
    idKhachHang int not null,
    idDichVu int not null ,
    ngayLamHopDong date not null,
    ngayKetThuc date not null,
    tongTien int not null,
    foreign key (idNhanVien) references NhanVien(idNhanVien),
	foreign key (idKhachHang) references KhachHang(idKhachHang),
    foreign key (idDichVu) references DichVu(idDichVu)
);
--- câu 1: ok
-- ---------------------------------------------------------------------------------------------
-- câu 2: 2.	Hiển thị thông tin của tất cả nhân viên có trong hệ thống có tên bắt đầu là một 
-- trong các ký tự “H”, “T” hoặc “K” và có tối đa 15 ký tự.
-- ( SUBSTRING_INDEX(SUBSTRING_INDEX(n.hoTen, ' ',- 1), ' ', 2)
select n.idNhanVien,n.hoTen,n.ngaySinh,n.soCMT,n.luong,n.sdt,n.email,n.diaChi,t.trinhDo,v.tenViTri,b.tenBoPhan 
from nhanvien n 
join bophan b on n.idBoPhan = b.idBoPhan
join vitri v on n.idViTri = v.idViTri
join trinhdo t on n.idTrinhDo = t.idTrinhDo where( SUBSTRING_INDEX(SUBSTRING_INDEX(n.hoTen, ' ',- 1), ' ', 2) like "m%" 
or SUBSTRING_INDEX(SUBSTRING_INDEX(n.hoTen, ' ',- 1), ' ', 2) like "t%" or 
SUBSTRING_INDEX(SUBSTRING_INDEX(n.hoTen, ' ',- 1), ' ', 2) like "k%")
and  CHAR_LENGTH(n.hoTen) < 15 ;  
-- ---------------------------------------------------------------------------------------------
-- câu 3:Hiển thị thông tin của tất cả kháchkhachhang hàng có độ tuổi từ 18 đến 50 tuổi và có địa chỉ ở “Đà Nẵng”
--  hoặc “Quảng Trị”.
-- SELECT YEAR(CURRENT_TIMESTAMP) - YEAR(ngaySinh) from khachhang;
select * from khachhang where ( YEAR(CURRENT_TIMESTAMP) - YEAR(ngaySinh)<50
and YEAR(CURRENT_TIMESTAMP) - YEAR(ngaySinh)>18) and diaChi ="quảng nam" or
 YEAR(CURRENT_TIMESTAMP) - YEAR(ngaySinh)<50
and YEAR(CURRENT_TIMESTAMP) - YEAR(ngaySinh)>18 and diaChi ="đà nẵng";

select k.idKhachHang,k.hoTen,k.ngaySinh,k.soCmt,k.sdt,k.email,k.diaChi,lk.tenLoaiKhach from  khachhang k 
join loaikhachhang lk on k.idLoaiKhach = lk.idLoaiKhach where  ( YEAR(CURRENT_TIMESTAMP) - YEAR(ngaySinh)<50
and YEAR(CURRENT_TIMESTAMP) - YEAR(ngaySinh)>18) and (diaChi ="quảng nam" or diaChi ="đà nẵng");

-- ---------------------------------------------------------------------------------------------
-- câu 4: 4.	Đếm xem tương ứng với mỗi khách hàng đã từng đặt phòng bao nhiêu lần.
--  Kết quả hiển thị được sắp xếp tăng dần theo số lần đặt phòng của khách hàng.
--  Chỉ đếm những khách hàng nào có Tên loại khách hàng là “Diamond”.
select count(hoten) , hoTen from khachhang where idLoaiKhach =1 group by hoTen order by hoTen desc ;
SELECT * FROM furama.khachhang;

 SELECT * FROM furama.hopdong ;
 -- ---------------------------------------------------------------------------------------------
--  câu 5: 5.	Hiển thị IDKhachHang, HoTen, TenLoaiKhach, IDHopDong, TenDichVu, NgayLamHopDong,
--  NgayKetThuc, TongTien (Với TongTien được tính theo công thức như sau: ChiPhiThue + SoLuong*Gia,
--  với SoLuong và Giá là từ bảng DichVuDiKem) cho tất cả các Khách hàng đã từng đặt phỏng.
--  (Những Khách hàng nào chưa từng đặt phòng cũng phải hiển thị ra).

select hopdong.idKhachHang,khachhang.hoTen,loaiKhachHang.tenLoaiKhach,hopdong.idHopDong,dichvu.tenDichVu,hopdong.ngayLamHopDong,
hopdong.ngayKetThuc,sum(dichvu.chiPhiThue+hopdongchitiet.soLuong)*dichvudikem.gia as total ,dichvudikem.gia
 from hopdong 
join khachhang on khachhang.idKhachHang = hopdong.idKhachHang
join dichvu on dichvu.idDichVu = hopdong.idDichVu
join dichvudikem on hopdong.idHopDong = dichvudikem.idDichVuDiKem
join loaikhachhang on khachhang.idLoaiKhach = loaikhachhang.idLoaiKhach
join hopdongchitiet on hopdongchitiet.idDichVuDiKem = dichvudikem.idDichVuDiKem;
-- câu 6:
 select dichvu.idDichVu,dichvu.tenDichVu,dichvu.dienTich,dichvu.chiPhiThue,loaidichvu.tenLoaiDichVu from dichvu
 join loaidichvu on loaidichvu.idLoaiDichVu = dichvu.idLoaiDichVu
 where  dichvu.idDichVu  not in 
 (select idDichVu from hopdong where year(ngayLamHopDong) = 2019 and quarter(ngayLamHopDong)=1);
--  -----------------------------------------------------------------------------------------------------------------
 -- câu 7:
  select dichvu.idDichVu,dichvu.tenDichVu,dichvu.dienTich,dichvu.soNguoiToiDa,dichvu.chiPhiThue,loaidichvu.tenLoaiDichVu from dichvu
 join loaidichvu on loaidichvu.idLoaiDichVu = dichvu.idLoaiDichVu
 where  (dichvu.idDichVu  in 
 (select idDichVu from hopdong where year(ngayLamHopDong) = 2018)) and (dichvu.idDichVu 
 not in (select idDichVu from hopdong where year(ngayLamHopDong)=2019));
 -- câu 8
 select DISTINCT HoTen from khachhang;
select Hoten from khachhang group by Hoten;
select Hoten from khachhang group by Hoten having count(Hoten) =1 union select Hoten from khachhang 
 having count(Hoten) > 1 ;
 -- câu 9
 select month(ngayLamhopDong) as thang_months, count(IDKhachHang) as SoKhachHang from hopdong 
 where year(ngayLamhopDong) = 2020  group by thang_months order by thang_months asc;
 -- câu 10
 select hopdong.IDHopDong, hopdong.ngayLamHopDong, hopdong.NgayKetThuc, count(hopdongchitiet.IDDichVuDiKem)
 as SoLuongDichVuDiKem  from hopdong left join hopdongchitiet on hopdong.IDHopDong = hopdongchitiet.IDHopDong 
 group by hopdong.IDHopDong;
-- câu 11 
 select dichvudikem.IDDichVuDiKem, dichvudikem.tenDichVuDiKem, dichvudikem.Gia, dichvudikem.DonVi, dichvudikem.trangThaiKhaDung
 from ((((dichvudikem inner join hopdongchitiet on dichvudikem.IDDichVuDiKem = hopdongchitiet.IDDichVuDiKem)
 inner join hopdong on hopdong.IDHopDong = hopdongchitiet.IDHopDong) 
 inner join khachhang on khachhang.IDKhachHang = hopdong.IDKhachHang) 
 inner join loaikhachhang on loaikhachhang.IDLoaiKhach = khachhang.IDLoaiKhach)
 where (loaikhachhang.TenLoaiKhach like "Diamond") and
 (khachhang.Diachi like "%Quang Ngai%" or khachhang.Diachi like "%Vinh%");
 -- câu 12 
 select hopdong.IDHopDong, nhanvien.HoTen as NhanVien, khachhang.Hoten as KhachHang,
 khachhang.SDT, dichvu.TenDichVu, count(hopdongchitiet.IDDichVuDiKem) as SoLuongDichVuDikem 
 from ((((nhanvien inner join hopdong on nhanvien.IDNhanVien = hopdong.IDNhanVien) 
 inner join khachhang on khachhang.IDKhachHang = hopdong.IDKhachHang)
 inner join dichvu on dichvu.IDDichVu = hopdong.IDDichVu) 
 inner join hopdongchitiet on hopdongchitiet.IDHopDong = hopdong.IDHopDong)
 where hopdong.ngayLamHopDong not in (select ngayLamHopDong from hopdong
 where month(ngayLamHopDong) = 6) and (year(hopdong.ngayLamHopDong) = 2019 
 and quarter(hopdong.ngayLamHopDong) = 4) group by hopdong.IDHopDong;
 -- câu 13
--  13.	Hiển thị thông tin các Dịch vụ đi kèm được sử dụng nhiều nhất bởi các Khách hàng đã đặt phòng. 
--  (Lưu ý là có thể có nhiều dịch vụ có số lần sử dụng nhiều như nhau).dichvudikem
 select sum(hopdongchitiet.soluong), dichvudikem.tendichvudikem
 from hopdongchitiet
 join dichvudikem on dichvudikem.idDichVuDiKem = hopdongchitiet.idDichVuDiKem
 group by dichvudikem.idDichVuDiKem order by hopdongchitiet.soluong desc limit 1;
 -- câu 14
 
-- 1.	Hiển thị thông tin tất cả các Dịch vụ đi kèm chỉ mới được sử dụng một lần duy nhất. 
-- Thông tin hiển thị bao gồm IDHopDong, TenLoaiDichVu, TenDichVuDiKem, SoLanSuDung.

 select sum(hopdongchitiet.soluong), dichvudikem.tendichvudikem
 from hopdongchitiet
 join dichvudikem on dichvudikem.idDichVuDiKem = hopdongchitiet.idDichVuDiKem
 group by dichvudikem.idDichVuDiKem  having sum(hopdongchitiet.soluong) = 1;
 
-- câu 15
-- 15.	Hiển thi thông tin của tất cả nhân viên bao gồm IDNhanVien, HoTen, TrinhDo, TenBoPhan, SoDienThoai,
--  DiaChi mới chỉ lập được tối đa 3 hợp đồng từ năm 2018 đến 2019.

select count(hopdong.idnhanvien),nhanvien.hoten from nhanvien
join hopdong on hopdong.idnhanvien = nhanvien.idnhanvien
where  year(hopdong.ngayLamHopDong) between 2018 and 2020
group by hopdong.idNhanVien having count(hopdong.idnhanvien)<=3;
-- câu 16
-- 16.	Xóa những Nhân viên chưa từng lập được hợp đồng nào từ năm 2017 đến năm 2019.
delete from nhanvien where idNhanVien=(select count(hopdong.idnhanvien),nhanvien.hoten,nhanvien.idViTri,nhanvien.idTrinhDo,nhanvien.diaChi
,hopdong.ngayLamHopDong 
from nhanvien
join hopdong on hopdong.idnhanvien = nhanvien.idnhanvien
where  year(hopdong.ngayLamHopDong) between 2020 and 2021
group by nhanvien.idNhanVien having count(hopdong.idnhanvien)<3);

-- --------------------------------------------------------------------------------------------------------------------
select * from hopdong
join dichvu on hopdong.idDichVu = dichvu.idDichVu
join hopdongchitiet on hopdongchitiet.idHopDong = hopdong.idHopDong
join dichvudikem on dichvudikem.idDichVuDiKem= hopdongchitiet.idDichVuDiKem
 where tongTien = (dichvu.chiPhiThue +  hopdongchitiet.soLuong*dichvudikem.gia);
-- câu 20: Hiển thị thông tin của tất cả các Nhân viên và Khách hàng có trong hệ thống, 
-- thông tin hiển thị bao gồm ID (IDNhanVien, IDKhachHang), HoTen, Email, SoDienThoai, NgaySinh, DiaChi.
select nhanvien.idNhanVien,nhanvien.hoTen,nhanvien.email,nhanvien.sdt,nhanvien.ngaySinh,
nhanvien.diaChi,khachhang.idKhachHang,khachhang.hoTen,khachhang.ngaySinh,
khachhang.soCmt,khachhang.sdt,khachhang.email,khachhang.diaChi from nhanvien
join khachhang;

-- câu 21:	Tạo khung nhìn có tên là V_NHANVIEN để lấy được thông tin của tất cả các nhân viên có địa chỉ là “Hải Châu”
--  và đã từng lập hợp đồng cho 1 hoặc nhiều Khách hàng bất kỳ  với ngày lập hợp đồng là “12/12/2019”


CREATE VIEW viewEmployee AS
select nhanvien.idNhanVien,nhanvien.hoTen,nhanvien.diaChi,nhanvien.idBoPhan from nhanvien
join hopdong on hopdong.idNhanVien = nhanvien.idNhanVien
where year(hopdong.ngayLamHopDong) between 2020 and 2021
;

-- --------------------------------------------------------------------------------------------------------------
-- câu22.	Thông qua khung nhìn V_NHANVIEN thực hiện cập nhật địa chỉ thành “Liên Chiểu” đối với tất cả các Nhân viên
--  được nhìn thấy bởi khung nhìn này.

 update viewEmployee
 set diaChi ='liên chiểu';
 
-- ------------------------------------------------------------------------------------------------------------
-- câu 25: 23.	Tạo Store procedure Sp_1 Dùng để xóa thông tin của một Khách hàng nào
--  đó với Id Khách hàng được truyền vào như là 1 tham số của Sp_1
DELIMITER //
CREATE PROCEDURE Sp_1(
IN id_kh INT,
OUT message VARCHAR(50)
)
IF id_pr in (Select id from khachhang) THEN
BEGIN
	DELETE  FROM hopdong WHERE hopdong.idKhachHang = id_kh;
	DELETE  FROM khachhang WHERE khachhang.idKhachHang = id_kh;
    SET message = "Đã xóa học sinh" ;
END;
ELSE
BEGIN
SET message = "Học sinh không tồn tại" ;
END;
END IF;
DELIMITER ;
-- ---------------------------------------------------------------------------------
-- câu 26
-- 26.	Tạo Store procedure Sp_2 Dùng để thêm mới vào bảng HopDong với yêu cầu Sp_2 phải thực hiện kiểm tra tính hợp lệ 
-- của dữ liệu bổ sung, với nguyên tắc không được trùng khóa chính và đảm bảo toàn vẹn tham chiếu đến các bảng liên quan.
select * from hopdong;


INSERT INTO `furama`.`hopdong`
 (`idNhanVien`, `idKhachHang`, `idDichVu`, `ngayLamHopDong`, `ngayKetThuc`, `tongTien`) 
 VALUES ('2', '1', '2', '2021-03-02', '2021-03-07', '7000');

DELIMITER //
CREATE PROCEDURE Sp_2(
in idkhachhang int
)
BEGIN
	INSERT INTO `furama`.`hopdong`
 (`idNhanVien`, `idKhachHang`, `idDichVu`, `ngayLamHopDong`, `ngayKetThuc`, `tongTien`) 
 VALUES ('2', '1', '2', '2021-03-02', '2021-03-07', '7000');
END;
END IF;
DELIMITER ;
