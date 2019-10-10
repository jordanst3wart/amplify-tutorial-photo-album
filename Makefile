SHELL = /bin/bash
.SHELLFLAGS = -c

MY_UNIQUE_CLOUDFORMATION_TEMPLATES_BUCKET_NAME=photo-album-saml-zb
MY_UNIQUE_CLOUDFORMATION_TEMPLATES_STACK_NAME=PhotoAlbumsProcessorStackZB
MY_AWS_USERFILES_S3_BUCKET_ARN=arn:aws:s3:::photo-albums8fe97d14fc0f4d5b9466f1e11a4ef69c-dev
MY_DYNAMODB_PHOTOS_TABLE_ARN=arn:aws:dynamodb:us-east-1:293499315857:table/Photo-2brgjm5ugvfarp56tctdmun7d4-dev
REGION=us-east-1

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

.ONESHELL:
step5:
	amplify add storage
	amplify push
	npm install --save uuid

.ONESHELL:
step6:

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

.PHONY: step1 step2 step3 step4 step5 step6 step7 makebucket createfunction cleanup
