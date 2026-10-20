#include "hantekdso/models/modelDSO6022.h"

#include <cmath>
#include <cstdlib>
#include <iostream>

int main() {
    ModelDSO6022BE model;
    const auto &specification = *model.spec();

    if ( model.vendorID != 0x04b5 || model.productID != 0x6022 ) {
        std::cerr << "unexpected Hantek 6022BE USB identity\n";
        return EXIT_FAILURE;
    }
    if ( specification.channels != 2 ) {
        std::cerr << "expected two analog channels\n";
        return EXIT_FAILURE;
    }
    if ( std::abs( specification.samplerate.single.max - 30e6 ) > 0.5 ) {
        std::cerr << "unexpected single-channel sample-rate limit\n";
        return EXIT_FAILURE;
    }
    if ( std::abs( specification.samplerate.multi.max - 15e6 ) > 0.5 ) {
        std::cerr << "unexpected dual-channel sample-rate limit\n";
        return EXIT_FAILURE;
    }

    return EXIT_SUCCESS;
}
