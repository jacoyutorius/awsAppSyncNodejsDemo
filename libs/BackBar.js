'use strict';
global.WebSocket = require('ws');
require('es6-promise').polyfill();
require('isomorphic-fetch');

module.exports = class BackBar {
  constructor() {
    this.aws_exports = require('./aws-exports').default;
    this.AUTH_TYPE = require('aws-appsync/lib/link/auth-link').AUTH_TYPE;
    this.AWSAppSyncClient = require('aws-appsync').default;

    const url = this.aws_exports.ENDPOINT;
    const region = this.aws_exports.REGION;
    const type = this.AUTH_TYPE.API_KEY;

    this.AWS = require('aws-sdk');
    this.AWS.config.update({
      region,
      credentials: new this.AWS.Credentials({
        accessKeyId: this.aws_exports.AWS_ACCESS_KEY_ID,
        secretAccessKey: this.aws_exports.AWS_SECRET_ACCESS_KEY
      })
    });

    this.gql = require('graphql-tag');

    this.client = new this.AWSAppSyncClient({
      url,
      region,
      auth: {
        type,
        apiKey: this.aws_exports.API_KEY
      },
      disableOffline: true
    });
  }

  // thanks for https://aws-amplify.github.io/docs/js/api
  async queryBackbarsByKeywords(keywords) {
    const query = this.gql(`query queryBackbarsByGsiKeywords {
      queryBackbarsByGsiKeywords(keywords: "${keywords}") {
        items {
          name
          material
          tips
          updated_at
        }
      }
    }`)

    await this.client.hydrated();
    const result = await this.client.query({
      query: query,
      fetchPolicy: 'network-only'
    });
    return result.data.queryBackbarsByGsiKeywords;
  }
}