import React from "react";
import ReactDOM from "react-dom";
import { Jumbotron, FormGroup, FormControl, ControlLabel } from 'react-bootstrap';

export class Upload extends React.Component {
    constructor(props) {
        super(props);
        this.handleChange = this.handleChange.bind(this);
    }

    attachNode(node) {
        this._form = ReactDOM.findDOMNode(node);
    }

    handleChange() {
        this._form.submit();
    }

    render() {
        return (
                <Jumbotron>
                <h1>Beluga desafio</h1>
                <p>Bem-vindo ao desafio da Beluga</p>
                <form method="POST" encType="multipart/form-data" ref={this.attachNode.bind(this)}>
                <FormGroup>
                <ControlLabel bsClass="btn btn-default btn-primary btn-lg">Clique aqui para fazer uploader do csv
                <FormControl id="hidden" onChange={this.handleChange} type="file" />
                </ControlLabel>
                </FormGroup>
                </form>
                </Jumbotron>
        );
    }
}
