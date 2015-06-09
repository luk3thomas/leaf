module.exports =
{
  entry: './src/leaf.coffee',
  output: {
    filename: 'index.js',
    library: 'Leaf',
    libraryTarget: 'umd'
  },
  module: {
    loaders: [
      { test: /\.coffee$/, loader: 'coffee' }
    ]
  }
}
