## Download file
function download_to() {
    filename=$1
    darwin=$2
    linux=$3
    url='NA'
    unamestr=`uname`

    if [[ "$unamestr" == 'Darwin' ]]; then
        url="$darwin"
    elif [[ "$unamestr" == 'Linux' ]]; then
        url="$linux"
    else
        echo "Unsupported: $unamestr"
        return
    fi

    # echo $url
    curl -o $filename -L $url
}

## Download ARM GCC
function install_gcc() {
    echo "Downloading ARM GCC"
    download_to gcc.tar.bz2 \
        'https://developer.arm.com/-/media/Files/downloads/gnu-rm/6_1-2017q1/gcc-arm-none-eabi-6-2017-q1-update-mac.tar.bz2?product=GNU%20ARM%20Embedded%20Toolchain,64-bit,,Mac%20OS%20X,6-2017-q1-update' \
        'https://developer.arm.com/-/media/Files/downloads/gnu-rm/6_1-2017q1/gcc-arm-none-eabi-6-2017-q1-update-linux.tar.bz2?product=GNU%20ARM%20Embedded%20Toolchain,64-bit,,Linux,6-2017-q1-update'

    mkdir -p ./toolchain/gcc
    tar -xvjf gcc.tar.bz2 -C toolchain/gcc
    rm gcc.tar.bz2
}

## Download NRF tools
function install_nrftools() {
    echo "Downloading NRF Tools"
    download_to nordictools.tar \
        'http://www.nordicsemi.com/eng/nordic/download_resource/53406/12/76457768/99977' \
        'http://www.nordicsemi.com/eng/nordic/download_resource/51388/21/49217292/94917'

    mkdir -p ./toolchain/nrftools
    tar -xvf nordictools.tar -C toolchain/nrftools
    rm nordictools.tar
}

## Download NRF SDK 
function install_sdk() {
    echo "Downloading NRF SDK"
    mkdir -p ./toolchain/sdk
    curl -o nordic_sdk.zip http://developer.nordicsemi.com/nRF5_SDK/nRF5_SDK_v13.x.x/nRF5_SDK_13.0.0_04a0bfd.zip
    unzip -o nordic_sdk.zip 'components/*' 'external/*' 'svd/*' -d ./toolchain/sdk
    rm nordic_sdk.zip

    # Copy makefile.posix from toolchain into SDK
    yes | cp toolchain/Makefile.posix toolchain/sdk/components/toolchain/gcc
}

# source setup.sh

install_gcc
install_nrftools
install_sdk