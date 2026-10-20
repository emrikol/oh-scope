// SPDX-License-Identifier: GPL-3.0-or-later

#include "ohscope/core.h"

#include "hantekdso/dsomodel.h"
#include "hantekdso/modelregistry.h"

#include <algorithm>
#include <cstdio>
#include <string>
#include <vector>

static_assert( OH_SCOPE_CORE_API_VERSION == OH_SCOPE_LOCKED_COMPATIBILITY_API );

namespace {

bool isOhScopeModel( const DSOModel *model ) {
    return model != nullptr && ( model->name == "DSO-6022BE" || model->name == "DSO-6022BL" );
}

std::vector< const DSOModel * > supportedModels() {
    std::vector< const DSOModel * > models;

    for ( const DSOModel *model : ModelRegistry::get()->models() ) {
        if ( isOhScopeModel( model ) ) {
            models.push_back( model );
        }
    }

    std::sort( models.begin(), models.end(), []( const DSOModel *left, const DSOModel *right ) {
        return left->name < right->name;
    } );
    return models;
}

void copyText( char *destination, size_t capacity, const std::string &source ) {
    if ( capacity == 0 ) {
        return;
    }
    std::snprintf( destination, capacity, "%s", source.c_str() );
}

oh_scope_status copyModel( const DSOModel *source, oh_scope_model_info *destination ) {
    if ( source == nullptr || destination == nullptr ) {
        return OH_SCOPE_STATUS_INVALID_ARGUMENT;
    }

    const auto *specification = source->spec();
    *destination = {};
    destination->struct_size = sizeof( oh_scope_model_info );
    destination->runtime_vendor_id = static_cast< uint16_t >( source->vendorID );
    destination->runtime_product_id = static_cast< uint16_t >( source->productID );
    destination->bootloader_vendor_id = static_cast< uint16_t >( source->vendorIDnoFirmware );
    destination->bootloader_product_id = static_cast< uint16_t >( source->productIDnoFirmware );
    destination->channel_count = static_cast< uint32_t >( specification->channels );
    destination->maximum_single_channel_sample_rate_hz = specification->samplerate.single.max;
    destination->maximum_multi_channel_sample_rate_hz = specification->samplerate.multi.max;
    copyText( destination->model_name, sizeof( destination->model_name ), source->name.toStdString() );
    copyText( destination->firmware_token, sizeof( destination->firmware_token ), source->firmwareToken.toStdString() );
    return OH_SCOPE_STATUS_OK;
}

} // namespace

uint32_t oh_scope_core_api_version( void ) { return OH_SCOPE_CORE_API_VERSION; }

const char *oh_scope_core_upstream_revision( void ) { return OH_SCOPE_OPENHANTEK_REVISION; }

size_t oh_scope_core_model_count( void ) { return supportedModels().size(); }

oh_scope_status oh_scope_core_model_at( size_t index, oh_scope_model_info *model ) {
    if ( model == nullptr ) {
        return OH_SCOPE_STATUS_INVALID_ARGUMENT;
    }

    const auto models = supportedModels();
    if ( index >= models.size() ) {
        return OH_SCOPE_STATUS_OUT_OF_RANGE;
    }
    return copyModel( models[ index ], model );
}

oh_scope_status oh_scope_core_find_model(
    uint16_t runtime_vendor_id,
    uint16_t runtime_product_id,
    oh_scope_model_info *model
) {
    if ( model == nullptr ) {
        return OH_SCOPE_STATUS_INVALID_ARGUMENT;
    }

    const auto models = supportedModels();
    const auto match = std::find_if( models.begin(), models.end(), [=]( const DSOModel *candidate ) {
        return candidate->vendorID == runtime_vendor_id && candidate->productID == runtime_product_id;
    } );
    if ( match == models.end() ) {
        return OH_SCOPE_STATUS_NOT_FOUND;
    }
    return copyModel( *match, model );
}
