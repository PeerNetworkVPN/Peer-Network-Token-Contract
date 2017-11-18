pragma solidity ^0.4.15;


import './ERC20.sol';
import './SafeMath.sol';


contract PeerNetworkToken is ERC20 {

    using SafeMath for uint;

    string public constant symbol = "PNT";
    string public constant name = "Peer Network Token";
    uint8 public constant decimals = 18;

    uint256 public constant INITIAL_SUPPLY = 100000000 * (10 ** uint256(decimals));

    mapping (address => uint) public balances;
    mapping (address => mapping (address => uint)) public allowed;

    modifier validDestination(address _to) {
        require(_to != address(0x0));
        require(_to != address(this));
        _;
    }

    function PeerNetworkToken() public {
        balances[msg.sender] = INITIAL_SUPPLY;
    }


    function totalSupply() public constant returns (uint256) {
        return INITIAL_SUPPLY;
    }

    function balanceOf(address _owner) public constant returns (uint256) {
        return balances[_owner];
    }

    function transfer(address _to, uint256 _value) public validDestination(_to) returns (bool) {
        require(_value > 0);

        balances[msg.sender] = balances[msg.sender].sub(_value);
        balances[_to] = balances[_to].add(_value);

        Transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public validDestination(_to) returns (bool) {
        require(_value > 0);

        balances[_from] = balances[_from].sub(_value);
        balances[_to] = balances[_to].add(_value);
        allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
        Transfer(_from, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value) public returns (bool) {
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender) public constant returns (uint256) {
        return allowed[_owner][_spender];
    }

    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

}