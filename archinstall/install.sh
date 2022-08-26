#!/bin/bash

exec archinstall \
	--config ./user_configuration.json \
	--creds user_credentials.json --disk-layout \
	./user_disk_layout.json
