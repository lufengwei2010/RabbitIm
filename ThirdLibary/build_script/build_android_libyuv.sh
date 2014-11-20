#参数:
#    $1:源码的位置 

#运行本脚本前,先运行 build_android_envsetup.sh 进行环境变量设置,需要先设置下面变量:
#   PREFIX=`pwd`/../android  #修改这里为安装前缀
if [ -z "${PREFIX}" ]; then
    echo "source build_android_envsetup.sh"
    source build_android_envsetup.sh
fi

if [ -n "$1" ]; then
    SOURCE_CODE=$1
else
    SOURCE_CODE=${PREFIX}/../src/libyuv
fi

#下载源码:
if [ ! -d ${SOURCE_CODE} ]; then
    echo "git clone http://git.chromium.org/external/libyuv.git"
    git clone http://git.chromium.org/external/libyuv.git  ${SOURCE_CODE}
fi

CUR_DIR=`pwd`
cd ${SOURCE_CODE}

echo ""
echo "SOURCE_CODE:$SOURCE_CODE"
echo "CUR_DIR:$CUR_DIR"
echo "PREFIX:$PREFIX"
echo ""

mkdir -p build_android
cd build_android
rm -fr *

#需要设置 CMAKE_MAKE_PROGRAM 为 make 程序路径。
case `uname -s` in
    MINGW* | CYGWIN*)
        GENERATORS="MinGW Makefiles"
        ;;
    Linux* | Unix* | *)
        GENERATORS="Unix Makefiles" 
        ;;
esac
echo "configure ..."
cmake .. \
    -G"${GENERATORS}"\
    -DCMAKE_MAKE_PROGRAM="$ANDROID_NDK/prebuilt/${HOST}/bin/make" \
    -DCMAKE_INSTALL_PREFIX="$PREFIX" \
    -DCMAKE_TOOLCHAIN_FILE="/d/source/rabbitim/platforms/android/android.toolchain.cmake"

echo "build..."
cmake --build . --target install --config Release

cd $CUR_DIR