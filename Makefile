help:

	@echo "Usage: make <build|deploy>"

build:

	rsync -rav --delete --delete-excluded --exclude ".git*" ../themes/ themes/
	hugo

deploy:

	cd ../themes/LinuxLefty-Theme && git add . && git commit -m "Auto-commit before deploying"; git push origin

	git add .
	git commit -m "Auto-commit before deploying"
	git push origin || echo
