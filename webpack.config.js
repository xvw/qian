module.exports = {
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
            loader:  'elm-webpack-loader?verbose=true&warn=true',
        }
    ]
  },
  resolve: {
      extensions: ['.js', '.elm']
  }
}