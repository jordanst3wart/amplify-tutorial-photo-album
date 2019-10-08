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
$ npx create-react-app 
$ photo-albums
$ cd photo-albums
$ npm install --save semantic-ui-react
```
- Copy Makefile to /photo-albums

In new terminal
```
$ cd photo-albums
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
$ make step3

```
- copy over src/App.js
```
$ npm start
```


## Step 4: Add GraphQL

```
amplify add api
```
Copy over schema.graphql
```
$ amplify push
```

