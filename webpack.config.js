module.exports =
{
  entry: './src/seaspray.coffee',
  output: {
    filename: 'index.js',
    library: 'Seaspray',
    libraryTarget: 'umd'
  },
  module: {
    loaders: [
      { test: /\.coffee$/, loader: 'coffee' }
    ]
  }
}
