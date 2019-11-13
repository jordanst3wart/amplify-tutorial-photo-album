## Step 0: Getting Started

Check your access to AWS
```
$ aws s3 ls
```
Check version of Node (>8.x) and NPM (>5.x)
```
$ node -v
v10.16.0
$ npm -v
6.9.0
$ npm install -g @aws-amplify/cli

```

## Step 1: Create React App

```
$ npx create-react-app photo-albums
$ cp Makefile photo-albums/Makefile
$ cd photo-albums
$ npm install --save semantic-ui-react
$ npm start
```

Check http://localhost:3000/

Modify src/App.js and see changes

## Step 2: Initiate Amplify

```
$ amplify init

```


## Step 3: Add Auth

```

$ amplify add auth
$ amplify push
$ npm install --save aws-amplify aws-amplify-react
$ cp ../03/App.js src/App.js
$ npm start
```


## Step 4: Create GraphQL

```
$ amplify add api
```
Copy over schema.graphql
```
$ amplify push
```

## Step 5: Add GraphQL to App

```
$ npm install --save react-router-dom
$ cp ../05/App.js src/App.js
$ npm start
```

## Step 6: Add Storage

```
$ amplify add storage
$ amplify push
$ npm install --save uuid
```
- Copy over App.js

```
$ npm start
```
## Step 7: Add Function

```
$ sam init --runtime nodejs8.10 --name photo_processor
```
- copy over src/app.js content and src/package.json template.yaml
- modify and check the constants in the Makefile 
```
$ cd photo_processor/src
$ docker run -v "$PWD":/var/task lambci/lambda:build-nodejs8.10 npm install
$ make makebucket
$ make createfunction
```
- Hop over to the console in Lambda add Trigger
- Copy over App.js

## Step 8: Host website

```
$ amplify add hosting
$ amplify publish
```

## Clean up

```
$ amplify delete
```
- Delete lambda stack
- Delete all s3 buckets
