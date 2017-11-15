module.exports = {
  target: 'node',
  entry: './static/js/index.js',
  output: {
      path: __dirname+'/dist',
      filename: 'bundle.js'
  },
  module: {
    loaders: [
        {
            test:    /\.elm$/,
            exclude: [/elm-stuff/, /node_modules/],
            loader:  'elm-webpack-loader',
            options: { debug: false, verbose: true, warn: true }
        }, {
          test: /\.js$/,
          exclude: [/node_modules/],
          loader: 'babel-loader',
          options: {
            presets: ['env']
          }
        },
    ]
  },
  resolve: {
      extensions: ['.js', '.elm']
  },
  externals: [
    (function () {
      var IGNORES = [
        'electron', 'fs'
      ];
      return function (context, request, callback) {
        if (IGNORES.indexOf(request) >= 0) {
          return callback(null, "require('" + request + "')");
        }
        return callback();
      };
    })()
  ]
}
