SHELL = /bin/bash
.SHELLFLAGS = -c

.ONESHELL:
step1:
	npx create-react-app photo-albums
	cd photo-albums
	npm install --save semantic-ui-react
	


.ONESHELL:
step2:
	amplify init

.ONESHELL:
step3:
	amplify add auth
	amplify push
	npm install --save aws-amplify aws-amplify-react
	
.ONESHELL:
step4:


.PHONY: step1 step2 step3 step4 step5
