var _ = require('lodash');

exports.handler = (event, context, callback) => {
    console.log(_.now());
    callback(null);
}
