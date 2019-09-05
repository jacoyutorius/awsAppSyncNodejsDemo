"use strict";
/**
 * This shows how to use standard Apollo client on Node.js
 */

global.WebSocket = require('ws');
require('es6-promise').polyfill();
require('isomorphic-fetch');

// Require exports file with endpoint and auth info
const aws_exports = require('./aws-exports').default;

// Require AppSync module
const AUTH_TYPE = require('aws-appsync/lib/link/auth-link').AUTH_TYPE;
const AWSAppSyncClient = require('aws-appsync').default;

const url = aws_exports.ENDPOINT;
const region = aws_exports.REGION;
const type = AUTH_TYPE.API_KEY;

// If you want to use AWS...
const AWS = require('aws-sdk');
AWS.config.update({
  region: aws_exports.REGION,
  credentials: new AWS.Credentials({
    accessKeyId: aws_exports.AWS_ACCESS_KEY_ID,
    secretAccessKey: aws_exports.AWS_SECRET_ACCESS_KEY
  })
});
const credentials = AWS.config.credentials;

// Import gql helper and craft a GraphQL query
const gql = require('graphql-tag');
// const query = gql(`query queryAll {
//   listBackbars(
//     limit: 3
//   ) {
//     items {
//       name
//       material
//       recepe
//       tips
//       updated_at
//     }
//   }
// }
// `);
const query = gql(`query queryBackbarsByGsiKeywords {
  queryBackbarsByGsiKeywords(keywords: "レモン") {
    items {
      name
      material
      tips
      updated_at
    }
  }
}`)

// Set up Apollo client
const client = new AWSAppSyncClient({
  url: url,
  region: region,
  auth: {
    type: type,
    apiKey: aws_exports.API_KEY
  },
  disableOffline: true //Uncomment for AWS Lambda
});

client.hydrated().then(function (client) {
  client.query({
      query: query,
      fetchPolicy: 'network-only' //Uncomment for AWS Lambda
    })
    .then(function logData(data) {
      console.log('results of query: ', data);
      console.log(data.data.queryBackbarsByGsiKeywords.items)
    })
    .catch(console.error);
});