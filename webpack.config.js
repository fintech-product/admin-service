const webpack = require('webpack'),
  path = require('path'),
  BundleAnalyzerPlugin = require('webpack-bundle-analyzer').BundleAnalyzerPlugin;

module.exports = {
  target: 'node',
  entry: './src/app.ts',
  module: {
    rules: [
      {
        test: /\.ts$/,
        exclude: /node_modules/,
        use: {
          loader: "ts-loader",
        }
      }
    ]
  },
  resolve: {
    extensions: [".ts", ".js"]
  },
  output: {
    filename: 'app.js',
    path: path.resolve(__dirname, 'dist')
  },
  plugins: [
    new webpack.IgnorePlugin({ resourceRegExp: /^pg-native$/ }),
    new BundleAnalyzerPlugin()
  ]
};
