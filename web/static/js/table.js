import React from "react";
import ReactDOM from "react-dom";

export class Table extends React.Component {

    render(){
        return (
                <table className="table table-striped table-hover">
                <thead>
                <tr>
                <th>UUID</th>
                <th>Estado</th>
                <th>Metrica</th>
                <th>Valor</th>
                <th>Data</th>
                </tr>
                </thead>
                <tbody>
                {this.props.lines.length > 0 ?
                 this.props.lines.map((item) =>
                                      <tr key={item.uuid}>
                                      <td>{item.uuid}</td>
                                      <td>{item.state}</td>
                                      <td>{item.metric}</td>
                                      <td>{item.value}</td>
                                      <td>{item.date}</td>
                                      </tr>
                                     ) : (
                                             <tr>
                                             <td className="text-center" colSpan="5">Sem dados</td>
                                             </tr>
                                     )}
            </tbody>
                </table>
        );
    }
}
