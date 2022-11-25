// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Superheroe{

    string private _name;
    mapping(string => uint) private _poderes;
    address private _owner;

    constructor(string memory name_){
        _name = name_;
        _owner = msg.sender;
    }

    function name() public view returns (string memory){
        return _name;
    }

    function set_power(string memory poder, uint valor) public{
        require(msg.sender == _owner, "Solo el owner puede setear poderes");
        _poderes[poder] = valor;
    }

    function get_power(string memory poder) public view returns (uint){
        return _poderes[poder];
    }


}