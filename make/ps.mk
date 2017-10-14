#---------------------------------------------------------------------------------------
#  parameter server configuration script
#
#  include ps.mk after the variables are set
#
#----------------------------------------------------------------------------------------

ifeq ($(USE_KEY32), 1)
ADD_CFLAGS += -DUSE_KEY32=1
endif

PS_LDFLAGS_SO = -L$(DEPS_PATH)/lib -lprotobuf-lite -lzmq -lfmq -lrdmacm -libverbs
PS_EXT_LIB_A = $(addprefix $(DEPS_PATH)/lib/, libprotobuf-lite.a libzmq.a libfmq.a)
PS_LDFLAGS_A = $(PS_EXT_LIB_A) -lrdmacm -libverbs

