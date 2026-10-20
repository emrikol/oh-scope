// SPDX-License-Identifier: GPL-3.0-or-later

#ifndef OH_SCOPE_CORE_H
#define OH_SCOPE_CORE_H

#include <stddef.h>
#include <stdint.h>

#if defined(_WIN32)
#if defined(OH_SCOPE_CORE_BUILD)
#define OH_SCOPE_CORE_API __declspec(dllexport)
#else
#define OH_SCOPE_CORE_API __declspec(dllimport)
#endif
#else
#define OH_SCOPE_CORE_API __attribute__((visibility("default")))
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define OH_SCOPE_CORE_API_VERSION 1u
#define OH_SCOPE_MODEL_NAME_CAPACITY 32u
#define OH_SCOPE_FIRMWARE_TOKEN_CAPACITY 32u

typedef enum oh_scope_status {
    OH_SCOPE_STATUS_OK = 0,
    OH_SCOPE_STATUS_INVALID_ARGUMENT = 1,
    OH_SCOPE_STATUS_OUT_OF_RANGE = 2,
    OH_SCOPE_STATUS_NOT_FOUND = 3
} oh_scope_status;

typedef struct oh_scope_model_info {
    uint32_t struct_size;
    uint16_t runtime_vendor_id;
    uint16_t runtime_product_id;
    uint16_t bootloader_vendor_id;
    uint16_t bootloader_product_id;
    uint32_t channel_count;
    double maximum_single_channel_sample_rate_hz;
    double maximum_multi_channel_sample_rate_hz;
    char model_name[OH_SCOPE_MODEL_NAME_CAPACITY];
    char firmware_token[OH_SCOPE_FIRMWARE_TOKEN_CAPACITY];
} oh_scope_model_info;

OH_SCOPE_CORE_API uint32_t oh_scope_core_api_version(void);
OH_SCOPE_CORE_API const char *oh_scope_core_upstream_revision(void);
OH_SCOPE_CORE_API size_t oh_scope_core_model_count(void);
OH_SCOPE_CORE_API oh_scope_status oh_scope_core_model_at(size_t index, oh_scope_model_info *model);
OH_SCOPE_CORE_API oh_scope_status oh_scope_core_find_model(
    uint16_t runtime_vendor_id,
    uint16_t runtime_product_id,
    oh_scope_model_info *model
);

#ifdef __cplusplus
}
#endif

#endif
