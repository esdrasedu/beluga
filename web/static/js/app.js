import React from "react";
import ReactDOM from "react-dom";
import {Upload} from "upload";
import {Table} from "table";
import {Socket} from "phoenix";

class App extends React.Component {
    constructor(props) {
        super(props);

        this.state = {lines: []};

        let socket = new Socket("/socket");
        socket.connect();

        let channel = socket.channel("beluga");
        channel.on("update", resp => {
            this.setState({lines: resp.lines});
        });
        channel
            .join()
            .receive("ok", resp => {
                channel.push("init");
            });
    }

    render() {
        return(
                <div>
                <Upload/>
                <Table lines={this.state.lines}/>
                </div>
        );
    }
}

ReactDOM.render(
    <App/>,
    document.getElementById('app')
);
