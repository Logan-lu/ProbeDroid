LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE            := ProbeDroid

LOCAL_C_INCLUDES        +=  ../../common \
                            ../../common/libffi/include \
                            ../../android/art/runtime \

ifeq ($(TARGET_ARCH),arm)
    LOCAL_C_INCLUDES    +=  ../../common/libffi/linux-arm \
                            ./arch/arm
else
    LOCAL_C_INCLUDES    +=  ../../common/libffi/linux-x86 \
                            ./arch/x86
endif

LOCAL_SRC_FILES         :=  ../../common/libffi/src/debug.c \
                            ../../common/libffi/src/prep_cif.c \
                            ../../common/libffi/src/types.c \
                            ../../common/libffi/src/raw_api.c \
                            ../../common/libffi/src/java_raw_api.c \
                            ../../common/stringprintf.cc \
                            ../../common/logcat.cc \
                            gadget_art.cc \
                            gadget_common.cc \
                            boot.cc \
                            signature.cc \
                            java_type.cc \
                            ./bridge/org_probedroid_Instrument.cc \

ifeq ($(TARGET_ARCH),arm)
    LOCAL_SRC_FILES     +=  ../../common/libffi/src/arm/ffi.c \
                            ../../common/libffi/src/arm/sysv.S \
                            ./arch/arm/gadget-asm_arm.s \
                            ./arch/arm/gadget_arm.cc
else
    LOCAL_SRC_FILES     +=  ../../common/libffi/src/x86/ffi.c \
                            ../../common/libffi/src/x86/sysv.S \
                            ./arch/x86/gadget-asm_x86.s \
                            ./arch/x86/gadget_x86.cc
endif

LOCAL_CFLAGS            := -g -fexceptions

LOCAL_SHARED_LIBRARIES  := dl

LOCAL_LDLIBS            +=  -L$(SYSROOT)/usr/lib \
                            -llog \

LOCAL_CPP_EXTENSION     := .cxx .cpp .cc

LOCAL_DISABLE_FATAL_LINKER_WARNINGS := true

include $(BUILD_SHARED_LIBRARY)
