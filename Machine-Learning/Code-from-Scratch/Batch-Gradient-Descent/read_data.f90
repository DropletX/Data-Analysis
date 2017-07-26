! read_data.f90
module read_data
  implicit none
  double precision, dimension(:,:), allocatable :: x
  double precision, dimension(:), allocatable :: y
  integer, dimension(2) :: dims
contains
  subroutine read(file,intercept)
    !=======================================================
    ! Args:
    !   file: file name (character)
    !   intercept: .true. if include an intercept term
    !              .false. if not include an intercept term
    !=======================================================
    implicit none
    character(len=*), intent(in) :: file
    integer :: nrow, nx ! nrow: number of examples; nx: number of features
    logical, intent(in) :: intercept
    integer :: i,j

    open(unit=100,file=file)
    read(100,*)nrow, nx
    allocate(y(nrow))
    dims(1) = nrow
    if(intercept)then
      dims(2) = nx+1
      allocate(x(nrow,nx+1))
      do i=1,nrow
        read(100,*)y(i),(x(i,j),j=2,nx+1)
      end do
      do i=1,nrow
        x(i,1) = 1D0
      end do
    else
      dims(2) = nx
      allocate(x(nrow,nx))
      do i=1,nrow
        read(100,*)y(i),(x(i,j),j=1,nx)
      end do
    end if
    close(100)
  end subroutine read
end module read_data
