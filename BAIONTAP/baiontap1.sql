--1. Hiển thị thông tin những dự án ở Nha Trang hoặc Bình Phước?
Select * from duan 
where diadiem = N'Nha Trang' or diadiem = N'Bình Phước'
--2. Hiển thị danh sách nhân viên phòng Phát triển phần mềm, nhỏ hơn 25 tuổi?
insert nhanvien values ('mv11',N'Trần Thanh',N'Cường',0,'1990-08-25',N'Mỹ',10000,4)
insert nhanvien values ('mv12',N'Hà Duy',N'Kiên',0,'2004-11-30',N'Anh',100000,3)
select nhanvien.* from nhanvien join phongban on phongban.Maphong=nhanvien.maphong 
and datediff(year,ngaysinh,getdate())<25 
and tenphong like N'Phát triển phần mềm'
--3. Thống kê số lượng nhân viên theo mã phòng?
select maphong "Mã Phòng" , count(manv) "Số lượng nhân viên" from nhanvien group by maphong
--4. Hiển thị danh sách những nhân viên có lương cao nhất?
insert nhanvien values ('mv13',N'Lê Quang',N'Đỗ',0,'2000-03-12',N'Ba Lan',100000,4)
Select nhanvien.* from nhanvien where luong = (select max(luong) from nhanvien)
--5. Hãy cho biết tổng số giờ của mỗi dự án?
select d.tenduan "Tên dự án",sum(p.sogio) "Tổng số giờ" 
from duan d join phancong p on d.maduan=p.maduan 
group by d.tenduan
--6. Tăng lương thêm 200000 cho những nhân viên tham gia 3 dự án trở lên
update nhanvien 
set luong=luong+200000
where manv in (select manv, count(maduan) "số dự án tham gia" from phancong group by manv having count(maduan)>=3)
--7. Cho biết có bao nhiêu dự án ở Bình Định ?
select diadiem,count(maduan) "số dự án" from duan
where diadiem like N'Bình Định'
group by diadiem
--8. Hiển thị danh sách nhân viên nam (gioitinh=1), trên 30 tuổi
select nhanvien.* from nhanvien where gioitinh = 1 and DATEDIFF(year,ngaysinh,getdate())>=30
--9. Hiển thị danh sách các dự án ở Bình Định, có số giờ trên 20
insert phancong 
values ('mv11','11',15)
select tenduan, sum(sogio) "số giờ" from duan join phancong 
on duan.maduan=phancong.maduan and diadiem like N'Bình Định'
group by tenduan
having sum(sogio)>20
--10. Thống kê số dự án theo mã phòng, phòng nào chưa nhận dự án thì sẽ cho kết quả là 0.
select  a.maphong,count(a.tenduan) "số dự án"
from (select phongban.Maphong,tenphong,duan.tenduan from phongban left join duan on phongban.Maphong=duan.maphong) a
group by a.Maphong