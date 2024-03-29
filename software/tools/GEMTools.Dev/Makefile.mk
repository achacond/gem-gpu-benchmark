#==================================================================================================
# PROJECT: GEM-Tools library
# FILE: Makefile.mk
# DATE: 02/10/2012
# AUTHOR(S): Santiago Marco-Sola <santiagomsola@gmail.com>
# DESCRIPTION: Makefile definitions' file
#==================================================================================================

# Sys
PLATFORM=$(shell uname)

# Utilities
CC=gcc
AR=ar

# Folders
FOLDER_BIN=$(ROOT_PATH)/bin
FOLDER_BUILD=$(ROOT_PATH)/build
FOLDER_DATASETS=$(ROOT_PATH)/datasets
FOLDER_INCLUDE=$(ROOT_PATH)/include
FOLDER_LIB=$(ROOT_PATH)/lib
FOLDER_RESOURCES=$(ROOT_PATH)/resources

ifeq ($(PLATFORM),Darwin)
FOLDER_RESOURCES_LIB=$(ROOT_PATH)/resources/lib/mac
else
FOLDER_RESOURCES_LIB=$(ROOT_PATH)/resources/lib
endif

FOLDER_RESOURCES_INCLUDE=$(ROOT_PATH)/resources/include
FOLDER_SOURCE=$(ROOT_PATH)/src
FOLDER_TEST=$(ROOT_PATH)/test
FOLDER_TOOLS=$(ROOT_PATH)/tools

# Configure flags
HAVE_ZLIB = 1
HAVE_BZLIB = 1
HAVE_OPENMP = 1

ifeq ($(HAVE_OPENMP),1)
DEF_OPENMP=-DHAVE_OPENMP
LIBS_OPENMP+=-fopenmp
endif
ifeq ($(HAVE_ZLIB),1)
DEF_ZLIB=-DHAVE_ZLIB
LIBS_ZLIB+=-lz
endif
ifeq ($(HAVE_BZLIB),1)
DEF_BZLIB=-DHAVE_BZLIB
LIBS_BZLIB+=-lbz2
endif

# Flags
ARCH_FLAGS=-D__LINUX__
GENERAL_FLAGS=-fPIC -Wall

OPTIMIZTION_FLAGS=-O4 # -fomit-frame-pointer -ftree-vectorize
ARCH_FLAGS_OPTIMIZTION_FLAGS=-msse3 -mssse3 -msse4.2

INCLUDE_FLAGS=-I$(FOLDER_INCLUDE) -I$(FOLDER_RESOURCES_INCLUDE)
LIB_PATH_FLAGS=-L$(FOLDER_LIB) -L$(FOLDER_RESOURCES_LIB)

SUPPRESS_CHECKS=-DNDEBUG -DGT_NO_CONSISTENCY_CHECKS
DEBUG_FLAGS=-g -ggdb3 -rdynamic -DGT_DEBUG


