export PERL_LOCAL_LIB_ROOT=$(pwd)/../perl-libs;
export PERL_MB_OPT="--install_base ${PERL_LOCAL_LIB_ROOT}";
export PERL_MM_OPT="INSTALL_BASE=${PERL_LOCAL_LIB_ROOT}";
export PERL5LIB="${PERL_LOCAL_LIB_ROOT}/lib/perl5/x86_64-linux-thread-multi:${PERL_LOCAL_LIB_ROOT}/lib/perl5";
export PATH="${PERL_LOCAL_LIB_ROOT}/bin:/usr/sbin:/sbin:$PATH";
export PS1="(catalyst) ${PS1}"

