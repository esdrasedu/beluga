import React from "react";

export class Filter extends React.Component {

	constructor(props) {
		super(props);
		this.handleChange = this.handleChange.bind(this);
		this.state = {delay: 2000, timeout: 0, text: ""};
	}

	handleChange(e){
		this.setState({text: e.target.value});
		if (this.props.onChange) {
			clearTimeout(this.state.timeout);
			this.state.timeout = setTimeout(function() {
				this.props.onChange(this.state.text);
			}.bind(this), this.state.delay);
    	}
	}

	render(){
		return (
			<input 
			type="text"
			className="form-control"
			value={this.state.text}
	        placeholder={this.props.placeholder}
	        onChange={this.handleChange} />
      );
	}
}