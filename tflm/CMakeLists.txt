cmake_minimum_required(VERSION 3.5)
project(TFLM C CXX)

set(TFLM_ROOT "${CMAKE_CURRENT_SOURCE_DIR}")

# Check this maybe be more convenient than a static list? What about using exclusions per target?
# file(GLOB_RECURSE TFLM_SRCS
#   "${TFLM_ROOT}/tensorflow/lite/**/*.cc"
#   "${TFLM_ROOT}/signal/micro/**/*.cc"
#   "${TFLM_ROOT}/signal/src/**/*.cc"
# )

#
# static lib definition
#
add_library(tflm STATIC
  ${TFLM_ROOT}/python/tflite_micro/python_ops_resolver.cc
  ${TFLM_ROOT}/signal/micro/kernels/fft_flexbuffers_generated_data.cc
  ${TFLM_ROOT}/signal/micro/kernels/rfft.cc
  ${TFLM_ROOT}/signal/micro/kernels/window.cc
  ${TFLM_ROOT}/signal/micro/kernels/window_flexbuffers_generated_data.cc
  ${TFLM_ROOT}/signal/src/rfft_float.cc
  ${TFLM_ROOT}/signal/src/rfft_int16.cc
  ${TFLM_ROOT}/signal/src/rfft_int32.cc
  ${TFLM_ROOT}/signal/src/window.cc
  ${TFLM_ROOT}/signal/src/kiss_fft_wrappers/kiss_fft_float.cc
  ${TFLM_ROOT}/signal/src/kiss_fft_wrappers/kiss_fft_int16.cc
  ${TFLM_ROOT}/signal/src/kiss_fft_wrappers/kiss_fft_int32.cc
  ${TFLM_ROOT}/tensorflow/compiler/mlir/lite/core/api/error_reporter.cc
  ${TFLM_ROOT}/tensorflow/compiler/mlir/lite/schema/schema_utils.cc
  ${TFLM_ROOT}/tensorflow/lite/array.cc
  ${TFLM_ROOT}/tensorflow/lite/core/c/common.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/debug_log.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/hexdump.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/fake_micro_context.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/memory_helpers.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/micro_allocation_info.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/test_helpers.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/test_helper_custom_ops.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/recording_micro_allocator.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/micro_time.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/micro_profiler.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/micro_utils.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/flatbuffer_utils.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/mock_micro_graph.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/micro_interpreter.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/micro_interpreter_context.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/micro_interpreter_graph.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/micro_allocator.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/micro_context.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/micro_log.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/micro_op_resolver.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/micro_resource_variable.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/system_setup.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/arena_allocator/non_persistent_arena_buffer_allocator.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/arena_allocator/persistent_arena_buffer_allocator.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/arena_allocator/recording_single_arena_buffer_allocator.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/arena_allocator/single_arena_buffer_allocator.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/tflite_bridge/flatbuffer_conversions_bridge.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/tflite_bridge/micro_error_reporter.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/memory_planner/linear_memory_planner.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/memory_planner/greedy_memory_planner.cc
  ${TFLM_ROOT}/tensorflow/lite/kernels/internal/common.cc
  ${TFLM_ROOT}/tensorflow/lite/kernels/internal/quantization_util.cc
  ${TFLM_ROOT}/tensorflow/lite/kernels/internal/portable_tensor_utils.cc
  ${TFLM_ROOT}/tensorflow/lite/kernels/internal/tensor_ctypes.cc
  ${TFLM_ROOT}/tensorflow/lite/kernels/internal/tensor_utils.cc
  ${TFLM_ROOT}/tensorflow/lite/kernels/internal/reference/comparisons.cc
  ${TFLM_ROOT}/tensorflow/lite/kernels/internal/reference/portable_tensor_utils.cc
  ${TFLM_ROOT}/tensorflow/lite/kernels/kernel_util.cc
  ${TFLM_ROOT}/tensorflow/lite/core/api/flatbuffer_conversions.cc
  ${TFLM_ROOT}/tensorflow/lite/core/api/tensor_utils.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/activations.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/activations_common.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/add.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/add_common.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/add_n.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/arg_min_max.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/assign_variable.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/batch_matmul.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/batch_to_space_nd.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/broadcast_args.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/broadcast_to.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/call_once.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/cast.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/ceil.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/circular_buffer.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/circular_buffer_common.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/comparisons.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/concatenation.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/conv.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/conv_common.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/cumsum.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/decompress.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/decompress_common.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/depth_to_space.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/depthwise_conv.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/depthwise_conv_common.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/dequantize.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/dequantize_common.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/detection_postprocess.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/div.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/elementwise.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/elu.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/embedding_lookup.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/ethosu.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/exp.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/expand_dims.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/fill.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/floor.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/floor_div.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/floor_mod.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/fully_connected.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/fully_connected_common.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/gather.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/gather_nd.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/hard_swish.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/hard_swish_common.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/if.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/kernel_runner.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/kernel_util.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/l2norm.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/l2_pool_2d.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/leaky_relu.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/leaky_relu_common.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/logical.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/logical_common.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/logistic.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/logistic_common.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/lstm_eval.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/lstm_eval_common.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/log_softmax.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/maximum_minimum.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/micro_tensor_utils.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/mirror_pad.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/mul.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/mul_common.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/neg.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/pack.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/pad.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/pad_common.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/pooling.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/pooling_common.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/prelu.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/prelu_common.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/quantize.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/quantize_common.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/read_variable.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/reduce.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/reduce_common.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/reshape.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/reshape_common.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/resize_bilinear.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/resize_nearest_neighbor.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/round.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/select.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/shape.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/slice.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/softmax.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/softmax_common.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/space_to_batch_nd.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/space_to_depth.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/split.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/split_v.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/squared_difference.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/squeeze.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/strided_slice.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/strided_slice_common.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/sub.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/sub_common.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/svdf.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/svdf_common.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/tanh.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/transpose.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/transpose_common.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/transpose_conv.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/unidirectional_sequence_lstm.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/unpack.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/var_handle.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/while.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/zeros_like.cc
  ${TFLM_ROOT}/signal/micro/kernels/delay.cc
  ${TFLM_ROOT}/signal/micro/kernels/energy.cc
  ${TFLM_ROOT}/signal/micro/kernels/fft_auto_scale_kernel.cc
  ${TFLM_ROOT}/signal/micro/kernels/fft_auto_scale_common.cc
  ${TFLM_ROOT}/signal/micro/kernels/filter_bank.cc
  ${TFLM_ROOT}/signal/micro/kernels/filter_bank_log.cc
  ${TFLM_ROOT}/signal/micro/kernels/filter_bank_square_root.cc
  ${TFLM_ROOT}/signal/micro/kernels/filter_bank_square_root_common.cc
  ${TFLM_ROOT}/signal/micro/kernels/filter_bank_spectral_subtraction.cc
  ${TFLM_ROOT}/signal/micro/kernels/framer.cc
  ${TFLM_ROOT}/signal/micro/kernels/irfft.cc
  ${TFLM_ROOT}/signal/micro/kernels/rfft.cc
  ${TFLM_ROOT}/signal/micro/kernels/stacker.cc
  ${TFLM_ROOT}/signal/micro/kernels/overlap_add.cc
  ${TFLM_ROOT}/signal/micro/kernels/pcan.cc
  ${TFLM_ROOT}/signal/micro/kernels/window.cc
  ${TFLM_ROOT}/signal/src/circular_buffer.cc
  ${TFLM_ROOT}/signal/src/energy.cc
  ${TFLM_ROOT}/signal/src/fft_auto_scale.cc
  ${TFLM_ROOT}/signal/src/filter_bank.cc
  ${TFLM_ROOT}/signal/src/filter_bank_log.cc
  ${TFLM_ROOT}/signal/src/filter_bank_square_root.cc
  ${TFLM_ROOT}/signal/src/filter_bank_spectral_subtraction.cc
  ${TFLM_ROOT}/signal/src/irfft_float.cc
  ${TFLM_ROOT}/signal/src/irfft_int16.cc
  ${TFLM_ROOT}/signal/src/irfft_int32.cc
  ${TFLM_ROOT}/signal/src/log.cc
  ${TFLM_ROOT}/signal/src/max_abs.cc
  ${TFLM_ROOT}/signal/src/msb_32.cc
  ${TFLM_ROOT}/signal/src/msb_64.cc
  ${TFLM_ROOT}/signal/src/overlap_add.cc
  ${TFLM_ROOT}/signal/src/pcan_argc_fixed.cc
  ${TFLM_ROOT}/signal/src/square_root_32.cc
  ${TFLM_ROOT}/signal/src/square_root_64.cc
  ${TFLM_ROOT}/signal/src/window.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/batch_matmul_common.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/transpose.cc
  ${TFLM_ROOT}/tensorflow/lite/micro/kernels/pad.cc
)

# header files
target_include_directories(tflm PUBLIC
  "${TFLM_ROOT}"
  "${TFLM_ROOT}/../flatbuffers/include"
  "${TFLM_ROOT}/../gemmlowp"
  "${TFLM_ROOT}/../ruy"
  "${TFLM_ROOT}/../kissfft"
)

# static lib installation
install(TARGETS tflm ARCHIVE DESTINATION ../lib)

# header files installation
install(
  DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/tensorflow/lite/"
  DESTINATION "../include/tensorflow/lite"
  FILES_MATCHING
    PATTERN "*.h"
)

install(
  DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/tensorflow/compiler/"
  DESTINATION "../include/tensorflow/compiler"
  FILES_MATCHING
    PATTERN "*.h"
)

install(
  DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/signal/"
  DESTINATION "../include/signal"
  FILES_MATCHING
    PATTERN "*.h"
)

# Make it with installation of flatbuffers & gemmlowp & flatbuffers!!!

install(
  DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/../flatbuffers/include/flatbuffers/"
  DESTINATION "../include/flatbuffers"
  FILES_MATCHING
    PATTERN "*.h"
)

install(
  DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/../gemmlowp/fixedpoint/"
  DESTINATION "../include/fixedpoint"
  FILES_MATCHING
    PATTERN "*.h"
)

install(
  DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/../gemmlowp/internal/"
  DESTINATION "../include/internal"
  FILES_MATCHING
    PATTERN "*.h"
)
