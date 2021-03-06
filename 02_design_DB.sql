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
--- c??u 1: ok
-- ---------------------------------------------------------------------------------------------
-- c??u 2: 2.	Hi???n th??? th??ng tin c???a t???t c??? nh??n vi??n c?? trong h??? th???ng c?? t??n b???t ?????u l?? m???t 
-- trong c??c k?? t??? ???H???, ???T??? ho???c ???K??? v?? c?? t???i ??a 15 k?? t???.
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
-- c??u 3:Hi???n th??? th??ng tin c???a t???t c??? kh??chkhachhang h??ng c?? ????? tu???i t??? 18 ?????n 50 tu???i v?? c?? ?????a ch??? ??? ??????? N???ng???
--  ho???c ???Qu???ng Tr??????.
-- SELECT YEAR(CURRENT_TIMESTAMP) - YEAR(ngaySinh) from khachhang;
select * from khachhang where ( YEAR(CURRENT_TIMESTAMP) - YEAR(ngaySinh)<50
and YEAR(CURRENT_TIMESTAMP) - YEAR(ngaySinh)>18) and diaChi ="qu???ng nam" or
 YEAR(CURRENT_TIMESTAMP) - YEAR(ngaySinh)<50
and YEAR(CURRENT_TIMESTAMP) - YEAR(ngaySinh)>18 and diaChi ="???? n???ng";

select k.idKhachHang,k.hoTen,k.ngaySinh,k.soCmt,k.sdt,k.email,k.diaChi,lk.tenLoaiKhach from  khachhang k 
join loaikhachhang lk on k.idLoaiKhach = lk.idLoaiKhach where  ( YEAR(CURRENT_TIMESTAMP) - YEAR(ngaySinh)<50
and YEAR(CURRENT_TIMESTAMP) - YEAR(ngaySinh)>18) and (diaChi ="qu???ng nam" or diaChi ="???? n???ng");

-- ---------------------------------------------------------------------------------------------
-- c??u 4: 4.	?????m xem t????ng ???ng v???i m???i kh??ch h??ng ???? t???ng ?????t ph??ng bao nhi??u l???n.
--  K???t qu??? hi???n th??? ???????c s???p x???p t??ng d???n theo s??? l???n ?????t ph??ng c???a kh??ch h??ng.
--  Ch??? ?????m nh???ng kh??ch h??ng n??o c?? T??n lo???i kh??ch h??ng l?? ???Diamond???.
select count(hoten) , hoTen from khachhang where idLoaiKhach =1 group by hoTen order by hoTen desc ;
SELECT * FROM furama.khachhang;

 SELECT * FROM furama.hopdong ;
 -- ---------------------------------------------------------------------------------------------
--  c??u 5: 5.	Hi???n th??? IDKhachHang, HoTen, TenLoaiKhach, IDHopDong, TenDichVu, NgayLamHopDong,
--  NgayKetThuc, TongTien (V???i TongTien ???????c t??nh theo c??ng th???c nh?? sau: ChiPhiThue + SoLuong*Gia,
--  v???i SoLuong v?? Gi?? l?? t??? b???ng DichVuDiKem) cho t???t c??? c??c Kh??ch h??ng ???? t???ng ?????t ph???ng.
--  (Nh???ng Kh??ch h??ng n??o ch??a t???ng ?????t ph??ng c??ng ph???i hi???n th??? ra).

select hopdong.idKhachHang,khachhang.hoTen,loaiKhachHang.tenLoaiKhach,hopdong.idHopDong,dichvu.tenDichVu,hopdong.ngayLamHopDong,
hopdong.ngayKetThuc,sum(dichvu.chiPhiThue+hopdongchitiet.soLuong)*dichvudikem.gia as total ,dichvudikem.gia
 from hopdong 
join khachhang on khachhang.idKhachHang = hopdong.idKhachHang
join dichvu on dichvu.idDichVu = hopdong.idDichVu
join dichvudikem on hopdong.idHopDong = dichvudikem.idDichVuDiKem
join loaikhachhang on khachhang.idLoaiKhach = loaikhachhang.idLoaiKhach
join hopdongchitiet on hopdongchitiet.idDichVuDiKem = dichvudikem.idDichVuDiKem;
-- c??u 6:
 select dichvu.idDichVu,dichvu.tenDichVu,dichvu.dienTich,dichvu.chiPhiThue,loaidichvu.tenLoaiDichVu from dichvu
 join loaidichvu on loaidichvu.idLoaiDichVu = dichvu.idLoaiDichVu
 where  dichvu.idDichVu  not in 
 (select idDichVu from hopdong where year(ngayLamHopDong) = 2019 and quarter(ngayLamHopDong)=1);
--  -----------------------------------------------------------------------------------------------------------------
 -- c??u 7:
  select dichvu.idDichVu,dichvu.tenDichVu,dichvu.dienTich,dichvu.soNguoiToiDa,dichvu.chiPhiThue,loaidichvu.tenLoaiDichVu from dichvu
 join loaidichvu on loaidichvu.idLoaiDichVu = dichvu.idLoaiDichVu
 where  (dichvu.idDichVu  in 
 (select idDichVu from hopdong where year(ngayLamHopDong) = 2018)) and (dichvu.idDichVu 
 not in (select idDichVu from hopdong where year(ngayLamHopDong)=2019));
 -- c??u 8
 select DISTINCT HoTen from khachhang;
select Hoten from khachhang group by Hoten;
select Hoten from khachhang group by Hoten having count(Hoten) =1 union select Hoten from khachhang 
 having count(Hoten) > 1 ;
 -- c??u 9
 select month(ngayLamhopDong) as thang_months, count(IDKhachHang) as SoKhachHang from hopdong 
 where year(ngayLamhopDong) = 2020  group by thang_months order by thang_months asc;
 -- c??u 10
 select hopdong.IDHopDong, hopdong.ngayLamHopDong, hopdong.NgayKetThuc, count(hopdongchitiet.IDDichVuDiKem)
 as SoLuongDichVuDiKem  from hopdong left join hopdongchitiet on hopdong.IDHopDong = hopdongchitiet.IDHopDong 
 group by hopdong.IDHopDong;
-- c??u 11 
 select dichvudikem.IDDichVuDiKem, dichvudikem.tenDichVuDiKem, dichvudikem.Gia, dichvudikem.DonVi, dichvudikem.trangThaiKhaDung
 from ((((dichvudikem inner join hopdongchitiet on dichvudikem.IDDichVuDiKem = hopdongchitiet.IDDichVuDiKem)
 inner join hopdong on hopdong.IDHopDong = hopdongchitiet.IDHopDong) 
 inner join khachhang on khachhang.IDKhachHang = hopdong.IDKhachHang) 
 inner join loaikhachhang on loaikhachhang.IDLoaiKhach = khachhang.IDLoaiKhach)
 where (loaikhachhang.TenLoaiKhach like "Diamond") and
 (khachhang.Diachi like "%Quang Ngai%" or khachhang.Diachi like "%Vinh%");
 -- c??u 12 
 select hopdong.IDHopDong, nhanvien.HoTen as NhanVien, khachhang.Hoten as KhachHang,
 khachhang.SDT, dichvu.TenDichVu, count(hopdongchitiet.IDDichVuDiKem) as SoLuongDichVuDikem 
 from ((((nhanvien inner join hopdong on nhanvien.IDNhanVien = hopdong.IDNhanVien) 
 inner join khachhang on khachhang.IDKhachHang = hopdong.IDKhachHang)
 inner join dichvu on dichvu.IDDichVu = hopdong.IDDichVu) 
 inner join hopdongchitiet on hopdongchitiet.IDHopDong = hopdong.IDHopDong)
 where hopdong.ngayLamHopDong not in (select ngayLamHopDong from hopdong
 where month(ngayLamHopDong) = 6) and (year(hopdong.ngayLamHopDong) = 2019 
 and quarter(hopdong.ngayLamHopDong) = 4) group by hopdong.IDHopDong;
 -- c??u 13
--  13.	Hi???n th??? th??ng tin c??c D???ch v??? ??i k??m ???????c s??? d???ng nhi???u nh???t b???i c??c Kh??ch h??ng ???? ?????t ph??ng. 
--  (L??u ?? l?? c?? th??? c?? nhi???u d???ch v??? c?? s??? l???n s??? d???ng nhi???u nh?? nhau).dichvudikem
 select sum(hopdongchitiet.soluong), dichvudikem.tendichvudikem
 from hopdongchitiet
 join dichvudikem on dichvudikem.idDichVuDiKem = hopdongchitiet.idDichVuDiKem
 group by dichvudikem.idDichVuDiKem order by hopdongchitiet.soluong desc limit 1;
 -- c??u 14
 
-- 1.	Hi???n th??? th??ng tin t???t c??? c??c D???ch v??? ??i k??m ch??? m???i ???????c s??? d???ng m???t l???n duy nh???t. 
-- Th??ng tin hi???n th??? bao g???m IDHopDong, TenLoaiDichVu, TenDichVuDiKem, SoLanSuDung.

 select sum(hopdongchitiet.soluong), dichvudikem.tendichvudikem
 from hopdongchitiet
 join dichvudikem on dichvudikem.idDichVuDiKem = hopdongchitiet.idDichVuDiKem
 group by dichvudikem.idDichVuDiKem  having sum(hopdongchitiet.soluong) = 1;
 
-- c??u 15
-- 15.	Hi???n thi th??ng tin c???a t???t c??? nh??n vi??n bao g???m IDNhanVien, HoTen, TrinhDo, TenBoPhan, SoDienThoai,
--  DiaChi m???i ch??? l???p ???????c t???i ??a 3 h???p ?????ng t??? n??m 2018 ?????n 2019.

select count(hopdong.idnhanvien),nhanvien.hoten from nhanvien
join hopdong on hopdong.idnhanvien = nhanvien.idnhanvien
where  year(hopdong.ngayLamHopDong) between 2018 and 2020
group by hopdong.idNhanVien having count(hopdong.idnhanvien)<=3;
-- c??u 16
-- 16.	X??a nh???ng Nh??n vi??n ch??a t???ng l???p ???????c h???p ?????ng n??o t??? n??m 2017 ?????n n??m 2019.
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
-- c??u 20: Hi???n th??? th??ng tin c???a t???t c??? c??c Nh??n vi??n v?? Kh??ch h??ng c?? trong h??? th???ng, 
-- th??ng tin hi???n th??? bao g???m ID (IDNhanVien, IDKhachHang), HoTen, Email, SoDienThoai, NgaySinh, DiaChi.
select nhanvien.idNhanVien,nhanvien.hoTen,nhanvien.email,nhanvien.sdt,nhanvien.ngaySinh,
nhanvien.diaChi,khachhang.idKhachHang,khachhang.hoTen,khachhang.ngaySinh,
khachhang.soCmt,khachhang.sdt,khachhang.email,khachhang.diaChi from nhanvien
join khachhang;

-- c??u 21:	T???o khung nh??n c?? t??n l?? V_NHANVIEN ????? l???y ???????c th??ng tin c???a t???t c??? c??c nh??n vi??n c?? ?????a ch??? l?? ???H???i Ch??u???
--  v?? ???? t???ng l???p h???p ?????ng cho 1 ho???c nhi???u Kh??ch h??ng b???t k???  v???i ng??y l???p h???p ?????ng l?? ???12/12/2019???


CREATE VIEW viewEmployee AS
select nhanvien.idNhanVien,nhanvien.hoTen,nhanvien.diaChi,nhanvien.idBoPhan from nhanvien
join hopdong on hopdong.idNhanVien = nhanvien.idNhanVien
where year(hopdong.ngayLamHopDong) between 2020 and 2021
;

-- --------------------------------------------------------------------------------------------------------------
-- c??u22.	Th??ng qua khung nh??n V_NHANVIEN th???c hi???n c???p nh???t ?????a ch??? th??nh ???Li??n Chi???u??? ?????i v???i t???t c??? c??c Nh??n vi??n
--  ???????c nh??n th???y b???i khung nh??n n??y.

 update viewEmployee
 set diaChi ='li??n chi???u';
 
-- ------------------------------------------------------------------------------------------------------------
-- c??u 25: 23.	T???o Store procedure Sp_1 D??ng ????? x??a th??ng tin c???a m???t Kh??ch h??ng n??o
--  ???? v???i Id Kh??ch h??ng ???????c truy???n v??o nh?? l?? 1 tham s??? c???a Sp_1
DELIMITER //
CREATE PROCEDURE Sp_1(
IN id_kh INT,
OUT message VARCHAR(50)
)
IF id_pr in (Select id from khachhang) THEN
BEGIN
	DELETE  FROM hopdong WHERE hopdong.idKhachHang = id_kh;
	DELETE  FROM khachhang WHERE khachhang.idKhachHang = id_kh;
    SET message = "???? x??a h???c sinh" ;
END;
ELSE
BEGIN
SET message = "H???c sinh kh??ng t???n t???i" ;
END;
END IF;
DELIMITER ;
-- ---------------------------------------------------------------------------------
-- c??u 26
-- 26.	T???o Store procedure Sp_2 D??ng ????? th??m m???i v??o b???ng HopDong v???i y??u c???u Sp_2 ph???i th???c hi???n ki???m tra t??nh h???p l??? 
-- c???a d??? li???u b??? sung, v???i nguy??n t???c kh??ng ???????c tr??ng kh??a ch??nh v?? ?????m b???o to??n v???n tham chi???u ?????n c??c b???ng li??n quan.
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
