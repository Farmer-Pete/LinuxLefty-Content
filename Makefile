help:

	@echo "Usage: make <build|deploy|preview>"


build: _sync

	hugo

deploy: build

	cd ../themes/LinuxLefty-Theme && git add . && git commit -m "Auto-commit before deploying"; git push origin

	git add .
	git commit -m "Auto-commit before deploying" || echo
	git push origin

preview: _sync

	hugo serve -D

_sync:

	rsync -rav --delete --delete-excluded --exclude ".git*" ../themes/ themes/
