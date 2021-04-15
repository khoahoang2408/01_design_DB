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
-- câu 2: 2.	Hiển thị thông tin của tất cả nhân viên có trong hệ thống có tên bắt đầu là một 
-- trong các ký tự “H”, “T” hoặc “K” và có tối đa 15 ký tự.
select * from nhanvien where SUBSTRING_INDEX(SUBSTRING_INDEX(hoTen, ' ',- 1), ' ', 2) like "m%" 
or SUBSTRING_INDEX(SUBSTRING_INDEX(hoTen, ' ',- 1), ' ', 2) like "t%" or 
SUBSTRING_INDEX(SUBSTRING_INDEX(hoTen, ' ',- 1), ' ', 2) like "k%"
and  CHAR_LENGTH(hoTen) < 15 ;  

select n.idNhanVien,n.hoTen,n.ngaySinh,n.soCMT,n.luong,n.sdt,n.email,n.diaChi,t.trinhDo,v.tenViTri,b.tenBoPhan 
from nhanvien n 
join bophan b on n.idBoPhan = b.idBoPhan
join vitri v on n.idViTri = v.idViTri
join trinhdo t on n.idTrinhDo = t.idTrinhDo where SUBSTRING_INDEX(SUBSTRING_INDEX(n.hoTen, ' ',- 1), ' ', 2) like "m%" 
or SUBSTRING_INDEX(SUBSTRING_INDEX(n.hoTen, ' ',- 1), ' ', 2) like "t%" or 
SUBSTRING_INDEX(SUBSTRING_INDEX(n.hoTen, ' ',- 1), ' ', 2) like "k%"
and  CHAR_LENGTH(n.hoTen) < 15 ;  ;
