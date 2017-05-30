import React from "react";
import ReactDOM from "react-dom";
import {Upload} from "upload";
import {Filter} from "filter";
import {Table} from "table";
import {Chart} from "chart";
import {Socket} from "phoenix";
import {Tabs, Tab} from 'react-bootstrap';

class App extends React.Component {

    constructor(props) {
        super(props);

        this.handleChange = this.handleChange.bind(this);
        this.handleFilter = this.handleFilter.bind(this);

        let socket = new Socket("/socket");
        let channel = socket.channel("beluga");
        channel.on("update", resp => {
            this.setState({
                lines: resp.lines,
                chart: {
                    title: {text: ""},
                    xAxis: {categories: resp.chart.axis},
                    series: resp.chart.series
                },
                filter: resp.filter
            });
        });
        channel.join().receive("ok", resp => {
            channel.push("init");
        });

        this.state = {
            lines: [],
            chart: {
                title: {text: ""},
                xAxis: {categories: []},
                series: []
            },
            filter: "",
            channel: channel
        };

        socket.connect();
    }

    handleChange(filter) {
        this.setState({filter: filter});
    }
    handleFilter(filter) {
        this.state.channel.push("filter", filter);
    }

    render() {
        return(
                <div>
                <Upload/>
                <Filter text={this.state.filter} placeholder="Filtro (exemplo 24/10/2016 SP)" onChange={this.handleChange} onFilter={this.handleFilter}/>
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
