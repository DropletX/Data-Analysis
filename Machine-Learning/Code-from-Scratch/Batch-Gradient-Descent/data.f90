! data.f90
program main
  implicit none
  integer :: nrow=100, nx=3
  double precision, dimension(100,3) :: x
  integer :: i, j
  srand()
  ! Initialize random numbers
  do i=1,nrow
    do j=1,nx
      x(i,j) = rand()
    end do
  end do
  open(unit=100,file="data.dat")
  write(100,"(I3,AI1)")nrow," ",nx
  do i=1,nrow
    write(100,"(4F6.3)")10D0+3*x(i,1)+4*x(i,2)+5*x(i,3)+rand(),x(i,1),x(i,2),x(i,3)
  end do
  close(100)
end program main
