import React from "react";
import ReactDOM from "react-dom";
import {Upload} from "upload";

class App extends React.Component {
    render() {
        return (<Upload />);
    }
}

ReactDOM.render(
    <App/>,
    document.getElementById('app')
);
