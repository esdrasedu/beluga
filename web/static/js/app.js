import React from "react";
import ReactDOM from "react-dom";
import {Upload} from "upload";
import {Table} from "table";
import {Chart} from "chart";
import {Socket} from "phoenix";
import {Tabs, Tab} from 'react-bootstrap';

class App extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            lines: [],
            chart: {
                title: {text: ""}
            }
        };

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

    handleSelect(eventKey) {
        event.preventDefault();
    }

    render() {
        return(
                <div>
                <Upload/>
                <Tabs defaultActiveKey={1} id="tabs">
                <Tab eventKey={1} title="Tabela">
                <Table lines={this.state.lines}/>
                </Tab>
                <Tab eventKey={2} title="Grafico">
                <Chart chart={this.state.chart}/>
                </Tab>
                </Tabs>
                </div>
        );
    }
}

ReactDOM.render(
    <App/>,
    document.getElementById('app')
);
