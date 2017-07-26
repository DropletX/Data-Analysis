! glm.f90
module GLM
contains
  function batch_gradient_descent(g,x,y,tol,rate,max_iter)
    !====================================
    ! Args:
    !   g: link function (double precision function)
    !   x: input variables (double precision rank 2 array)
    !   y: target variables  (double precision rank 1 array)
    !   tol: tolerance (double precision number)
    !   rate: learning rate (double precision number)
    !   max_iter: maximum number of iterations to perform (integer)
    ! Returns:
    !   theta: parameters (double precision rank 1 array)
    !====================================
    implicit none
    interface
      double precision function g(x)
        implicit none
        double precision, intent(in) :: x
      end function
    end interface
    double precision, dimension(:,:), allocatable, intent(in) :: x
    double precision, dimension(:), allocatable, intent(in) :: y
    double precision :: err, tol, rate
    integer :: iter_count = 0
    integer, optional :: max_iter
    double precision, dimension(:), allocatable :: theta, old_theta
    integer, dimension(2) :: dims
    integer :: i,j
    double precision, dimension(:), allocatable :: batch_gradient_descent

    if(.not.present(max_iter))then
      max_iter = 10000
    end if
    dims = shape(x)
    allocate(theta(dims(2)))
    ! initialize theta randomly
    do i=1,dims(2)
      theta(i) = rand()
    end do
    err = cost(identity,theta,x,y)
    do while(err>tol)
      do i=1,dims(1) ! loop through x examples
        old_theta = theta
        do j=1,dims(2) ! loop through theta
          theta(j) = theta(j)+rate*(y(i)-g(dot_product(old_theta,x(i,:))))*x(i,j)
        end do
      end do
      err = cost(identity,theta,x,y)
      iter_count = iter_count + 1
      if(iter_count==max_iter)then
        print *,"Reached maximum number of iterations. Cannot converage."
        exit
      end if
    end do
    print *,"Error:",err
    print *,"Number of iterations:",iter_count
    batch_gradient_descent = theta
  end function batch_gradient_descent
  ! Cost function
  double precision function cost(g,theta,x,y)
    !=======================================================
    ! Args:
    !   g: link function (double precision function)
    !   theta: parameters (double precision rank 1 array)
    !   x: input variables (double precision rank 2 array)
    !   y: target variables (double precision rank 1 array)
    ! Returns:
    !   cost: cost (double precision number)
    !=======================================================
    implicit none
    interface
      double precision function g(x)
        implicit none
        double precision, intent(in) :: x
      end function
    end interface
    double precision, dimension(:), allocatable :: y, theta
    double precision, dimension(:,:), allocatable :: x
    integer, dimension(2) :: dims
    integer :: i, j
    dims = shape(x)
    cost = 0D0
    do i=1,dims(1)
      cost = cost+(g(dot_product(theta,x(i,:)))-y(i))*(g(dot_product(theta,x(i,:)))-y(i))
    end do
    cost = cost*0.5
  end function cost
  ! Identity link function
  double precision function identity(x)
    !===================================================
    ! Args:
    !   x: double precision number
    ! Returns:
    !   x : double precision number
    !===================================================
    implicit none
    double precision, intent(in) :: x
    identity = x
  end function identity
end module GLM
