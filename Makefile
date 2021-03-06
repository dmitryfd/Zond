CC = processing-java
PWD = "$(shell pwd)"
SRC_DIR = $(PWD)/src
BIN_DIR = $(PWD)/bin
OBJ_DIR = $(PWD)/obj
EXEC_NAME = Zond
DUMMY_DIR = $(PWD)/$(EXEC_NAME)

all: run

# If folder is named src, Processing demands main file to be src.pde. Let's fix that the dirty way!
prepare:
	@echo "> Creating Processing-friendly file structure..."
	@cp -r $(SRC_DIR) $(EXEC_NAME)
	@cp -r data $(EXEC_NAME)/data
	@cp -r audio $(EXEC_NAME)/data/audio

build: clean prepare
	@echo "> Building..."
	@echo ""
	@processing-java --sketch="$(DUMMY_DIR)" --build --output="$(OBJ_DIR)"

run: clean prepare
	@echo "> Building..."
	@echo ""
	@echo "> Application will start shortly..."
	@echo "? Press Ctrl+C to terminate the execution."
	@echo ""
	@processing-java --sketch="$(DUMMY_DIR)" --run --output="$(BIN_DIR)"

export: clean prepare
	@echo "> Exporting..."
	@echo ""
	@processing-java --sketch="$(DUMMY_DIR)" --export --output="$(BIN_DIR)"

clean:
	@echo "> Cleaning..."
	@rm -rf "$(OBJ_DIR)"
	@rm -rf "$(BIN_DIR)"
	@rm -rf "$(DUMMY_DIR)"