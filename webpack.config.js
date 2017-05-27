var ExtractTextPlugin = require("extract-text-webpack-plugin");
var CopyWebpackPlugin = require("copy-webpack-plugin");
var Path = require("path");
module.exports = {
  entry: ["./web/static/css/app.css", "./web/static/js/app.js"],
  output: {
    path: Path.resolve(__dirname, "priv/static"),
    filename: "js/app.js"
  },
  resolve: {
    modules: ["node_modules", __dirname + "/web/static/js"],
    alias: {
      phoenix: __dirname + '/deps/phoenix/web/static/js/phoenix.js'
    }
  },
  module: {
    loaders: [{
      test: /\.js$/,
      exclude: /node_modules/,
      loader: "babel-loader",
      include: __dirname,
      query: {presets: ["es2015", "react"]}
    },
    {
      test: /\.css$/,
      loader: ExtractTextPlugin.extract("css-loader")
    }]
  },
  plugins: [
      new ExtractTextPlugin("css/app.css"),
      new CopyWebpackPlugin([{from: "./web/static/assets"}])
  ]
};
