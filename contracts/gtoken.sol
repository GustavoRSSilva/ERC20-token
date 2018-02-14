pragma solidity ^0.4.20;


contract ERC20Interface {
    function totalSupply() public constant returns (uint);
    function balanceOf(address tokenOwner) public constant returns (uint balance);
    function allowance(address tokenOwner, address spender) public constant returns (uint remaining);
    function transfer(address to, uint tokens) public returns (bool success);
    function approve(address spender, uint tokens) public returns (bool success);
    function transferFrom(address from, address to, uint tokens) public returns (bool success);

    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}


contract Token is ERC20Interface {

    mapping (address => uint256) internal balances;
    mapping (address => mapping (address => uint256)) internal allowed;
    uint256 public totalSupply;

    function transfer(address _to, uint256 _value) public returns (bool success) {

        if (balances[msg.sender] >= _value && _value > 0) {
            balances[msg.sender] -= _value;
            balances[_to] += _value;
            Transfer(msg.sender, _to, _value);
            return true;
        } else { return false; }
    }


    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {

        if (balances[_from] >= _value && allowed[_from][msg.sender] >= _value && _value > 0) {

            balances[_to] += _value;
            balances[_from] -= _value;
            allowed[_from][msg.sender] -= _value;
            Transfer(_from, _to, _value);
            return true;

        } else {
            return false;
        }
    }

    function balanceOf(address _owner) public constant returns (uint balance){

        return balances[_owner];
    }


    function approve(address spender, uint tokens) public returns (bool success) {

        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address tokenOwner, address spender) public constant returns (uint remaining) {

        return allowed[_owner][_spender];
    }
}


contract GTOKEN is Token {

    function GTOKEN() public {
        balances[msg.sender] = 1000;    // creator gets all initial tokens
        totalSupply = 1000;             // total supply of token
        name = "Enlight";               // name of token
        decimals = 0;                  // amount of decimals
        symbol = "ENLT";                // symbol of token
    }

    function () {
        //if ether is sent to this address, send it back.
        revert();
    }

    string public name;
    uint8 public decimals;
    string public symbol;

    /* Approves and then calls the receiving contract */
    function approveAndCall(address _spender, uint256 _value, bytes _extraData) public returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);

        if (
        !_spender.call(
        bytes4(bytes32(keccak256("receiveApproval(address,uint256,address,bytes)"))),
        msg.sender, _value, this, _extraData
        )
        ) { revert(); }

        return true;
    }
}
