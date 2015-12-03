set -e

TARGET=arm-eabi-freebsd11.0

PREFIX=~/b/toolchains
SYSROOT=~/src/rpi-freebsd-sysroot
BUILDROOT=~/b/toolchains-build

function new_bdir()
{
	bdir=$BUILDROOT/$1
	rm -rf $bdir
	mkdir -p $bdir
	cd $bdir
}

function configure_binutils()
{
	new_bdir binutils
#	~/srcr/freebsd/contrib/binutils/configure \
	~/srcr/binutils-2.17/configure \
	--prefix=$PREFIX \
	--enable-libssp --enable-gold --enable-ld --target=$TARGET \
	--with-sysroot=$SYSROOT

	make && make install
}

function configure_gmp()
{
	new_bdir gmp
	~/srcr/gmp-5.1.3/configure --prefix=$PREFIX/gcc-deps --disable-shared
	make install
}

function configure_mpfr()
{
	new_bdir mpfr
	~/srcr/mpfr-3.1.2/configure --prefix=$PREFIX/gcc-deps --disable-shared --with-gmp=$PREFIX/gcc-deps
	make install
}

function configure_mpc()
{
	new_bdir mpc
	~/srcr/mpc-1.0/configure --disable-shared --prefix=$PREFIX/gcc-deps \
	--with-gmp=$PREFIX/gcc-deps --with-mpfr=$PREFIX/gcc-deps
	make install
}

function configure_gcc()
{
	new_bdir gcc

	CFLAGS=-fbracket-depth=512 ~/srcr/gcc-4.9.2/configure --target=$TARGET --prefix=$PREFIX \
	--enable-languages=c --disable-nls --disable-shared --with-dwarf2 \
	--with-mpfr=$PREFIX/gcc-deps \
	--with-gmp=$PREFIX/gcc-deps \
	--with-mpc=$PREFIX/gcc-deps

	make
}

configure_binutils
#configure_gmp
#configure_mpfr
#configure_mpc
#configure_gcc
