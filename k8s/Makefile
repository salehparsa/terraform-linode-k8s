ENV  := $(shell echo $${ENV:-dev} | awk '{print tolower($$0)}')

ifneq "$(ENV)" "prod"
NAMESPACE       := 
else
NAMESPACE       := 
endif

ifndef DEP
$(error You need to choose the Deployment by export DEP)
else
DEP      := $(shell echo $${DEP} | awk '{print ($$0)}')
TARGET_DIRS  := $(shell echo $(DEP); [ ! -d $(DEP)/$(ENV) ] || echo $(DEP)/$(ENV))
TARGET_FILES := $(shell find $(TARGET_DIRS) -maxdepth 1 -type f)
endif

ifneq "$(DEP)" "app"
NAMESPACE 	:= $(shell echo "monitoring")
else
NAMESPACE   := $(shell echo "app")
endif


$(info Using Environment: $(ENV))
$(info Using Deployment:  $(DEP))
$(info Using Namespace:   $(NAMESPACE))
$(info Using files:       $(TARGET_FILES))

all:
	@echo "Usage: [ENV=dev|prod] make <get|describe|logs|apply>"

get: check-env
	kubectl  --namespace $(NAMESPACE) get pod

describe: check-env
	kubectl --namespace $(NAMESPACE) describe deployment $(DEP)

logs: check-env
	kubectl --namespace $(NAMESPACE) logs -lapp=$(DEP)

apply dry-run template: check-env
	@ \
	DRY_RUN_FLAG=$$( [ "$@" = "dry-run" ]  && echo -n '--server-dry-run' || true); \
	TEMPLATE_ONLY=$$([ "$@" = "template" ] && echo -n 'y'                || true); \
	apply () { [ -n "$$TEMPLATE_ONLY" ] && cat || kubectl --namespace $(NAMESPACE) apply $$DRY_RUN_FLAG -f -; }; \
	for FILENAME in $(TARGET_FILES); do \
		echo -e "\e[1;44m""### Applying file: $$FILENAME""\e[0m"; \
		envsubst '$(TEMPLATE_VARS)' <$$FILENAME | apply; \
	done

.PHONY: apply check-env
SHELL := /bin/bash