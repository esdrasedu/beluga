let React = require('react');
let ReactHighcharts = require('react-highcharts');

export class Chart extends React.Component {
    render() {
        return <ReactHighcharts config={this.props.chart} ref="chart"></ReactHighcharts>;
    }
}
