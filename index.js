'use strict';

const BackBar = require('./libs/BackBar');
const backBar = new BackBar();

(async () => {
  const ret = await backBar.queryBackbarsByKeywords("ジン");
  console.log("ret", ret)
})()