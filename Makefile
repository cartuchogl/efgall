FLEX_SDK = ~/flex_sdk_3
MXML = $(FLEX_SDK)/bin/mxmlc
OUTPUT_PATH = .
DO = $(MXML) $< -output $@
TARGET_FILENAME = efgall.swf

$(OUTPUT_PATH)/$(TARGET_FILENAME) : Main.as
	$(DO)

clean :
	rm $(OUTPUT_PATH)/$(TARGET_FILENAME)
