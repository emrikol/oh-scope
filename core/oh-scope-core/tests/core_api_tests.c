// SPDX-License-Identifier: GPL-3.0-or-later

#include "ohscope/core.h"

#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define REQUIRE(condition, message) \
    do { \
        if ( !( condition ) ) { \
            fprintf( stderr, "%s\n", message ); \
            return EXIT_FAILURE; \
        } \
    } while ( 0 )

int main( void ) {
    oh_scope_model_info model;

    REQUIRE( oh_scope_core_api_version() == OH_SCOPE_CORE_API_VERSION, "unexpected API version" );
    REQUIRE( strlen( oh_scope_core_upstream_revision() ) == 40, "expected a full upstream Git revision" );
    REQUIRE( oh_scope_core_model_count() == 2, "expected the 6022BE and 6022BL models" );
    REQUIRE(
        oh_scope_core_model_at( 0, NULL ) == OH_SCOPE_STATUS_INVALID_ARGUMENT,
        "a null output should be rejected"
    );
    REQUIRE(
        oh_scope_core_model_at( oh_scope_core_model_count(), &model ) == OH_SCOPE_STATUS_OUT_OF_RANGE,
        "an invalid model index should be rejected"
    );
    REQUIRE(
        oh_scope_core_find_model( 0xffff, 0xffff, &model ) == OH_SCOPE_STATUS_NOT_FOUND,
        "an unknown USB identity should not match"
    );

    REQUIRE(
        oh_scope_core_find_model( 0x04b5, 0x6022, &model ) == OH_SCOPE_STATUS_OK,
        "the Hantek 6022BE should be discoverable"
    );
    REQUIRE( strcmp( model.model_name, "DSO-6022BE" ) == 0, "unexpected model name" );
    REQUIRE( model.struct_size == sizeof( model ), "unexpected model structure size" );
    REQUIRE( model.channel_count == 2, "expected two channels" );
    REQUIRE(
        fabs( model.maximum_single_channel_sample_rate_hz - 30e6 ) < 0.5,
        "unexpected single-channel sample-rate limit"
    );
    REQUIRE(
        fabs( model.maximum_multi_channel_sample_rate_hz - 15e6 ) < 0.5,
        "unexpected multi-channel sample-rate limit"
    );

    REQUIRE(
        oh_scope_core_find_model( 0x04b5, 0x602a, &model ) == OH_SCOPE_STATUS_OK,
        "the Hantek 6022BL should be discoverable"
    );
    REQUIRE( strcmp( model.model_name, "DSO-6022BL" ) == 0, "unexpected model name" );

    return EXIT_SUCCESS;
}
