SHELL = /bin/bash
.SHELLFLAGS = -c

# MUST CHANGE FOLLOWING >>
MY_UNIQUE_CLOUDFORMATION_TEMPLATES_BUCKET_NAME=photo-album-sam-xx
MY_UNIQUE_CLOUDFORMATION_TEMPLATES_STACK_NAME=PhotoAlbumsProcessorStackXX
MY_AWS_USERFILES_S3_BUCKET_ARN=arn:aws:s3:::XX
MY_DYNAMODB_PHOTOS_TABLE_ARN=arn:aws:dynamodb:us-east-1:XXXX
REGION=us-east-1

help:   ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/:[^#]*##/ -- /'

.ONESHELL:
step1:
	npm install --save semantic-ui-react
	npm start
	cp ../01/index.html public/index.html
	
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
	amplify add api
	amplify push

.ONESHELL:
step5:
	npm install --save react-router-dom
	cp ../05/App.js src/App.js
	npm start

.ONESHELL:
step6:
	amplify add storage
	amplify push
	npm install --save uuid
	cp ../06/App.js src/App.js

.ONESHELL:
step7:
	sam init --runtime nodejs8.10 --name photo_processor
	cp -a ../07/photo_processor/src photo_processor/src
	cp ../07/photo_processor/template.yaml photo_processor/template.yaml
	cp ../06/App.js src/App.js
	cp ../07/src/App.js src/App.js

.ONESHELL:
makebucket:
	aws s3 mb s3://${MY_UNIQUE_CLOUDFORMATION_TEMPLATES_BUCKET_NAME} --region ${REGION}

.ONESHELL:
createfunction:
	docker run -v ${PWD}/photo_processor/src:/var/task lambci/lambda:build-nodejs8.10 npm install
	
	sam package \
	--template-file photo_processor/template.yaml \
	--output-template-file photo_processor/packaged.yml \
	--s3-bucket ${MY_UNIQUE_CLOUDFORMATION_TEMPLATES_BUCKET_NAME}

	sam deploy \
	--template-file photo_processor/packaged.yml \
	--stack-name ${MY_UNIQUE_CLOUDFORMATION_TEMPLATES_STACK_NAME} \
	--capabilities CAPABILITY_IAM \
	--region ${REGION} \
	--parameter-overrides \
	S3UserfilesBucketArn=${MY_AWS_USERFILES_S3_BUCKET_ARN} \
	DynamoDBPhotosTableArn=${MY_DYNAMODB_PHOTOS_TABLE_ARN}

.ONESHELL:
step8:
	amplify addd hosting
	amplify publish

.ONESHELL:
cleanup:
	amplify delete

check-AWS_PROFILE:
	@/bin/bash -c "echo Running with AWS_PROFILE=$${AWS_PROFILE:?Need to set AWS_PROFILE}"

shell-docker: check-AWS_PROFILE ## run a shell within the build docker
	docker run \
 		--rm \
		-e AWS_PROFILE=$(AWS_PROFILE) \
                -it \
                -v ~/.aws:/root/.aws \
                -v $(CURDIR):/app \
                -w /app \
                node:10 \
                /bin/sh


.PHONY: step1 step2 step3 step4 step5 step6 step7 step8 makebucket createfunction cleanup
