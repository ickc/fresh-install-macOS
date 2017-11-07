#! /usr/bin/env bash

# install mpibash

# optionally override these with env. var.
BINDIR="${BINDIR-"$HOME/.mpibash"}"
P=${P-$(getconf _NPROCESSORS_ONLN)}
BASHVERSION=${BASHVERSION-4.4.12}
MPIBASHVERSION=${MPIBASHVERSION-master}

# choose compiler
if [[ -n $NERSC_HOST ]]; then
	module swap PrgEnv-intel PrgEnv-cray || exit 1
	# module swap PrgEnv-intel PrgEnv-gnu || exit 1
fi

mkdir -p "$BINDIR" &&

cd "$BINDIR" &&
wget -qO- https://ftp.gnu.org/gnu/bash/bash-$BASHVERSION.tar.gz | tar -xzf - &&
cd bash-$BASHVERSION &&
./configure &&
make -j $P || exit 1

cd "$BINDIR" &&
if [[ $MPIBASHVERSION != master ]]; then
	wget -qO- https://github.com/lanl/MPI-Bash/releases/download/v$MPIBASHVERSION/mpibash-$MPIBASHVERSION.tar.gz | tar -xzf - || exit 1
	mpibashDir=mpibash-$MPIBASHVERSION
else
	git clone https://github.com/lanl/MPI-Bash.git || exit 1
	mpibashDir=MPI-Bash
fi

cd $mpibashDir &&
if [[ $MPIBASHVERSION == master ]]; then
	autoreconf -fvi || exit 1
fi
./configure --with-bashdir="$BINDIR/bash-$BASHVERSION" --prefix="$BINDIR/$mpibashDir" CC=cc &&
make -j $P &&
make install -j $P &&

echo '# export this PATH'
echo export PATH="$BINDIR/bash-$BASHVERSION:$BINDIR/$mpibashDir/bin:\$PATH"