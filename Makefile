help:

	@echo "Usage: make <build|deploy>"

build:

	rsync -rav --delete --delete-excluded --exclude ".git*" ../themes/ themes/
	hugo

deploy:

	pushd ../themes/LinuxLefty-Theme
	git commit -a -m "Auto-commit before deploying"
	git push origin
	popd

	git commit -a -m "Auto-commit before deploying"
	git push origin
