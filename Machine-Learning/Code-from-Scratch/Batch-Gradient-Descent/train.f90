! train.f90
program main
  use read_data
  use glm
  implicit none
  double precision :: q
  double precision, dimension(:), allocatable :: theta
  integer :: i,j
  call read(file="data.dat",intercept=.true.)
  theta = batch_gradient_descent(g=identity,x=x,y=y,tol=0.1D0,rate=0.01D0,max_iter=10000)
  write(*,"(A,F8.3)")"Intercept:",theta(1)
  do i=2,dims(2)
    write(*,"(A,I2,A,F5.3)")"Parameter",i-1,": ",theta(i)
  end do
end program main
